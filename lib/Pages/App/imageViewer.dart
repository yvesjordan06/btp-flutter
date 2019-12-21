import 'dart:io';
import 'dart:async';
import 'dart:typed_data';
import 'package:btpp/Functions/Images.dart';
import 'package:btpp/Functions/Utility.dart';
import 'package:btpp/utils/notifications.dart';
import 'package:flutter/services.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageViewer extends StatefulWidget {
  final List<File> gallery;
  const ImageViewer({Key key, this.gallery}) : super(key: key);

  @override
  _ImageViewerState createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  List images = List();
  @override
  void initState() {
    super.initState();
  }

  Widget buildGridView() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: images.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) => Container(
          //constraints: BoxConstraints(maxHeight: 250, maxWidth: 175),
          padding: EdgeInsets.all(16),
          child: AssetImageViewer(
            asset: images[index],
          )),
    );
  }

  Future<void> loadAssets() async {
    setState(() {
      images = List<Asset>();
    });

    List<Asset> resultList = List<Asset>();
    String error = 'No error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: true,
      );
    } on PlatformException catch (e) {
      error = e.message;
    }
    if (!mounted) return;

    setState(() {
      images = resultList;
    });
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
        leading: MaterialButton(
          onPressed: () {
            displayNotification();
          },
          child: Text("Notif"),
        ),
      ),
      body: buildGridView(),
      floatingActionButton: FloatingActionButton(
        onPressed: testImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  testImage() {
    multiImagePicker().then((result) {
      setState(() {
        images = result;
      });
    });
  }
}

class AssetImageViewer extends StatefulWidget {
  final Asset asset;
  final double width;
  final double height;
  const AssetImageViewer(
      {Key key, @required this.asset, this.width, this.height})
      : super(key: key);

  @override
  _AssetImageViewerState createState() => _AssetImageViewerState();
}

class _AssetImageViewerState extends State<AssetImageViewer>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Uint8List image;
  double width, height;

  @override
  void initState() {
    width = widget.width == null
        ? widget.asset.originalWidth.toDouble()
        : widget.width;
    height = widget.height == null
        ? widget.asset.originalHeight.toDouble()
        : widget.height;
    super.initState();
    if (!mounted) return;
    assetToByte(widget.asset).then((img) => {
          setState(() {
            image = img;
          })
        });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return image == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Image.memory(
            image,
          );
  }
}
