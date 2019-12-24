import 'package:btpp/Components/headerText.dart';
import 'package:btpp/Functions/Images.dart';
import 'package:btpp/Functions/Utility.dart';
import 'package:btpp/Models/annonce.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  SignupPage({Key key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  UserModel user = UserModel();
  final PageController controller = PageController(initialPage: 0);
  int previousPage;
  bool enterprise = false;

  void _onNext(_user) {
    int page = controller.page.toInt();
    previousPage = page;

    setState(() {
      user = _user;
    });
    if (user.accountType == AccountType.entreprise) {
      setState(() {
        enterprise = true;
      });
    } else {
      setState(() {
        enterprise = false;
      });
    }

    if (controller.hasClients) {
      controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.linear,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (previousPage == null || previousPage < 0) return Future.value(true);
        previousPage--;
        controller.previousPage(
          duration: const Duration(milliseconds: 400),
          curve: Curves.linear,
        );
        return Future.value(false);
      },
      child: PageView(
        // physics: NeverScrollableScrollPhysics(),
        controller: controller,

        children: <Widget>[
          _BasicInfo(
            user,
            onNext: _onNext,
          ),
          if (!enterprise)
            _Profile.particulier(
              user,
              onNext: _onNext,
            )
          else
            _Profile.entreprise(
              user,
              onNext: _onNext,
            ),
          _ChoixService(
            user,
            onNext: _onNext,
          )
        ],
      ),
    );
  }
}

class _BasicInfo extends StatefulWidget {
  final UserModel user;
  final Function(UserModel) onNext;

  const _BasicInfo(this.user, {Key key, this.onNext}) : super(key: key);
  @override
  __BasicInfoState createState() => __BasicInfoState();
}

class __BasicInfoState extends State<_BasicInfo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isEntreprise = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBodyBehindAppBar: true,
      //extendBody: true,
      //persistentFooterButtons: <Widget>[],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: ThemeData().iconTheme.copyWith(color: Colors.black),
        title: Text(
          'Creation du compte',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16),
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    HeaderText(
                      text: 'Informations Génerales',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      onSaved: (val) {
                        //widget.user.
                      },
                      decoration: InputDecoration(
                        icon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        hintText: 'Votre Email (optionelle)',
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      onSaved: (value) {
                        widget.user.telephone = value;
                      },
                      initialValue: widget.user.telephone,
                      validator: (value) {
                        if (int.tryParse(value) == null) {
                          return 'Entrez un numero de telephone valide';
                        }
                        if (value.length < 1) {
                          return 'Le numéro de téléphone est necessaire';
                        }
                        if (value.length < 7) {
                          return 'Le numéro de téléphone trop court';
                        }
                        return null;
                      },
                      autovalidate: true,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        icon: Icon(Icons.phone_android),
                        border: OutlineInputBorder(),
                        labelText: 'Telephone',
                        hintText: 'Votre Numero de telephone',
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      onSaved: (value) {
                        widget.user.pays = value;
                      },
                      validator: (value) {
                        if (value.length < 1) {
                          return 'Le pays est necessaire';
                        }

                        return null;
                      },
                      autovalidate: true,
                      initialValue: widget.user.pays,
                      decoration: InputDecoration(
                        icon: Icon(Icons.public),
                        border: OutlineInputBorder(),
                        labelText: 'Pays',
                        hintText: 'Votre Pay Actuel',
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      onSaved: (value) {
                        widget.user.ville = value;
                      },
                      initialValue: widget.user.ville,
                      validator: (value) {
                        if (value.length < 1) {
                          return 'La ville est necessaire';
                        }

                        return null;
                      },
                      autovalidate: true,
                      decoration: InputDecoration(
                        icon: Icon(Icons.location_city),
                        border: OutlineInputBorder(),
                        labelText: 'Ville',
                        hintText: 'Votre ville',
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      onSaved: (value) {
                        widget.user.quartier = value;
                      },
                      validator: (value) {
                        if (value.length < 1) {
                          return 'Le quartier est necessaire';
                        }

                        return null;
                      },
                      initialValue: widget.user.quartier,
                      autovalidate: true,
                      decoration: InputDecoration(
                        icon: Icon(Icons.home),
                        border: OutlineInputBorder(),
                        labelText: 'Quartier ',
                        hintText: 'Votre quartier ou Address',
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CheckboxListTile(
                      onChanged: (bool value) {
                        setState(() {
                          isEntreprise = value;
                          widget.user.accountType = value
                              ? AccountType.entreprise
                              : AccountType.particulier;
                        });
                      },
                      value: widget.user.accountType == AccountType.entreprise,
                      title: Text('Je creer un compte pour mon entreprise'),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                        width: double.infinity,
                        child: RaisedButton(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text('Suivant'),
                          ),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              widget.onNext(widget.user);
                            }
                          },
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Profile extends StatefulWidget {
  final bool entreprise;
  final bool particulier;
  final UserModel user;
  final Function(UserModel) onNext;

  _Profile.entreprise(this.user, {Key key, this.onNext})
      : particulier = false,
        entreprise = true,
        super(key: key);
  _Profile.particulier(this.user, {Key key, this.onNext})
      : particulier = true,
        entreprise = false,
        super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<_Profile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: ThemeData().iconTheme.copyWith(color: Colors.black),
        title: Text(
          'Creation du Profile',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  InkWell(
                    child: SizedBox(
                      height: 200,
                      width: 200,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: CircleAvatar(
                          backgroundImage: widget.user.localPicture == null
                              ? null
                              : FileImage(widget.user.localPicture),
                          child: widget.user.localPicture == null
                              ? Icon(
                                  Icons.add_a_photo,
                                  size: 50,
                                )
                              : SizedBox(),
                          radius: 100,
                        ),
                      ),
                    ),
                    onTap: () {
                      imageFromGallery().then((image) {
                        widget.user.localPicture = image;
                        setState(() {});
                      });
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Ajoutez une photo de profile',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (widget.particulier) ...[
                    TextFormField(
                      onSaved: (value) {
                        widget.user.nom = value;
                      },
                      validator: (value) {
                        if (value.length < 1) {
                          return 'Le nom est necessaire';
                        }

                        return null;
                      },
                      autovalidate: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nom ',
                        hintText: 'Votre nom',
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      onSaved: (value) {
                        widget.user.prenom = value;
                      },
                      validator: (value) {
                        if (value.length < 1) {
                          return 'La Prénom est necessaire';
                        }

                        return null;
                      },
                      autovalidate: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Prénom ',
                        hintText: 'Votre Prénom',
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      onSaved: (value) {
                        widget.user.dateDeNaissance = DateTime.tryParse(value);
                      },
                      validator: (value) {
                        if (value.length < 1) {
                          return 'La Date de naissance est necessaire';
                        }

                        return null;
                      },
                      autovalidate: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Date de naissance ',
                        hintText: 'Votre Date de naissance',
                      ),
                    ),
                  ] else ...[
                    TextFormField(
                      onSaved: (value) {
                        widget.user.nom = value;
                      },
                      validator: (value) {
                        if (value.length < 1) {
                          return 'La Raison sociale est necessaire';
                        }

                        return null;
                      },
                      autovalidate: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Raison Sociale ',
                        hintText: 'Raison Sociale de votre entreprise',
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      onSaved: (value) {
                        widget.user.boitePostal = value;
                      },
                      autovalidate: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Boite Postale ',
                        hintText: 'Boite Postale (Optionnelle)',
                      ),
                    ),
                  ],
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: double.infinity,
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            widget.onNext(widget.user);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text('Suivant'),
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ChoixService extends StatefulWidget {
  _ChoixService(this.user, {Key key, this.onNext}) : super(key: key);
  final UserModel user;
  final Function(UserModel) onNext;

  @override
  __ChoixServiceState createState() => __ChoixServiceState();
}

class __ChoixServiceState extends State<_ChoixService> {
  String choice = '';

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: ThemeData().iconTheme.copyWith(color: Colors.black),
        title: Text(
          'Choix du Service',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Container(
                height: 200,
                child: Card(
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              widget.user.userType = UserType.travailleur;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Center(
                                    child: Text(
                                  'Travailleur',
                                  style: Theme.of(context).textTheme.title,
                                )),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Selectionez si :',
                                  style: Theme.of(context).textTheme.subtitle,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '- Vous recherchez du travail',
                                  style: Theme.of(context).textTheme.body1,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '- Vous avez de la competence a revendre',
                                  style: Theme.of(context).textTheme.body1,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '- Vous voulez faire connaitre vos service',
                                  style: Theme.of(context).textTheme.body1,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      if (widget.user.userType == UserType.travailleur)
                        Positioned.fill(
                          child: Container(
                            color: AppColor.primaryColorsOpacity(0.7),
                            child: Icon(
                              Icons.check,
                              size: 200,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  height: 200,
                  child: Card(
                      child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              widget.user.userType = UserType.annonceur;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Center(
                                    child: Text(
                                  'Annonceur',
                                  style: Theme.of(context).textTheme.title,
                                )),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Selectionez si :',
                                  style: Theme.of(context).textTheme.subtitle,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '- Vous recherchez des travailleur',
                                  style: Theme.of(context).textTheme.body1,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '- Vous avez des annonces a publier',
                                  style: Theme.of(context).textTheme.body1,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '- Vous avez besion des service rapide et précis',
                                  style: Theme.of(context).textTheme.body1,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '- Vous ne savez pas quoi choisir',
                                  style: Theme.of(context).textTheme.body1,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      if (widget.user.userType == UserType.annonceur)
                        Positioned.fill(
                          child: Container(
                            color: AppColor.accentColorsOpacity(0.7),
                            child: Icon(
                              Icons.check,
                              size: 200,
                            ),
                          ),
                        ),
                    ],
                  ))),
              SizedBox(
                height: 10,
              ),
              Container(
                  width: double.infinity,
                  child: RaisedButton(
                    onPressed: () {
                      if (widget.user.userType.isNotEmpty) {
                        widget.onNext(widget.user);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text('Suivant'),
                    ),
                  )),
            ],
          ),
        ),
      ),
    ));
  }
}
