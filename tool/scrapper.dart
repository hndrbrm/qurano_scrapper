// Copyright 2022. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:qurano_scrapper/src/api.dart';

Future<void> main() async {
  final StringBuffer contents = StringBuffer();
  contents.write('# ${DateTime.now()}\n');
  contents.write('LOCATION\tTRANSLITERATE\tTRANSLATE\n');

  final List<dynamic> infos = await Api.getAllSurahInformation();
  for (int i = 0; i < infos.length; i++) {
    final int surah = i + 1;

    assert((){
      print('Parsing surah $surah');
      return true;
    }());

    final Map<String, dynamic> info = infos[i];
    for (int j = 0; j < info['aya_count']; j++) {
      final int ayah = j + 1;

      assert((){
        print('Parsing surah $surah ayah $ayah');
        return true;
      }());

      final Map<String, String> lafazs = await Api.getLafazs(
        i + 1,
        info['id_slug'],
        j + 1,
      );

      final Iterable<String> keys = lafazs.keys;
      for (int k = 0; k < keys.length; k++) {
        final String key = keys.elementAt(k);
        contents.write('($surah,$ayah,${k+1})\t$key\t${lafazs[key]}\n');
      }
    }
  }

  final File file = File('ayahs.tsv');
  file.writeAsStringSync(contents.toString(), flush: true);
}
