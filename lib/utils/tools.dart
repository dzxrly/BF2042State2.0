import 'dart:math';

class UtilTools {
  static bool versionCompare(String currentVersion, String latestVersion) {
    // compare version name between a and b (like 1.0.0 and 1.0.1)
    // return true if a < b

    // split version name by dot
    List<String> a = currentVersion.split('.');
    List<String> b = latestVersion.split('.');

    // version a from ["1", "0", "0"] to 100
    int aVersion = 0;
    for (int i = 0; i < a.length; i++) {
      aVersion += int.parse(a[i]) * pow(10, a.length - i - 1).toInt();
    }
    // version b from ["1", "0", "1"] to 101
    int bVersion = 0;
    for (int i = 0; i < b.length; i++) {
      bVersion += int.parse(b[i]) * pow(10, b.length - i - 1).toInt();
    }
    // compare
    return aVersion < bVersion;
  }
}
