import 'package:btpp/State/index.dart';
import 'package:btpp/bloc/bloc.dart';
import 'package:btpp/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.only(
                    left: 28.0,
                    right: 28.0,
                  ),
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Image.asset(
                              'images/favicon.png',
                              width: 160,
                              height: 160,
                            ),
                          ],
                        ),
                        Container(
                          child: _error.isNotEmpty
                              ? Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      _error,
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 12),
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  height: (35),
                                ),
                        ),
                        appForm(),
                        SizedBox(
                          height: (20),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: RaisedButton(
                                onPressed: !_isLoading ? _login : () {},
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100)),
                                  child: !_isLoading
                                      ? Text('Se Connecter',
                                          style: TextStyle(
                                            fontSize: 20,
                                          ))
                                      : CircularProgressIndicator(
                                          backgroundColor: Colors.white,
                                        ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: (20),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Nouveau ? ',
                              style: TextStyle(fontFamily: 'Poppins-Medium'),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, 'auth/signup');
                              },
                              child: Text('Creer un compte',
                                  style: TextStyle(
                                    fontFamily: 'Poppins-Bold',
                                  )),
                            )
                          ],
                        )
                      ],
                    ),
                  ))),
        ));
  }
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  String _error = '';
  bool hiddenPassword = true;
  final phone = '';
  final password = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final userState = AppState.userState;

  @override
  void dispose() {
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
    }
  }

  @override
  void initState() {
    AppState.userState.addListener(_checkAuthStatus);
    super.initState();
  }

  void _checkAuthStatus() {
    if (AppState.userState.error.isNotEmpty) {
      setState(() {
        _error = AppState.userState.error;
        _isLoading = false;
      });
    } else if (AppState.userState.currentUser != null) {
      Navigator.pushReplacementNamed(context, 'app');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(
          authenticationBloc: BlocProvider.of<AuthenticationBloc>(context)),
      child: new Scaffold(
          backgroundColor: Colors.white,
          // resizeToAvoidBottomInset: true,
          body: Center(
            child: SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.only(
                      left: 28.0,
                      right: 28.0,
                    ),
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Image.asset(
                                'images/favicon.png',
                                width: 160,
                                height: 160,
                              ),
                            ],
                          ),
                          Container(
                            child: _error.isNotEmpty
                                ? Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        _error,
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 12),
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    height: (35),
                                  ),
                          ),
                          appForm(),
                          SizedBox(
                            height: (20),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: RaisedButton(
                                  onPressed: !_isLoading ? _login : () {},
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: !_isLoading
                                        ? Text('Se Connecter',
                                            style: TextStyle(
                                              fontSize: 20,
                                            ))
                                        : CircularProgressIndicator(
                                            backgroundColor: Colors.white,
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: (20),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Nouveau ? ',
                                style: TextStyle(fontFamily: 'Poppins-Medium'),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, 'auth/signup');
                                },
                                child: Text('Creer un compte',
                                    style: TextStyle(
                                      fontFamily: 'Poppins-Bold',
                                    )),
                              )
                            ],
                          )
                        ],
                      ),
                    ))),
          )),
    );
  }
}

class LoginForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  const LoginForm({Key key, @required this.formKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: formKey,
        autovalidate: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
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
              keyboardType: TextInputType.phone,
              obscureText: false,
              controller: phone,
              readOnly: _isLoading,
              decoration: InputDecoration(
                labelText: 'Numéro de Telephone',
                hintText: 'Numéro de Telephone',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
                border: OutlineInputBorder(),
                prefixIcon: Icon(
                  Icons.person,
                  size: 20,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              readOnly: _isLoading,
              // ignore: missing_return
              validator: (value) {
                if (value.length < 1) {
                  return 'Le mot de passe est necessaire';
                }
              },
              obscureText: hiddenPassword,
              controller: password,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                  labelText: 'Mot de passe',
                  hintText: 'Mot de passe',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.lock,
                    size: 20,
                  ),
                  suffix: GestureDetector(
                    child: Container(
                      alignment: Alignment.centerRight,
                      width: 20,
                      child: hiddenPassword
                          ? Icon(
                              Icons.visibility,
                              size: 20,
                            )
                          : Icon(
                              Icons.visibility_off,
                              size: 20,
                            ),
                    ),
                    onTap: () {
                      setState(() {
                        hiddenPassword = !hiddenPassword;
                      });
                    },
                  )),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  child: Text('Mot de passe oublié?',
                      style: TextStyle(
                        fontFamily: 'Poppins-Medium',
                        fontSize: 12,
                      )),
                  onPressed: () {
                    Navigator.pushNamed(context, 'auth/reset');
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
