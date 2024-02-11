import 'dart:developer';
import 'dart:io';

import 'package:battlefield_2042_state/utils/tools.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:saf/saf.dart';

FileExporter fileExporter() => AndroidFileExporter();

class AndroidFileExporter implements FileExporter {
  @override
  Future exportFile(String fileName, String content) async {
    // in API 30 and above, dir is Documents, in API 29 and below, dir is Downloads
    try {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      var dir = '/storage/emulated/0/Documents';
      if (androidInfo.version.sdkInt <= 30) {
        final Directory? downloadsDir = await getDownloadsDirectory();
        if (downloadsDir != null) {
          dir = downloadsDir.path.toString();
        } else {
          // create a Downloads directory in app directory
          final Directory appDocDir = await getApplicationDocumentsDirectory();
          dir = '${appDocDir.path}/Downloads';
          final Directory newDir = Directory(dir);
          if (!newDir.existsSync()) {
            newDir.createSync();
          }
        }
      }
      log(dir);
      final safInstance = Saf(dir);
      bool? isGranted =
          await safInstance.getDirectoryPermission(isDynamic: true);
      if (isGranted != null && isGranted) {
        // Perform some file operations
        final file = File('$dir/$fileName');
        await file
            .writeAsString(content)
            .then((value) => {Future.value('success')})
            .catchError((error) {
          throw 'error';
        });
      } else {
        throw 'denied';
      }
    } catch (e) {
      return Future.error('error');
    }
  }
}
