import 'package:btpp/Models/annonce.dart';
import 'package:btpp/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MetierPage extends StatelessWidget {
  MetierPage({Key key}) : super(key: key);

  List<MetierModel> metier = authBloc.appMetiers ?? [];

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {},
      bloc: authBloc,
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          bloc: authBloc,
          builder: (context, state) {
            return Container(
              child: Scaffold(
                appBar: AppBar(
                  title: Text('Mes Metiers'),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.add_circle),
                      tooltip: 'Ajouter un metier',
                      onPressed: () {
                        Navigator.pushNamed(context, 'metiers/add');
                      },
                    )
                  ],
                ),
                body: ListView.builder(
                  itemCount: authBloc.currentUser.metiers.length,
                  itemBuilder: (context, index) =>
                      ListTile(
                        title: Text(
                            authBloc.currentUser.metiers[index].intitule),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                          onPressed: () {},
                        ),
                      ),
                ),
              ),
            );
          }),
    );
  }
}
