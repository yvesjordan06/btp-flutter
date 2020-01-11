import 'package:btpp/Components/headerText.dart';
import 'package:btpp/Components/menuTiles.dart';
import 'package:btpp/Functions/Images.dart';
import 'package:btpp/Functions/Utility.dart';
import 'package:btpp/Models/annonce.dart';
import 'package:btpp/Pages/Actu/index.dart';
import 'package:btpp/Pages/Auth/passwordreset.dart';
import 'package:btpp/Pages/Auth/signup.dart';
import 'package:btpp/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class UserSettingPage extends StatefulWidget {
  @override
  _UserSettingPageState createState() => _UserSettingPageState();
}

AuthenticationBloc _bloc = authBloc;

class _UserSettingPageState extends State<UserSettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        child: BlocBuilder(
          bloc: authBloc,
          builder: (BuildContext context, AuthenticationState state) {
            UserModel currentUser;
            if (state is AuthenticationAuthenticated) {
              currentUser = state.user;
            } else {
              return Container();
            }
            return Scaffold(
              primary: false,
              extendBodyBehindAppBar: true,
              extendBody: true,
              body: Builder(builder: (context) {
                return Stack(
                  //fit: StackFit.expand,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: currentUser.localPicture == null
                              ? NetworkImage(currentUser.pictureLink)
                              : FileImage(currentUser.localPicture),
                        ),
                      ),
                    ),
                    Container(
                      color: AppColor.primaryColorsOpacity(0.9),
                    ),
                    Positioned.fill(
                      top: 300,
                      child: Container(
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 80),
                      //width: double.infinity,
                      child: SingleChildScrollView(
                        child: SettingDecorationPage(
                          user: currentUser,
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                HeaderText(
                                  text: 'Parametre Profiles',
                                ),
                                if (currentUser.accountType ==
                                    AccountType.entreprise)
                                  MenuTile(
                                    text: 'Raison Sociale',
                                    value: currentUser.raisonSociale,
                                    onTap: () {
                                      _profileEdit(currentUser, context);
                                    },
                                  ),
                                if (currentUser.accountType !=
                                    AccountType.entreprise)
                                  MenuTile(
                                    text: 'Nom',
                                    value: currentUser.nom,
                                    onTap: () {
                                      _profileEdit(currentUser, context);
                                    },
                                  ),
                                if (currentUser.accountType !=
                                    AccountType.entreprise)
                                  MenuTile(
                                    text: 'Prénom',
                                    value: currentUser.prenom,
                                    onTap: () {
                                      _profileEdit(currentUser, context);
                                    },
                                  ),
                                if (currentUser.accountType !=
                                    AccountType.entreprise)
                                  MenuTile(
                                    text: 'Anniversaire',
                                    value: DateFormat.MMMEd()
                                        .format(currentUser.dateDeNaissance),
                                    onTap: () {
                                      _profileEdit(currentUser, context);
                                    },
                                  ),
                                MenuTile(
                                  text: 'Télephone',
                                  value: currentUser.telephone,
                                  onTap: () {
                                    basicInfoEdit(currentUser, context);
                                  },
                                ),
                                MenuTile(
                                  text: 'Email',
                                  value: currentUser.email ?? 'Aucun',
                                  onTap: () {
                                    basicInfoEdit(currentUser, context);
                                  },
                                ),
                                MenuTile(
                                  text: 'Pays',
                                  value: currentUser.pays,
                                  onTap: () {
                                    basicInfoEdit(currentUser, context);
                                  },
                                ),
                                MenuTile(
                                  text: 'Ville',
                                  value: currentUser.ville,
                                  onTap: () {
                                    basicInfoEdit(currentUser, context);
                                  },
                                ),
                                MenuTile(
                                  text: 'Quartier',
                                  value: currentUser.quartier,
                                  onTap: () {
                                    basicInfoEdit(currentUser, context);
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                HeaderText(
                                  text: 'Compte',
                                ),
                                if (currentUser.userType ==
                                    UserType.travailleur)
                                  MenuTile(
                                    text: currentUser.metiers != null
                                        ? 'Metiers'
                                        : 'Ajouter des metier',
                                    value: currentUser.metiers?.length
                                        ?.toString() ??
                                        '',
                                    onTap: () {
                                      if (currentUser.metiers != null)
                                        Navigator.pushNamed(context, 'metiers');
                                      else
                                        Navigator.pushNamed(
                                            context, 'metiers/add');
                                    },
                                  ),
                                MenuTile(
                                  text: 'Type',
                                  value: currentUser.accountType,
                                  onTap: () {},
                                ),
                                if (currentUser.userType ==
                                    UserType.travailleur)
                                  MenuTile(
                                    text: 'Abonnement',
                                    value: 'Gratuit',
                                    onTap: () {},
                                  ),
                                MenuTile(
                                  text: 'Mot de passe',
                                  onTap: () {
                                    _passwordEdit(currentUser, context);
                                  },
                                ),
                                if (currentUser.accountType !=
                                    AccountType.entreprise)
                                  MenuTile(
                                    text:
                                        'Se Connecter comme ${UserType.toggleType(currentUser.userType)}',
                                    onTap: () {
                                      String password = currentUser.motDePasse;
                                      showDialog(
                                          context: context,
                                          builder: (context) => Dialog(
                                                child: Container(
                                                  padding: EdgeInsets.all(16),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      Text(
                                                        'Entrez votre mot de passe',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .title,
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      TextFormField(
                                                        keyboardType:
                                                            TextInputType
                                                                .visiblePassword,
                                                        obscureText: true,
                                                        initialValue: password,
                                                        onChanged: (val) {
                                                          password = val;
                                                        },
                                                        decoration: InputDecoration(
                                                            labelText:
                                                                'Mot de passe',
                                                            border:
                                                                OutlineInputBorder()),
                                                      ),
                                                      SizedBox(
                                                        height: 25,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: <Widget>[
                                                          OutlineButton(
                                                            child: Text(
                                                              'Annuler',
                                                              style: TextStyle(
                                                                  color: AppColor
                                                                      .accentColor),
                                                            ),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            //color: AppColor
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          OutlineButton(
                                                            child: Text(
                                                                'Continuer'),
                                                            onPressed: () {
                                                              authBloc.add(
                                                                  SwapUser(
                                                                      password));
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            color: AppColor
                                                                .accentColor,
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ));
                                    },
                                  ),
                                MenuTile(
                                  text: 'Se deconnecter',
                                  onTap: () {
                                    _bloc.add(LoggedOut());
                                    //Navigator.pushReplacementNamed(context, 'auth');
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                HeaderText(
                                  text: 'Support',
                                ),
                                MenuTile(
                                  text: 'Nous appeler',
                                  onTap: () {},
                                ),
                                MenuTile(
                                  text: 'Feedback',
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 80,
                      child: AppBar(
                        elevation: 0,
                        title: Text('Parametres'),
                        backgroundColor: Colors.transparent,
                        /* actions: <Widget>[
                            IconButton(
                              icon: Icon(Icons.more_horiz),
                              onPressed: () {},
                            )
                          ], */
                      ),
                    )
                  ],
                );
              }),
            );
          },
        ),
        listener: (BuildContext context, AuthenticationState state) {
          print('this is tha state $state');
          if (state is AuthenticationUnauthenticated) Navigator.pop(context);
          if (state is UserEdited) Scaffold.of(context).hideCurrentSnackBar();
          if (state is EditingUser)
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('En cours ...'),
                  CircularProgressIndicator()
                ],
              ),
            ));
        },
      ),
    );
  }

  Future basicInfoEdit(UserModel currentUser, BuildContext context) {
    return showDialog(
      child: Dialog(child: BasicInfo(currentUser.copyWith())),
      context: context,
    );
  }

  Future _profileEdit(UserModel currentUser, BuildContext context) {
    return showDialog(
      child: Dialog(child: Profile(currentUser.copyWith())),
      context: context,
    );
  }

  Future _passwordEdit(UserModel currentUser, BuildContext context) {
    return showDialog(
      child: Dialog(child: Password(user: currentUser.copyWith())),
      context: context,
    );
  }
}

class SettingDecorationPage extends StatelessWidget {
  final UserModel user;
  final Widget child;

  const SettingDecorationPage(
      {Key key, @required this.user, @required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthenticationBloc _bloc = authBloc;
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 150),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              )),
          child: Padding(
            padding: EdgeInsets.only(top: 50),
            child: child,
          ),
        ),
        Positioned(
          top: 110,
          left: 30,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  CurrentUserImage(radius: 40),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 12,
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 10,
                        child: Center(
                          child: IconButton(
                            padding: EdgeInsets.all(2),
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Row(
                                      children: <Widget>[
                                        IconButton(
                                          icon: Icon(Icons.photo_camera),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            imageFromCamera().then((img) {
                                              _bloc.add(
                                                  ChangePicture(image: img));
                                            });
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.photo_library),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            imageFromGallery().then((img) {
                                              _bloc.add(
                                                  ChangePicture(image: img));
                                            });
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            },
                            icon: Icon(
                              Icons.edit,
                              size: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      user.name.toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          size: 10,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          user.address.toUpperCase(),
                          style: TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
