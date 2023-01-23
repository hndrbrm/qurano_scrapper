// Copyright 2022. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

import 'package:qurano_scrapper/qurano_scrapper.dart';
import 'package:test/test.dart';

void main() {
  group('A group of Api tests', () {
    test('Check total surah information', () async {
      final List<dynamic> infos = await Api.getAllSurahInformation();
      expect(infos.length, 114);
    });
    test('Check total surah information', () async {
      final Map<String, String> lafazs = await Api.getLafazs(1, 'al-fatihah', 1);
      expect(lafazs.length, 4);
    });
  });
}
