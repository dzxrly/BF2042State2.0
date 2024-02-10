import 'dart:io';

import 'package:battlefield_2042_state/utils/tools.dart';
import 'package:saf/saf.dart';

FileExporter fileExporter() => AndroidFileExporter();

class AndroidFileExporter implements FileExporter {
  @override
  Future exportFile(String fileName, String content) async {
    final safInstance = Saf('/storage/emulated/0/Documents');
    bool? isGranted = await safInstance.getDirectoryPermission(isDynamic: true);
    if (isGranted != null && isGranted) {
      // Perform some file operations
      final file = File('/storage/emulated/0/Documents/$fileName');
      await file
          .writeAsString(content)
          .then((value) => {Future.value('success')})
          .catchError((error) {
        Future.error('error');
      });
    } else {
      return Future.error('denied');
    }
  }
}
