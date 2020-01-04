import 'dart:io';

import 'package:btpp/Functions/Images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../Functions/Utility.dart';
import '../Models/annonce.dart';

class SingleAnnonce extends StatelessWidget {
  const SingleAnnonce({Key key, this.annonce}) : super(key: key);

  final AnnonceModel annonce;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: Container(
          padding:
              const EdgeInsets.only(left: 20, top: 10, bottom: 10, right: 10),
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: AppColor.primaryColor,
                    radius: 24,
                    child: Text(annonce.intitule[annonce.intitule.length - 1]),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          annonce.intitule,
                          style: Theme.of(context).textTheme.title,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              color: AppColor.accentColor,
                              size: 11,
                            ),
                            Text(annonce.lieu, style: TextStyle(fontSize: 11))
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        timeAgo(annonce.createdAt),
                        style: TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      if(annonce.createdAt.isAfter(DateTime.now().subtract(Duration(days: 1))))
                      Container(
                        width: 40,
                        height: 20,
                        decoration: BoxDecoration(
                            color: AppColor.primaryColor,
                            borderRadius: BorderRadius.circular(30)),
                        alignment: Alignment.center,
                        child: Text(
                          'New',
                          style: TextStyle(fontSize: 11, color: Colors.white),
                        ),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
                alignment: Alignment.topLeft,
                child: Text(
                  annonce.description,
                  style: Theme.of(context).textTheme.body1,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, 'annonce/see', arguments: annonce);
      },
    );
  }
}

class PictureSelect extends StatelessWidget {
  final void Function(File) onSelected;

  const PictureSelect({Key key, @required this.onSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 180),
      padding: EdgeInsets.only(top: 16, left: 16, right: 16),
      child: Column(
        children: <Widget>[
          Text(
            'Photo de profile',
            style: Theme.of(context).textTheme.title,
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: <Widget>[
              IconButtonLabel(
                icon: Icon(Icons.photo_camera),
                label: 'Camera',
                onTap: () {
                  imageFromCamera().then((image) {
                    onSelected(image);
                  });
                },
              ),
              SizedBox(
                width: 30,
              ),
              IconButtonLabel(
                icon: Icon(Icons.photo_library),
                label: 'Gallery',
                onTap: () {
                  imageFromGallery().then((image) {
                    onSelected(image);
                  });
                },
              )
            ],
          )
        ],
      ),
    );
  }
}

class IconButtonLabel extends StatelessWidget {
  const IconButtonLabel(
      {Key key,
      @required this.icon,
      @required this.label,
      @required this.onTap})
      : super(key: key);

  final Icon icon;
  final String label;

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 35,
          foregroundColor: Theme.of(context).primaryColor,
          child: IconButton(
            icon: icon,
            onPressed: onTap,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(label)
      ],
    );
  }
}
