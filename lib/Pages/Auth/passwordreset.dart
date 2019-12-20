import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ResetPasswordPage extends StatelessWidget {
  ResetPasswordPage({Key key}) : super(key: key);
  final PageController _controller = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView(
        children: <Widget>[InputPhone(), ResetCodePage()],
        controller: _controller,
      ),
    );
  }
}

class InputPhone extends StatelessWidget {
  const InputPhone({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(
                    Icons.lock_outline,
                    size: 120,
                    color: Colors.grey[800],
                  ),
                ),
                Text(
                  'Reinitialisez votre mot de passe',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(height: 10),
                TextField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      prefixText: '+237  ',
                      prefixStyle:
                          TextStyle(fontSize: 16.5, color: Colors.grey),
                      labelText: 'Numero de telephone',
                      hintText: 'Entrez votre numero de telephone',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
                      border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: RaisedButton(
                    child: Center(
                      child: Text('Reinitialiser'),
                    ),
                    onPressed: () {},
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

class ResetCodePage extends StatelessWidget {
  const ResetCodePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(
                    Icons.lock_open,
                    size: 120,
                    color: Colors.grey[800],
                  ),
                ),
                Text(
                  'Nous avons envoyer un code de verification par SMS',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(height: 10),
                TextField(
                  maxLength: 6,
                  maxLengthEnforced: true,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Code de verification',
                      hintText: 'Entrez le code reçu par SMS',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
                      border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Vous n\'avez pas encore recu? Renvoyer')),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: RaisedButton(
                    child: Center(
                      child: Text('Reinitialiser'),
                    ),
                    onPressed: () {},
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
