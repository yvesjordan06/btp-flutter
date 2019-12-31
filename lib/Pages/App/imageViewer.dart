import 'dart:io';
import 'dart:typed_data';
import 'package:btpp/Functions/Images.dart';
import 'package:btpp/Functions/Utility.dart';
import 'package:btpp/utils/notifications.dart';
import 'package:flutter/gestures.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:flutter/material.dart';

class ImageViewer extends StatefulWidget {
  final List<File> gallery;
  const ImageViewer({Key key, this.gallery}) : super(key: key);

  @override
  _ImageViewerState createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  List<Asset> images = List();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
        leading: MaterialButton(
          onPressed: () {},
          child: Text("Notif"),
        ),
      ),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: images.length,
          itemBuilder: (context, index) {
            print(images[index].name);
            return AssetImageViewer(
              asset: images[index],
              width: 200,
              height: 200,
              onTap: () {
                Navigator.pushNamed(context, 'images/see',
                    arguments: images[index]);
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          multiImagePicker().then((result) {
            print(result);
            setState(() {
              images = [];
              images = result;
            });
          });
        },
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  testImage() {
    multiImagePicker().then((result) {
      print(result);
      setState(() {
        images.clear();
        images = result;
      });
    });
  }
}

class AssetImageViewer extends StatefulWidget {
  final Asset asset;
  final double width;
  final double height;
  final GestureTapCallback onTap;
  final bool dismissable;
  final DismissDirectionCallback onDismiss;
  const AssetImageViewer(
      {Key key,
      @required this.asset,
      this.width,
      this.height,
      this.onTap,
      this.dismissable = false,
      this.onDismiss})
      : super(key: key);

  @override
  _AssetImageViewerState createState() => _AssetImageViewerState(
        asset: asset,
        onTap: onTap,
        onDismiss: onDismiss,
        dismissable: dismissable,
        height: height,
        width: width,
      );
}

class _AssetImageViewerState extends State<AssetImageViewer>
/*with AutomaticKeepAliveClientMixin*/ {
  //@override
  //bool get wantKeepAlive => true;

  Uint8List image;
  final Asset asset;
  final double width;
  final double height;
  final GestureTapCallback onTap;
  final bool dismissable;
  final DismissDirectionCallback onDismiss;
  _AssetImageViewerState({
    @required this.asset,
    this.width,
    this.height,
    this.onTap,
    this.dismissable = false,
    this.onDismiss,
  });

  @override
  void initState() {
    super.initState();
    if (!mounted) return;
    _init();
  }

  @override
  void didUpdateWidget(AssetImageViewer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.asset != widget.asset) _init();
  }

  void _init() {
    if (!mounted) return;
    assetToByte(widget.asset).then((img) => {
          setState(() {
            image = img;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    print('hash : ${widget.hashCode}');
    //super.build(context);
    return image == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : InkWell(
            child: widget.dismissable
                ? Dismissible(
                    crossAxisEndOffset: 0,
                    dragStartBehavior: DragStartBehavior.down,
                    movementDuration: Duration(seconds: 0),
                    direction:
                        widget.dismissable ? DismissDirection.vertical : null,
                    onDismissed: widget.onDismiss,
                    key: Key(widget.asset.identifier),
                    child: Hero(
                      transitionOnUserGestures: true,
                      tag: widget.asset.hashCode.toString(),
                      child: Image.memory(
                        image,
                        fit: BoxFit.fill,
                        width: widget.width == null
                            ? double.infinity
                            : widget.width,
                        height: widget.height == null
                            ? double.infinity
                            : widget.height,
                      ),
                    ),
                  )
                : Hero(
                    transitionOnUserGestures: true,
                    tag: widget.asset,
                    child: Image.memory(
                      image,
                      width: widget.width,
                      height: widget.height,
                    ),
                  ),
            onTap: () {
              showFullMemoryImage(
                context,
                image,
                key: widget.asset,
              );
            },
          );
  }
}

class DismissableImage extends StatelessWidget {
  final String url;
  final File file;
  final Uint8List memory;
  final Object tag;

  const DismissableImage.network(this.url, {this.tag = 'none'})
      : file = null,
        memory = null;
  const DismissableImage.file(this.file, {this.tag = 'none'})
      : url = null,
        memory = null;
  const DismissableImage.memory(this.memory, {this.tag = 'none'})
      : url = null,
        file = null;

  Widget builder(context, {small = false}) {
    double scale = small ? 2 : 1.0;
    if (url != null) {
      return Image.network(
        url,
        scale: scale,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      );
    } else if (file != null) {
      return Image.file(
        file,
        scale: scale,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      );
    }
    return Image.memory(
      memory,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      scale: scale,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget pic = builder(context);
    return Container(
      child: Center(
        child: Draggable(
          axis: Axis.vertical,
          affinity: Axis.vertical,
          // key: Key(DateTime.now().toString()),
          child: Hero(child: pic, tag: tag),
          feedback: pic,
          childWhenDragging: Opacity(
            opacity: 0.2,
            child: builder(context),
          ),
          onDragEnd: (deta) {
            print(deta.offset);
            if (deta.offset.dy > 100) Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

class ImageViewerRouteArgument {
  ImageViewerRouteArgument({this.image, this.tag});
  final dynamic image;
  final String tag;

  bool get isFile {
    return image is File;
  }

  bool get isNetwork {
    return image is String;
  }

  bool get isMemory {
    return image is Uint8List;
  }
}
