import 'dart:math';

import 'package:btpp/Models/annonce.dart';

List<ActuModel> actuListExample = List<ActuModel>.generate(
    15,
    (index) => ActuModel(
          id: index.toString(),
          intitule: 'Titre de Actu $index',
          lieu: 'Cameroun, Douala',
          description:
              'Ceci est une description de annonce cecui est comme sa pour la $index annonce mais nicky larson aime lauras surement',
          date: DateTime(
            Random().nextInt(2018),
            Random().nextInt(12),
            Random().nextInt(30),
          ),
          pictures: List<String>.generate(
              5,
              (index) =>
                  'https://picsum.photos/id/${Random().nextInt(100)}/200/300'),
        ));

class ActuRepository {
  Future<List<ActuModel>> fetchAll() async {
    await Future.delayed(Duration(seconds: 4));
    return List.from(actuListExample);
  }

  Future<ActuModel> create(ActuModel actu) async {
    actuListExample = [actu, ...actuListExample];
    await Future.delayed(Duration(seconds: 4));
    return actu;
  }
}
