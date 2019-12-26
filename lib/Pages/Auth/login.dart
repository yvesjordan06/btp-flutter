import 'package:btpp/bloc/bloc.dart';
import 'package:btpp/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  final GlobalKey<LoginFormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    String _error = '';
    bool _isLoading = false;
    return BlocProvider<LoginBloc>(
      create: (BuildContext context) {
        return LoginBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context));
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            child: Center(
              child: SingleChildScrollView(
                child: BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                  print(state.toString());
                  return Stack(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16.0),
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
                              child: state is LoginFailure
                                  ? Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Text(
                                          state.error,
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 12),
                                        ),
                                      ),
                                    )
                                  : SizedBox(
                                      height: (35),
                                    ),
                            ),
                            LoginForm(
                              key: _formKey,
                            ),
                            SizedBox(
                              height: (20),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: !(state is LoginLoading)
                                      ? RaisedButton(
                                          onPressed: () {
                                            Credential values = _formKey
                                                .currentState
                                                .getCredential();
                                            if (values != null)
                                              BlocProvider.of<LoginBloc>(
                                                      context)
                                                  .add(
                                                LoginButtonPressed(
                                                  telephone: values.telephone,
                                                  motDePasse: values.password,
                                                ),
                                              );
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 15),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100)),
                                            child: !_isLoading
                                                ? Text('Se Connecter',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                    ))
                                                : CircularProgressIndicator(
                                                    backgroundColor:
                                                        Colors.white,
                                                  ),
                                          ),
                                        )
                                      : RaisedButton(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CircularProgressIndicator(),
                                          ),
                                          onPressed: () {},
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
                                  style:
                                      TextStyle(fontFamily: 'Poppins-Medium'),
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
                      ),
                      if (state is LoginLoading)
                        Positioned.fill(
                          child: Container(
                            color: Color.fromRGBO(0, 0, 0, 0),
                          ),
                        )
                    ],
                  );
                }),
              ),
            ),
          )),
    );
  }
}

class LoginForm extends StatefulWidget {
  final void Function(String telphone, String password) onSubmit;
  LoginForm({@required Key key, this.onSubmit}) : super(key: key);

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  bool hide = true;
  final GlobalKey<FormState> formKey = GlobalKey();
  String telephone, password;

  Credential getCredential() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      return Credential(telephone: telephone, password: password);
    }
    return null;
  }

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
              onSaved: (value) {
                telephone = value;
              },
              obscureText: false,
              //controller: phone,
              readOnly: false,
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
              readOnly: false,
              // ignore: missing_return
              validator: (value) {
                if (value.length < 1) {
                  return 'Le mot de passe est necessaire';
                }
              },
              obscureText: hide,
              keyboardType: TextInputType.visiblePassword,
              onSaved: (value) {
                password = value;
              },
              onFieldSubmitted: (value) {
                if (formKey.currentState.validate()) {
                  formKey.currentState.save();
                }
              },
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
                      child: hide
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
                        hide = !hide;
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

class Credential {
  final String telephone;
  final String password;

  Credential({this.telephone, this.password});
}
