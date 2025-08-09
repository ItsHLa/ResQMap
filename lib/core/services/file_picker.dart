


import 'package:file_picker/file_picker.dart';

class FilePickerHelper {
  static Future<FilePickerResult?> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png'],
    );

    return result;
  }
}
