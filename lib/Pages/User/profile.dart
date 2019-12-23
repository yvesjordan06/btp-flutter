import 'package:btpp/Functions/Utility.dart';
import 'package:btpp/Models/annonce.dart';
import 'package:btpp/Pages/Actu/index.dart';
import 'package:btpp/Pages/App/imageViewer.dart';
import 'package:btpp/State/index.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final UserModel user;
  const ProfilePage({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: Theme.of(context).iconTheme.copyWith(color: AppColor.basic),
        elevation: 0,
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: ListTile(
                    dense: true,
                    title: Text('Parametres'),
                    leading: Icon(
                      Icons.settings,
                    ),
                    onTap: () {
                      Navigator.popAndPushNamed(context, 'settings');
                    },
                  ),
                )
              ];
            },
          )
        ],
      ),
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      'images/see',
                      arguments: ImageViewerRouteArgument(
                          image: user.localPicture != null
                              ? user.localPicture
                              : user.pictureLink,
                          tag: 'uniquetag1'),
                    );
                  },
                  child: Hero(
                    tag: 'uniquetag12',
                    child: UserImage(
                      user: user,
                      radius: 100,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  user.nom + ' ' + user.prenom,
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  user.pays + ', ' + user.ville,
                  style: Theme.of(context).textTheme.subtitle,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text('244'),
                              SizedBox(
                                height: 5,
                              ),
                              Text('Images'),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text('512'),
                              SizedBox(
                                height: 5,
                              ),
                              Text('Annonce'),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text('4'),
                              SizedBox(
                                height: 5,
                              ),
                              Text('Metiers'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'cv',
                            arguments: AppState.userState.currentUser);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text('Voir le CV'),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
