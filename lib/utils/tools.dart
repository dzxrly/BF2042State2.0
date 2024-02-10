import 'dart:io';
import 'dart:math';

import 'package:battlefield_2042_state/utils/file_exporter/unsupported_file_exporter.dart'
    if (dart.library.html) 'package:battlefield_2042_state/utils/file_exporter/web_file_exporter.dart'
    if (dart.library.io) 'package:battlefield_2042_state/utils/file_exporter/android_file_exporter.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

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

  static String parseDoubleAsFixedAndENUSFormat(
      double value, int fractionDigits) {
    final NumberFormat numberFormat = NumberFormat.decimalPattern('en_us');
    // check value is NaN
    return value.isNaN || value.isNegative
        ? 'NaN'
        : numberFormat
            .format(double.parse(value.toStringAsFixed(fractionDigits)));
  }

  static String parseIntAsENUSFormat(int value) {
    final NumberFormat numberFormat = NumberFormat.decimalPattern('en_us');
    // check value is NaN
    return value.isNaN || value.isNegative ? 'NaN' : numberFormat.format(value);
  }
}

class PlatformUtils {
  static bool _isWeb() {
    return kIsWeb == true;
  }

  static bool _isAndroid() {
    return _isWeb() ? false : Platform.isAndroid;
  }

  static bool _isIOS() {
    return _isWeb() ? false : Platform.isIOS;
  }

  static bool _isMacOS() {
    return _isWeb() ? false : Platform.isMacOS;
  }

  static bool _isWindows() {
    return _isWeb() ? false : Platform.isWindows;
  }

  static bool _isFuchsia() {
    return _isWeb() ? false : Platform.isFuchsia;
  }

  static bool _isLinux() {
    return _isWeb() ? false : Platform.isLinux;
  }

  static bool get isWeb => _isWeb();

  static bool get isAndroid => _isAndroid();

  static bool get isIOS => _isIOS();

  static bool get isMacOS => _isMacOS();

  static bool get isWindows => _isWindows();

  static bool get isFuchsia => _isFuchsia();

  static bool get isLinux => _isLinux();
}

class WidthBreakpoints {
  static double minXS = 0.0;
  static double minFoldedScreen = 340.0;
  static double minS = 600.0;
  static double minM = 1024.0;
  static double minL = 1440.0;
  static double minXL = 1920.0;
}

abstract class FileExporter {
  Future exportFile(String fileName, String content);

  factory FileExporter() => fileExporter();
}
