import 'package:image_picker/image_picker.dart';

class ImageUtil {
  static Future<XFile?> pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image;
    try {
      image = await picker.pickImage(source: ImageSource.gallery);
    } catch (e) {
      throw Exception('Failed to pick image: $e');
    }
    return image;
  }
}
