import '../../Functions/Colors.dart';
import '../../State/user.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading =false;
  String _error = '';
  bool visiblePassword = false;
  final phone = TextEditingController();
  final password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    phone.dispose();
    password.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState.validate()) {
      print(phone.value.text);
      print(password.value.text) ;
      setState(() {
        _isLoading = true;
        _error = '';
      });
      appUser.login(phone.value.text, password.value.text);
    }

  }

  Widget appForm() => Form(
    key: _formKey,
    autovalidate: true,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          // ignore: missing_return
          validator: (value) {
            if(int.tryParse(value) == null) {
              return 'Entrez un numero de telephone valide';
            }
            if (value.length < 1) {
              return 'Le numéro de téléphone est necessaire';
            }
            if (value.length < 7) {
              return 'Le numéro de téléphone trop court';
            }
          },
          keyboardType: TextInputType.phone,
          obscureText: false,
          controller: phone,
          decoration: InputDecoration(
            enabled: !_isLoading,
            labelText: 'Numéro de Telephone',
            hintText: 'Mot de passe',
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
          enabled: !_isLoading,
          // ignore: missing_return
          validator: (value) {
            if (value.length < 1) {
              return 'Le mot de passe est necessaire';
            }
          },
          obscureText: visiblePassword,
          controller: password,
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
                  child: visiblePassword ? Icon(Icons.visibility, size: 20,) : Icon(Icons.visibility_off, size: 20,),
                ),
                onTap: () {
                  setState(() {
                    print('see');
                    visiblePassword = !visiblePassword;
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
            Text('Mot de passe oublié?',
                style: TextStyle(
                  color: AppColors.primary,
                  fontFamily: 'Poppins-Medium',
                  fontSize: 12,
                ))
          ],
        )
      ],
    ),
  );

  @override
  void initState() {
    appUser.addListener(_checkAuthStatus);
    super.initState();
  }

  void _checkAuthStatus() {

      if (appUser.error.isNotEmpty) {
        setState(() {
          _error = appUser.error;
          _isLoading = false;
        });
      } else if (appUser.currentUser != null) {
        Navigator.pushReplacementNamed(context, 'app');
      }

  }

  @override
  Widget build(BuildContext context) {

    print(_isLoading.toString());
    return new Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 60.0),
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
                          child: _error.isNotEmpty ? Center(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                  _error,
                                style: TextStyle(color: Colors.red, fontSize: 12),
                              ),
                            ),
                          ) : SizedBox(
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
                                onPressed: !_isLoading ? _login : null,
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100)
                                  ),
                                  child: !_isLoading ? Text(
                                      'Se Connecter',
                                      style: TextStyle(fontSize: 20, color: Colors.white)
                                  ): CircularProgressIndicator(backgroundColor: Colors.white,),
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
                              style: TextStyle(
                                  fontFamily: 'Poppins-Medium'
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Text(
                                  'Creer un compte',
                                  style: TextStyle(
                                    fontFamily: 'Poppins-Bold',
                                    color: AppColors.primary,
                                  )
                              ),
                            )
                          ],
                        )
                      ],
                    )
                )
            ),
          ],
        )
    );
  }
}
