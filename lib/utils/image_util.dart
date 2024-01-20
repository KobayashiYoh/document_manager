import 'package:image_picker/image_picker.dart';

class ImageUtil {
  static final _picker = ImagePicker();

  static Future<XFile?> pickImageFromGallery() async {
    final XFile? image;
    try {
      image = await _picker.pickImage(source: ImageSource.gallery);
    } catch (e) {
      throw Exception('Failed to pick image from gallery: $e');
    }
    return image;
  }

  static Future<XFile?> pickImageFromCamera() async {
    final XFile? image;
    try {
      image = await _picker.pickImage(source: ImageSource.camera);
    } catch (e) {
      throw Exception('Failed to pick image from camera: $e');
    }
    return image;
  }
}
