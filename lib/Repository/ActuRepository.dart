import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:btpp/Functions/Utility.dart';
import 'package:btpp/Models/annonce.dart';
import 'package:btpp/api/chopper.dart';
import 'package:btpp/bloc/bloc.dart';
import 'package:chopper/chopper.dart';
import 'package:path_provider/path_provider.dart';

Future<String> _localPath() async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

List<ActuModel> actuListExample = List<ActuModel>.generate(
    15,
    (index) => ActuModel(
          id: index,
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
    Response a = await actuApi.getActus();
    //print('actu repo 29 ${a.error}');
    //print('actu repo 30 ${a.statusCode}');
    if (!a.isSuccessful)
      throw 'Impossible de traiter cette demande actuellement';

    //print('actu repo 31 ${a.body}');
    try {
      List<ActuModel> actus = List.generate(
        a.body.length,
        (index) => ActuModel.fromJson(a.body[index]),
      );
      return actus.reversed.toList();
    } catch (e) {
      //print('actu repo 37 ${e}');
      throw e;
    }

    // await Future.delayed(Duration(seconds: 4));
    return List.from(actuListExample);
  }

  Future<ActuModel> create(ActuModel actu) async {
    Map<String, dynamic> nouveau = {
      'intitule': actu.intitule,
      'description': actu.description,
      'date_realisation': actu.date.toIso8601String(),
      'lieu': actu.lieu,
      'id_travailleur': int.parse(authBloc.currentUser.id)
    };

    print('actu repo 54 ${actu.assetPictures[0].identifier}');
    print('actu repo 55 ${nouveau}');
    try {
      Response a = await actuApi.createActu(nouveau);
      Response b;

      print('actu repo 58 ${a.statusCode}');
      print('actu repo 59 ${a.body}');
      if (!a.isSuccessful)
        throw 'Impossible de traiter cette demande actuellement';

      String path = await _localPath();
      List<String> images = List();
      for (var asset in actu.assetPictures) {
        Uint8List a = await assetToByte(asset);
        String _localPath = '$path/${asset.name}';
        File file = File(_localPath);

        file.writeAsBytes(a);
        images.add(_localPath);
      }

      b = await actuApi.sendImages(a.body['insert_id'], images);
      if (!a.isSuccessful)
        throw 'Impossible de traiter cette demande actuellement';

      for (var item in images) {
        File(item).deleteSync();
      }
      print('actu repo 67 ${b.statusCode}');
      print('actu repo 68 ${b.body}');
    } catch (e) {
      print('actu repo 57 $e');
      throw 'e';
    }

    // print('actu repo 54 ${a.statusCode}');
    actuListExample = [actu, ...actuListExample];
    //await Future.delayed(Duration(seconds: 4));
    return actu;
  }
}
