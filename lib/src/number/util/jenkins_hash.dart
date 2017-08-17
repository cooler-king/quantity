part of number;

/// Generates a unique hash for a set of objects.
///
int hashObjects(Iterable<Object> objects) {
  int hash = 0;
  objects.forEach((obj) {
    hash = 0x1fffffff & (hash + obj.hashCode);
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    hash = hash ^ (hash >> 6);
  });
  hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
  hash = hash ^ (hash >> 11);
  return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
}
