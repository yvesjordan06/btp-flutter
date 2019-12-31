import 'package:btpp/Functions/Utility.dart';
import 'package:btpp/Models/annonce.dart';
import 'package:btpp/Pages/Actu/index.dart';
import 'package:btpp/Pages/App/imageViewer.dart';
import 'package:btpp/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  final UserModel user;
  final bool forCurrentUser;
  const ProfilePage({Key key, @required this.user})
      : assert(user != null),
        forCurrentUser = false,
        super(key: key);
  ProfilePage.currentUser({Key key})
      : user = null,
        forCurrentUser = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel _user;
    final AuthenticationBloc _bloc = authBloc;
    return BlocBuilder(
        bloc: _bloc,
        builder: (BuildContext context, AuthenticationState state) {
          print(state);
          if (user == null && !(state is AuthenticationAuthenticated)) {
            return ErrorPage();
          }
          if (user == null && (state is AuthenticationAuthenticated)) {
            _user = state.user;
          }
          if (user != null) {
            _user = user;
          }

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              iconTheme:
                  Theme.of(context).iconTheme.copyWith(color: AppColor.basic),
              elevation: 0,
              actions: <Widget>[
                if (forCurrentUser)
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
                      !forCurrentUser
                          ? UserImage(
                              user: _user,
                              radius: 100,
                              zoomable: true,
                            )
                          : CurrentUserImage(
                              radius: 100,
                              editable: true,
                              zoomable: true,
                            ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        _user.nom + ' ' + _user.prenom,
                        style: Theme.of(context).textTheme.title,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        _user.pays + ', ' + _user.ville,
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
                          child: user != null
                              ? RaisedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, 'cv',
                                        arguments: _user);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text('Voir le CV'),
                                  ),
                                )
                              : RaisedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, 'cv',
                                        arguments: _user);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text('Mon CV'),
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
        });
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Center(
          child: Text(
              'This is an Error Page: This can be caused because you tried to access a page without being logged in'),
        ),
      ),
    );
  }
}
