import 'package:battlefield_2042_state/utils/tools.dart';

FileExporter fileExporter() => throw UnimplementedError();

class UnsupportedFileExporter implements FileExporter {
  @override
  Future exportFile(String fileName, String content) {
    return Future.error(UnimplementedError());
  }
}
