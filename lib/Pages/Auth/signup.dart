import 'package:btpp/Components/annonce.dart';
import 'package:btpp/Components/headerText.dart';
import 'package:btpp/Functions/Utility.dart';
import 'package:btpp/Models/annonce.dart';
import 'package:btpp/Pages/Actu/index.dart';
import 'package:btpp/Pages/Auth/passwordreset.dart';
import 'package:btpp/bloc/authentication_bloc.dart';
import 'package:btpp/bloc/authentication_event.dart';
import 'package:btpp/bloc/bloc.dart';
import 'package:btpp/bloc/login_bloc.dart';
import 'package:btpp/bloc/login_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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

  bool createdRequest = false;

  @override
  Widget build(BuildContext context) {
    AuthenticationBloc authbloc = BlocProvider.of<AuthenticationBloc>(context);
    LoginBloc loginBloc = LoginBloc(authenticationBloc: authbloc);
    void _createUser(_user) {
      loginBloc.add((SignUpPressed(user)));
    }

    return BlocProvider<LoginBloc>(
      create: (context) => loginBloc,
      child: BlocListener<LoginBloc, LoginState>(
        bloc: loginBloc,
        listener: (context, state) {
          if (state is LoginLoading) {
            createdRequest = true;
          }
          if ((state is LoginInitial) && createdRequest) {
            Navigator.pop(context);
          }
        },
        child: WillPopScope(
          onWillPop: () {
            if (previousPage == null || previousPage < 0)
              return Future.value(true);
            previousPage--;
            controller.previousPage(
              duration: const Duration(milliseconds: 400),
              curve: Curves.linear,
            );
            return Future.value(false);
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            bloc: loginBloc,
            builder: (context, state) {
              print(state);
              return Stack(
                children: <Widget>[
                  PageView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: controller,
                    children: <Widget>[
                      BasicInfo(
                        user,
                        onNext: _onNext,
                      ),
                      if (!enterprise)
                        Profile.particulier(
                          user,
                          onNext: _onNext,
                        )
                      else
                        Profile.entreprise(
                          user,
                          onNext: _onNext,
                        ),
                      _ChoixService(
                        user,
                        onNext: _onNext,
                      ),
                      Password(user: user, onSubmit: _createUser)
                    ],
                  ),
                  if (state is LoginLoading)
                    Positioned.fill(
                      child: Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class BasicInfo extends StatefulWidget {
  final UserModel user;
  final Function(UserModel) onNext;

  const BasicInfo(this.user, {Key key, this.onNext}) : super(key: key);

  @override
  _BasicInfoState createState() => _BasicInfoState();
}

class _BasicInfoState extends State<BasicInfo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isEntreprise = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBodyBehindAppBar: true,
      //extendBody: true,
      //persistentFooterButtons: <Widget>[],
      appBar: widget.user.id.isNotEmpty
          ? null
          : AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: ThemeData().iconTheme.copyWith(color: Colors.black),
              title: Text(
                'Creation du compte',
                style: TextStyle(color: Colors.black),
              ),
            ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(16),
            child: Center(
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
                        if (widget.user.id.isEmpty)
                          CheckboxListTile(
                            onChanged: widget.user.id.isNotEmpty
                                ? null
                                : (bool value) {
                                    setState(() {
                                      isEntreprise = value;
                                      widget.user.accountType = value
                                          ? AccountType.entreprise
                                          : AccountType.particulier;
                                    });
                                  },
                            value: widget.user.accountType ==
                                AccountType.entreprise,
                            title:
                                Text('Je creer un compte pour mon entreprise'),
                          ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                            width: double.infinity,
                            child: RaisedButton(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: widget.user.id.isEmpty
                                    ? Text('Suivant')
                                    : Text('Sauvegarder'),
                              ),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  if (widget.user.id.isEmpty) {
                                    widget.onNext(widget.user);
                                  } else {
                                    BlocProvider.of<AuthenticationBloc>(context)
                                        .add(EditUser(user: widget.user));
                                    Navigator.pop(context);
                                  }
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
        ),
      ),
    );
  }
}

class Profile extends StatefulWidget {
  final bool entreprise;
  final bool particulier;
  final UserModel user;
  final Function(UserModel) onNext;

  Profile(this.user, {Key key, this.onNext})
      : assert(user != null),
        entreprise = user.accountType == AccountType.entreprise,
        particulier = user.accountType == AccountType.particulier;

  Profile.entreprise(this.user, {Key key, this.onNext})
      : particulier = false,
        entreprise = true,
        super(key: key);

  Profile.particulier(this.user, {Key key, this.onNext})
      : particulier = true,
        entreprise = false,
        super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  String initialDate;

  @override
  Widget build(BuildContext context) {
    try {
      print('I am trying');
      initialDate = DateFormat.yMMMMd().format(widget.user.dateDeNaissance);
    } catch (e) {
      print(e);
      print(widget.user.dateDeNaissance);
      initialDate = '';
    }

    _dateController.value = TextEditingValue(text: initialDate);
    return Scaffold(
      appBar: widget.user.id.isNotEmpty
          ? null
          : AppBar(
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
                        child: widget.user.id.isNotEmpty
                            ? CurrentUserImage(editable: true, radius: 100)
                            : CircleAvatar(
                                backgroundImage:
                                    widget.user.localPicture == null
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
                      if (widget.user.id.isEmpty)
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => PictureSelect(
                            onSelected: (image) {
                              Navigator.pop(context);
                              widget.user.localPicture = image;
                              setState(() {});
                            },
                          ),
                        );
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
                      initialValue: widget.user.nom,
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
                      initialValue: widget.user.prenom,
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
                      controller: _dateController,
                      onSaved: (value) {
                        // widget.user.dateDeNaissance = DateTime.tryParse(value);
                      },
                      validator: (value) {
                        if (DateTime.tryParse(
                                widget.user.dateDeNaissance.toString()) ==
                            null) return 'Entrez une date valide';

                        return null;
                      },
                      autovalidate: false,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.arrow_drop_down),
                          labelText: 'Date de naissance ',
                          hintText: 'Votre Date de naissance',
                          hintStyle: TextStyle(color: Colors.black)),
                      readOnly: true,
                      onTap: () {
                        showDatePicker(
                          initialDatePickerMode: DatePickerMode.year,
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        ).then((value) {
                          if (value != null)
                            setState(() {
                              widget.user.dateDeNaissance = value;
                            });
                        });
                      },
                    ),
                  ] else ...[
                    TextFormField(
                      onSaved: (value) {
                        widget.user.nom = value;
                      },
                      initialValue: widget.user.nom,
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
                      initialValue: widget.user.boitePostal,
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
                            if (widget.user.id.isNotEmpty) {
                              BlocProvider.of<AuthenticationBloc>(context)
                                  .add(EditUser(user: widget.user));
                              Navigator.pop(context);
                            } else
                              widget.onNext(widget.user);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: widget.user.id.isNotEmpty
                              ? Text('Sauvegarder')
                              : Text('Suivant'),
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
                constraints: BoxConstraints(maxHeight: 200),
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
                            child: ListView(
                              // shrinkWrap: true,
                              // crossAxisAlignment: CrossAxisAlignment.start,
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
                            child: ListView(
                              //crossAxisAlignment: CrossAxisAlignment.start,
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
