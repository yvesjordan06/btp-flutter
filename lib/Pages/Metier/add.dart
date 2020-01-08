import 'package:btpp/Components/annonce.dart';
import 'package:btpp/Models/annonce.dart';
import 'package:btpp/bloc/bloc.dart';
import 'package:flutter/material.dart';

class AddMetierPage extends StatefulWidget {
  AddMetierPage({Key key}) : super(key: key);

  @override
  _AddMetierPageState createState() => _AddMetierPageState();
}

class _AddMetierPageState extends State<AddMetierPage> {
  List<int> selected = [];
  List<MetierModel> metier = authBloc.appMetiers ?? [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Metiers'),
      ),
      body: ListView.builder(
        itemCount: metier.length,
        itemBuilder: (context, index) => Material(
          child: Tooltip(
            message: metier[index].description,
            child: ListTile(
              isThreeLine: true,
              title: Text(metier[index].intitule),
              subtitle: Text(
                metier[index].description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              leading: Checkbox(
                value: selected.contains(index),
                onChanged: (val) {
                  setState(() {
                    if (val)
                      selected.add(index);
                    else
                      selected.remove(index);
                  });
                },
              ),
              selected: selected.contains(index),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        child: RaisedButton.icon(
          icon: Icon(Icons.save),
          label: Text('Ajouter'),
          onPressed: () {},
        ),
      ),
    );
  }
}
