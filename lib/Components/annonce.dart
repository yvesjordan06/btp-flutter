import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SingleAnnonce extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 24,
                child: Text('S'),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                        'A very long long long title to not go with else if not the else of the end of the world nothing',
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                          'Ceci est une description de annonce et elle est tres longue a mon gout et jaime bien ce genre de longeur',
                        style: TextStyle(
                          fontSize: 12
                        ),
                      ),
                    ),
                    Row(
                        children: <Widget> [
                            Icon(Icons.location_on, color: Colors.orange, size: 11,),
                            Text("Location", style: TextStyle(fontSize: 11))
                          ],
                    ),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('Wednesday', style: TextStyle(fontSize: 11, color: Colors.grey),),
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
      ),
    );
  }
}
