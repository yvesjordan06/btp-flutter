import 'package:btpp/Components/loginFormCard.dart';
import 'package:btpp/State/user.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isSelected = false;
  bool _isLoading =false;
  String _error = '';

  Widget horizontalLine() => Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    child: Container(
      width: 120,
      height: 1.0,
      color: Colors.black26.withOpacity(.2),
    ),
  );

  @override
  void initState() {
    appUser.addListener(_checkAuthStatus);
    super.initState();
  }

  void _checkAuthStatus() {
    if (appUser.currentUser != null) {
      if (appUser.error.isNotEmpty) {
        print('erro happend');
        setState(() {
          _error = appUser.error;
          _isLoading = false;
        });
      } else {
        Navigator.pushReplacementNamed(context, 'app');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    void _login() {
      setState(() {
        _isLoading = true;
      });
      appUser.login('telephone', 'motDePasse');
    }

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
                        SizedBox(
                          height: (35),
                        ),
                        FormCard(disableInput:_isLoading,),
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
                                      style: TextStyle(fontSize: 20)
                                  ): CircularProgressIndicator(backgroundColor: Colors.white,),
                                ),
                                color: Colors.blue,
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
                                    color: Color(0xFF5d74e3),
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
