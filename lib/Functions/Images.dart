import 'dart:io';
import 'dart:typed_data';

import 'package:btpp/Functions/Utility.dart';
import 'package:btpp/Pages/Actu/index.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';

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

void showFullFileImage(BuildContext context, File file, {Object key}) {
  Navigator.push(context, new HeroDialogRoute(builder: (BuildContext context) {
    return new ZoomableImage.memory(memory: file.readAsBytesSync(), tag: key);
  }));
}

Widget currentUserImageWidget = CurrentUserImage();

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> assetImageToFile(Asset image) async {
  String path = await _localPath;

  Uint8List a = await assetToByte(image);
  String __localPath = '$path/${image.name}';
  File file = File(__localPath);

  file.writeAsBytes(a);
  return file;
}
