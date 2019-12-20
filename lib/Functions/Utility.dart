import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

Future<Uint8List> assetToByte(Asset asset) async {
  ByteData temp = await asset.getByteData();

  return temp.buffer.asUint8List();
}

class AppColor {
  Color primaryColor() => hexToColor(code: '#2962ff');
  Color accentColor() => hexToColor(code: '#ef6c00');
}

Color hexToColor({String code}) {
  return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

String timeAgo(DateTime datetime) {
  final intervals = {
    'an': 31536000,
    'mois': 2592000,
    'semaine': 604800,
    'jour': 86400,
    'heure': 3600,
    'minute': 60,
    // 'seconde': 1
  };
  final diff = datetime.difference(DateTime.now()).inSeconds * -1;
  if (diff < 59 && diff > 0) {
    return 'A l\instant';
  }

  for (int i = 0; i < intervals.length; i++) {
    int current = (diff / intervals.values.toList()[i]).floor();
    if (current >= 1) {
      if (current == 1 || intervals.keys.toList()[i] == 'mois') {
        return 'Il y\'a ' +
            current.toString() +
            ' ' +
            intervals.keys.toList()[i];
      }
      return 'Il y\'a ' +
          current.toString() +
          ' ' +
          intervals.keys.toList()[i] +
          's';
    }
  }
  return 'Dans le future';
}
