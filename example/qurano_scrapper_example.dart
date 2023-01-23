// Copyright 2022. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

import 'package:qurano_scrapper/qurano_scrapper.dart';

Future<void> main() async {
  final List<dynamic> awesome = await Api.getAllSurahInformation();
  print(awesome);
  final lafazs = await Api.getLafazs(1, 'al-fatihah', 1);
  print(lafazs);
}
