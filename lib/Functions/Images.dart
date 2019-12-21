import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'package:multi_image_picker/multi_image_picker.dart';

Future<List<Asset>> multiImagePicker([max = 10]) async {
  try {
    return await MultiImagePicker.pickImages(
      maxImages: max,
      enableCamera: true,
    );
  } on Exception catch (error) {
    throw Exception('Cannot fetcher');
  }
}

Future<File> imageFromCamera() async {
  return await ImagePicker.pickImage(
      source: ImageSource.camera, imageQuality: 70);
}

Future<File> imageFromGallery() async {
  return await ImagePicker.pickImage(
      source: ImageSource.gallery, imageQuality: 70);
}
