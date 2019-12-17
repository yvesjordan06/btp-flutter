import '../Functions/Colors.dart';
import '../Functions/Utility.dart';
import '../Models/annonce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SingleAnnonce extends StatelessWidget {
  final AnnonceModel annonce;

  const SingleAnnonce({Key key, this.annonce}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      child: Card(
        child: Container(
          padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10, right: 10),
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(

                    radius: 24,
                    child: Text(annonce.intitule[0]),
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
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 5,),
                        Row(
                            children: <Widget> [
                                Icon(Icons.location_on, color: AppColors.accent, size: 11,),
                                Text(annonce.lieu, style: TextStyle(fontSize: 11))
                              ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(timeAgo(annonce.createdAt), style: TextStyle(fontSize: 11, color: Colors.grey),),
                      SizedBox(height: 10.0,),
                      Container(
                        width: 40,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(30)
                        ),
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
              SizedBox(height: 10,),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
                alignment: Alignment.topLeft,
                child: Text(
                  annonce.description,
                  style: TextStyle(
                      fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ),
            ],
          ),
        ),

      ),
      onTap: (){Navigator.pushNamed(context, 'annonce/see', arguments: annonce);},
    );
  }
}
