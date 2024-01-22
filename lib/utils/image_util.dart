import 'package:document_manager/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageUtil {
  static final _picker = ImagePicker();

  static Future<XFile?> pickCroppedImage({
    required ImageSource source,
    bool isIcon = false,
  }) async {
    XFile? image;
    try {
      final pickedImage = await _pickImage(source: source);
      image = await _clopImage(image: pickedImage, isIcon: isIcon);
    } catch (e) {
      throw Exception('Failed to pick image from gallery: $e');
    }
    return image;
  }

  static Future<XFile?> _pickImage({required ImageSource source}) async {
    XFile? image;
    try {
      image = await _picker.pickImage(source: source);
    } catch (e) {
      throw Exception('Failed to pick image: $e');
    }
    return image;
  }

  static Future<XFile?> _clopImage({
    required XFile? image,
    required bool isIcon,
  }) async {
    if (image == null) {
      return null;
    }
    CroppedFile? croppedFile;
    XFile? croppedImage;
    try {
      croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatio:
            isIcon ? const CropAspectRatio(ratioX: 1.0, ratioY: 1.0) : null,
        aspectRatioPresets: isIcon
            ? [CropAspectRatioPreset.square]
            : [CropAspectRatioPreset.original],
        uiSettings: [
          AndroidUiSettings(
            lockAspectRatio: isIcon ? true : false,
            toolbarColor: AppColors.main,
            toolbarWidgetColor: Colors.white,
            activeControlsWidgetColor: Colors.lightGreen,
          ),
          IOSUiSettings(
            minimumAspectRatio: isIcon ? 1.0 : null,
            resetButtonHidden: true,
            resetAspectRatioEnabled: false,
          ),
        ],
      );
    } catch (e) {
      throw Exception('Failed to crop image: $e');
    }
    if (croppedFile == null) {
      return null;
    }
    croppedImage = XFile(croppedFile.path);
    return croppedImage;
  }
}
