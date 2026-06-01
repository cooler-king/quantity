import 'dart:io';

void main() {
  final lcovFile = File('coverage/coverage.lcov');
  if (!lcovFile.existsSync()) {
    print('Error: coverage/coverage.lcov not found!');
    exit(1);
  }

  final lines = lcovFile.readAsLinesSync();
  String currentFile = '';
  int totalLines = 0;
  int coveredLines = 0;

  final Map<String, double> fileCoverage = {};
  final Map<String, (int, int)> fileStats = {};
  final Map<String, List<int>> fileToUncovered = {};
  List<int> uncoveredLines = [];

  for (final line in lines) {
    if (line.startsWith('SF:')) {
      currentFile = line.substring(3).replaceAll('\\', '/');
      final libIndex = currentFile.indexOf('lib/');
      if (libIndex != -1) {
        currentFile = currentFile.substring(libIndex);
      }
      totalLines = 0;
      coveredLines = 0;
      uncoveredLines = [];
    } else if (line.startsWith('DA:')) {
      totalLines++;
      final parts = line.substring(3).split(',');
      if (parts.length > 1) {
        final lineNum = int.tryParse(parts[0]) ?? 0;
        final hits = int.tryParse(parts[1]) ?? 0;
        if (hits > 0) {
          coveredLines++;
        } else {
          uncoveredLines.add(lineNum);
        }
      }
    } else if (line.startsWith('end_of_record')) {
      if (totalLines > 0) {
        final percent = (coveredLines / totalLines) * 100;
        fileCoverage[currentFile] = percent;
        fileStats[currentFile] = (coveredLines, totalLines);
        if (uncoveredLines.isNotEmpty) {
          fileToUncovered[currentFile] = uncoveredLines;
        }
      }
    }
  }

  final sortedFiles = fileCoverage.keys.toList()
    ..sort((a, b) => fileCoverage[a]!.compareTo(fileCoverage[b]!));

  print('=== Code Coverage Summary ===');
  int grandTotal = 0;
  int grandCovered = 0;
  bool missingCoverage = false;

  for (final file in sortedFiles) {
    final percent = fileCoverage[file]!;
    final (cov, tot) = fileStats[file]!;
    grandTotal += tot;
    grandCovered += cov;
    if (percent < 100.0) {
      missingCoverage = true;
      print('${percent.toStringAsFixed(1)}% ($cov/$tot) - $file');
      final list = fileToUncovered[file] ?? [];
      final srcFile = File(file);
      if (srcFile.existsSync()) {
        final srcLines = srcFile.readAsLinesSync();
        for (final lineNum in list) {
          if (lineNum > 0 && lineNum <= srcLines.length) {
            print('  Line $lineNum: ${srcLines[lineNum - 1].trim()}');
          }
        }
      }
    }
  }

  final totalPercent = grandTotal > 0 ? (grandCovered / grandTotal) * 100 : 0.0;
  print('=============================');
  print(
      'Total Project Coverage: ${totalPercent.toStringAsFixed(2)}% ($grandCovered/$grandTotal)');

  if (missingCoverage || totalPercent < 100.0) {
    print('Error: Project coverage is below 100.0%!');
    exit(1);
  }

  print('Success: Perfect 100% test coverage verified.');
}
