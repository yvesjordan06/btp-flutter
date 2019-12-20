import 'package:flutter/material.dart';

class ActuPage extends StatelessWidget {
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Actualités'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => ActuTile(),
      ),
    );
  }
}

class ActuTile extends StatelessWidget {
  const ActuTile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Image.network(
                'https://cdn.pixabay.com/photo/2015/12/01/20/28/road-1072823_960_720.jpg'),
          ),
          Text('Hiro')
        ],
      ),
    );
  }
}
