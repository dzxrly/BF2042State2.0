// check if can use html library
import 'dart:html';

import 'package:battlefield_2042_state/utils/tools.dart';

FileExporter fileExporter() => WebFileExporter();

class WebFileExporter implements FileExporter {
  static void createDownloadForWeb(String fileName, String content) {}

  @override
  Future exportFile(String fileName, String content) {
    try {
      final blob = Blob([content]);
      final url = Url.createObjectUrlFromBlob(blob);
      final anchor = AnchorElement(href: url)
        ..setAttribute('download', fileName)
        ..click();
      Url.revokeObjectUrl(url);
      return Future.value('success');
    } catch (e) {
      return Future.error('error');
    }
  }
}
