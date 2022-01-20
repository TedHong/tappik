import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileManager {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<String> getLocalPath() async {
    return await _localPath;
  }

  Future<String> readFile(String fileName) async {
    try {
      final path = await getLocalPath();
      final file = await File('$path/$fileName');

      // 파일 읽기
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      return 'error';
    }
  }

  Future<List<String>> readFileAsLine(String fileName) async {
    try {
      final path = await getLocalPath();
      final file = await File('$path/$fileName');

      // 파일 읽기
      return await file.readAsLines();
    } catch (e) {
      return ['error'];
    }
  }

  Future<File> writeFile(String msg, String fileName) async {
    final path = await getLocalPath();
    final file = await File('$path/$fileName');

    // 파일 쓰기
    return file.writeAsString('$msg');
  }
}
