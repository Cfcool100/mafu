import 'package:image_picker/image_picker.dart';

class FilesPicker {
  final ImagePicker _image = ImagePicker();

  // ImagesPicker({this.file});

  Future<XFile?> fromCamera() async {
    final XFile? file = await _image.pickImage(source: ImageSource.camera);
    // FilePickerResult? result = await FilePicker.platform.pickFiles();

    return file;
  }

  Future<XFile?> fromGallery() async {
    final XFile? file = await _image.pickImage(source: ImageSource.gallery);

    return file;
  }
}
