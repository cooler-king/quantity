import 'dart:io';
import 'dart:convert';
import 'dart:math' show min;

final Map<String, String> nistNameVarMap = {
  'alpha particle mass': 'alphaParticleMass',
  'atomic mass constant': 'atomicMass',
  'Avogadro constant': 'avogadro',
  'Angstrom star': 'angstromStar',
  'Bohr magneton': 'bohrMagneton',
  'Bohr radius': 'bohrRadius',
  'Boltzmann constant': 'boltzmannConstant',
  'characteristic impedance of vacuum': 'characteristicImpedanceOfVacuum',
  'classical electron radius': 'classicalElectronRadius',
  'Compton wavelength': 'comptonWavelength',
  'conductance quantum': 'conductanceQuantum',
  'deuteron mass': 'deuteronMass',
  'electron g factor': 'electronGFactor',
  'electron mass': 'electronMass',
  'elementary charge': 'elementaryCharge',
  'Faraday constant': 'faradayConstant',
  'fine-structure constant': 'fineStructureConstant',
  'first radiation constant': 'firstRadiationConstant',
  'Hartree energy': 'hartreeEnergy',
  'helion mass': 'helionMass',
  'molar gas constant': 'gasConstantMolar',
  'Josephson constant': 'josephsonConstant',
  'Loschmidt constant (273.15 K, 101.325 kPa)': 'loschmidtStdAtm',
  'mag. flux quantum': 'magneticFluxQuantum',
  'molar Planck constant': 'molarPlanck',
  'molar volume of ideal gas (273.15 K, 100 kPa)': 'molarVolume100kPa',
  'molar volume of ideal gas (273.15 K, 101.325 kPa)': 'molarVolumeStdAtm',
  'muon g factor': 'muonGFactor',
  'muon mass': 'muonMass',
  'neutron g factor': 'neutronGFactor',
  'neutron mass': 'neutronMass',
  'Newtonian constant of gravitation': 'newtonianConstantOfGravitation',
  'nuclear magneton': 'nuclearMagneton',
  'Planck constant': 'planckConstant',
  'reduced Planck constant': 'hBar',
  'Planck length': 'planckLength',
  'Planck mass': 'planckMass',
  'Planck temperature': 'planckTemperature',
  'Planck time': 'planckTime',
  'proton g factor': 'protonGFactor',
  'proton mass': 'protonMass',
  'Rydberg constant': 'rydberg',
  'Sackur-Tetrode constant (1 K, 100 kPa)': 'sackurTetrode100kPa',
  'Sackur-Tetrode constant (1 K, 101.325 kPa)': 'sackurTetrodeStdAtm',
  'second radiation constant': 'secondRadiationConstant',
  'speed of light in vacuum': 'speedOfLightVacuum',
  'Stefan-Boltzmann constant': 'stefanBoltzmann',
  'tau Compton wavelength': 'tauComptonWavelength',
  'tau mass': 'tauMass',
  'Thomson cross section': 'thomsonCrossSection',
  'vacuum electric permittivity': 'vacuumElectricPermittivity',
  'vacuum mag. permeability': 'vacuumMagneticPermeability',
  'von Klitzing constant': 'vonKlitzingConstant',
  'weak mixing angle': 'weakMixingAngle',
  'Wien wavelength displacement law constant': 'wienDisplacement',
};

Future<void> main() async {
  print('Fetching latest NIST CODATA constants...');
  String content;
  try {
    final client = HttpClient();
    final request = await client.getUrl(Uri.parse('https://physics.nist.gov/cuu/Constants/Table/allascii.txt'));
    final response = await request.close();
    if (response.statusCode == 200) {
      content = await response.transform(utf8.decoder).join();
      print('Successfully fetched live data.');
    } else {
      throw HttpException('HTTP status ${response.statusCode}');
    }
  } catch (e) {
    print('Failed to fetch from NIST: $e. Falling back to local nist_constants.txt.');
    final localFile = File('test/quantity_ext/txt/nist_constants.txt');
    if (!localFile.existsSync()) {
      print('Error: Local nist_constants.txt not found.');
      exit(1);
    }
    content = localFile.readAsStringSync();
  }

  final lines = content.split(RegExp(r'\r?\n'));
  final nistTableLines = <String>[];
  final nistValues = <String, Map<String, double>>{};

  var started = false;
  for (final line in lines) {
    if (line.contains('-----------------------------------------------------------------------------------------------------------------------------')) {
      started = true;
      continue;
    }
    if (!started) continue;
    if (line.length < 85) continue;

    final name = line.substring(0, 60).trim();
    final valueStrRaw = line.substring(60, 85).trim();
    if (name.isEmpty || valueStrRaw.isEmpty) continue;

    // Save raw line for test file syncing
    nistTableLines.add(line);

    var valueStr = valueStrRaw.replaceAll(' ', '');
    var uncert = 0.0;
    if (valueStr.contains('...')) {
      valueStr = valueStr.replaceAll('...', '');
      uncert = 0.0;
    } else {
      var uncertStr = line.substring(85, min(line.length, 110)).replaceAll(' ', '').trim();
      if (uncertStr.contains('exact')) {
        uncert = 0.0;
      } else if (uncertStr.isNotEmpty) {
        uncert = double.parse(uncertStr);
      }
    }
    final value = double.parse(valueStr);
    nistValues[name] = {'value': value, 'uncert': uncert};
  }

  print('Parsed ${nistValues.length} constants from CODATA.');

  // Find where variables are defined
  final libDir = Directory('lib');
  final files = libDir.listSync(recursive: true).whereType<File>().toList();
  final varFileMap = <String, File>{};

  for (final entry in nistNameVarMap.entries) {
    final varName = entry.value;
    for (final file in files) {
      if (!file.path.endsWith('.dart')) continue;
      final fileContent = file.readAsStringSync();
      // Search for the constant declaration
      final regex = RegExp('const\\s+([A-Za-z0-9_<>]+)\\s+$varName\\s*=\\s*');
      if (regex.hasMatch(fileContent)) {
        varFileMap[varName] = file;
        break;
      }
    }
  }

  // Update constants in place
  final modifiedFiles = <File>{};
  for (final entry in nistNameVarMap.entries) {
    final nistName = entry.key;
    final varName = entry.value;

    final nistData = nistValues[nistName];
    if (nistData == null) {
      print('Warning: constant "$nistName" not found in fetched CODATA values.');
      continue;
    }

    final file = varFileMap[varName];
    if (file == null) {
      print('Warning: could not locate declaration of variable "$varName" in lib/.');
      continue;
    }

    final newValue = nistData['value']!;
    final newUncert = nistData['uncert']!;
    final relativeUncert = newValue == 0.0 ? 0.0 : (newUncert / newValue).abs();

    var fileContent = file.readAsStringSync();
    final regex = RegExp('const\\s+([A-Za-z0-9_<>]+)\\s+$varName\\s*=\\s*([^;]+);', multiLine: true);

    final match = regex.firstMatch(fileContent);
    if (match == null) {
      print('Error: Failed to match declaration of $varName in ${file.path}');
      continue;
    }

    final type = match.group(1)!;
    var expr = match.group(2)!;

    // Update expression
    final doubleConstRegex = RegExp(r'Double\.constant\(\s*[^)]+\s*\)');
    expr = expr.replaceFirst(doubleConstRegex, 'Double.constant($newValue)');

    final uncertRegex = RegExp(r'uncert:\s*[0-9.eE+-]+');
    if (expr.contains(uncertRegex)) {
      if (relativeUncert == 0.0) {
        expr = expr.replaceFirst(RegExp(r',\s*uncert:\s*[0-9.eE+-]+'), '');
      } else {
        expr = expr.replaceFirst(uncertRegex, 'uncert: $relativeUncert');
      }
    } else if (relativeUncert > 0.0) {
      final lastIndex = expr.lastIndexOf(')');
      if (lastIndex != -1) {
        expr = '${expr.substring(0, lastIndex)}, uncert: $relativeUncert${expr.substring(lastIndex)}';
      }
    }

    final originalFull = match.group(0)!;
    final updatedFull = 'const $type $varName = $expr;';

    if (originalFull != updatedFull) {
      fileContent = fileContent.replaceFirst(originalFull, updatedFull);
      file.writeAsStringSync(fileContent);
      modifiedFiles.add(file);
      print('Updated $varName in ${file.path}: value = $newValue, relative uncert = $relativeUncert');
    }
  }

  // Update the test verification file
  final localTestFile = File('test/quantity_ext/txt/nist_constants.txt');
  final testFileDir = Directory(localTestFile.parent.path);
  if (!testFileDir.existsSync()) {
    testFileDir.createSync(recursive: true);
  }
  localTestFile.writeAsStringSync('${nistTableLines.join('\n')}\n');
  print('Updated local verification file test/quantity_ext/txt/nist_constants.txt');

  // Scan and update the tests under test/
  print('Scanning and updating hardcoded expected values in test/ files...');
  final testDir = Directory('test');
  final testFiles = testDir.listSync(recursive: true).whereType<File>().toList();

  for (final file in testFiles) {
    if (!file.path.endsWith('.dart')) continue;
    var fileContent = file.readAsStringSync();
    var modified = false;

    for (final entry in nistNameVarMap.entries) {
      final nistName = entry.key;
      final varName = entry.value;

      final nistData = nistValues[nistName];
      if (nistData == null) continue;
      final newValue = nistData['value']!;

      // Pattern: expect(varName.valueSI.toDouble(), old_value)
      final expectRegex = RegExp('expect\\(\\s*$varName\\.valueSI\\.toDouble\\(\\),\\s*(-?[0-9.eE+-]+)\\s*\\)');
      if (expectRegex.hasMatch(fileContent)) {
        fileContent = fileContent.replaceAllMapped(expectRegex, (m) {
          modified = true;
          return 'expect($varName.valueSI.toDouble(), $newValue)';
        });
      }
    }

    if (modified) {
      file.writeAsStringSync(fileContent);
      modifiedFiles.add(file);
      print('Updated hardcoded expected value(s) in test file: ${file.path}');
    }
  }

  if (modifiedFiles.isNotEmpty) {
    print('Formatting modified files...');
    for (final file in modifiedFiles) {
      final result = Process.runSync('dart', ['format', file.path]);
      if (result.exitCode != 0) {
        print('Error formatting ${file.path}: ${result.stderr}');
      }
    }
  }

  print('NIST CODATA constants synchronization completed.');
}
