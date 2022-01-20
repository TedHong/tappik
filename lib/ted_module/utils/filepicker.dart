import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';

class TDFilePicker {
  String? _fileName;
  String? _saveAsFileName;
  List<PlatformFile>? _paths;
  String? _directoryPath;
  String? _extension;
  bool _isLoading = false;
  bool _userAborted = false;
  bool _multiPick = false;
  FileType _pickingType = FileType.any;

  void _resetState() {
    _isLoading = true;
    _directoryPath = null;
    _fileName = null;
    _paths = null;
    _saveAsFileName = null;
    _userAborted = false;
  }

  
  Future<PlatformFile?> pickImgFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: ['jpg', 'png']);
      if (result != null) {
        // File file = File(result.files.single.path.toString());
        // return file;
        return result.files.single;
      }
    } on PlatformException catch (e) {
      print('Unsupported operation' + e.toString());
      //return '-1';
    } catch (e) {
      print(e.toString());
      //return '-1';
    }
  }

  void pickFiles() async {
    try {
      _directoryPath = null;
      _paths = (await FilePicker.platform.pickFiles(
        type: _pickingType,
        allowMultiple: _multiPick,
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
      ))
          ?.files;
    } on PlatformException catch (e) {
      print('Unsupported operation' + e.toString());
    } catch (e) {
      print(e.toString());
    }

    _isLoading = false;
    _fileName = _paths != null ? _paths!.map((e) => e.name).toString() : '...';
    _userAborted = _paths == null;
  }
}
