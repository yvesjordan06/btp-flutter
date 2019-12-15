import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';


class FormCard extends StatelessWidget {
  @override
  final bool disableInput;

  const FormCard({Key key, this.disableInput = false}) : super(key: key);
  Widget build(BuildContext context) {
    return Container(

        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                obscureText: false,
                decoration: InputDecoration(
                    enabled: !disableInput,
                    labelText: 'Numéro de Telephone',
                    hintText: 'Mot de passe',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0 ),
                    errorText: 'Entrez un numéro de telephone',
                    border: OutlineInputBorder(
                    ),
                    prefixIcon: Icon(Icons.person, size: 20,),
                ),
              ),
              SizedBox(
                height:30,
              ),
              TextField(
                enabled: !disableInput,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Mot de passe',
                    hintText: 'Mot de passe',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0 ),
                  errorText: 'Un mot de passe est necessaire',
                  border: OutlineInputBorder(
                  ),
                  prefixIcon: Icon(Icons.lock, size: 20,),
                  suffix: Container(height: 5,child: IconButton(padding: EdgeInsets.all(0), iconSize:20, icon: Icon(Icons.verified_user), onPressed: null))
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                      'Mot de passe oublié?',
                      style: TextStyle(
                        color: Colors.blue,
                        fontFamily: 'Poppins-Medium',
                        fontSize: 12,
                      )
                  )
                ],
              )
            ],
          ),
        )
    );
  }
}