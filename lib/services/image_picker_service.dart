import 'dart:io';
import 'package:bnaa/constants/app_colors.dart';
import 'package:bnaa/services/toast_service.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  static Future<File> getImageFromGallery() async {
    final _picker = ImagePicker();
    File? cropedFile;
    PickedFile? file =
        await _picker.getImage(source: ImageSource.gallery).then((pickedImage) {
      return pickedImage;
    }).catchError((e) {
      print(e);
      ToastService.showErrorToast('Something Wrong, Please Try Again');
      return null;
    });
    if (file != null) {
      cropedFile = await cropImage(image: file.path, height: 300, width: 300);
    }
    return cropedFile!;
  }

  static Future<List<File>> getImagesFromGallery({isCrop = false}) async {
    final _picker = ImagePicker();
    final List<File> cropedImages = [];
    final List<XFile> images = await _picker.pickMultiImage();
    if (isCrop) {
      for (XFile image in images) {
        final cropedImage =
            await cropImage(image: image.path, height: 600, width: 600);
        cropedImages.add(File(cropedImage.path));
      }
    }else{
      for (XFile image in images) {
           cropedImages.add(File(image.path));
      }
    }

    return cropedImages;
  }

  static Future<File> cropImage(
      {@required image, @required height, @required width}) async {
    File? croppedFile = await ImageCropper().cropImage(
        sourcePath: image,
        cropStyle: CropStyle.rectangle,
        aspectRatioPresets: [CropAspectRatioPreset.square],
        maxHeight: height,
        maxWidth: width,
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: '',
            showCropGrid: false,
            toolbarColor: AppColors.BLUE_COLOR,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            hideBottomControls: true,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          title: '',
        ));
    return croppedFile!;
  }
}
