import 'dart:io';
import 'dart:typed_data';
import 'package:btpp/Pages/Actu/index.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

import 'package:multi_image_picker/multi_image_picker.dart';

Future<List<Asset>> multiImagePicker([max = 10]) async {
  try {
    return await MultiImagePicker.pickImages(
      maxImages: max,
      enableCamera: true,
    );
  } on PlatformException catch (e) {
    switch (e.code) {
      case "CANCELLED":
        print('No images were selected');
        return [];

      case "PERMISSION_DENIED":
        print('Permission denied');
        return [];
        break;
      case "PERMISSION_PERMANENTLY_DENIED":
        print(e.message);
        return [];
        break;
      default:
        print(e);
        return [];
    }
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

void showFullNetworkImage(BuildContext context, String link, {Object key}) {
  Navigator.push(context, new HeroDialogRoute(builder: (BuildContext context) {
    return new ZoomableImage(url: link, tag: key);
  }));
}

void showFullMemoryImage(BuildContext context, Uint8List byte, {Object key}) {
  Navigator.push(context, new HeroDialogRoute(builder: (BuildContext context) {
    return new ZoomableImage.memory(memory: byte, tag: key);
  }));
}
