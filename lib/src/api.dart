// Copyright 2022. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class Api {
  const Api._();

  static const String _url = 'https://qurano.com';

  /// Get all surah information.
  static Future<List<dynamic>> getAllSurahInformation() async {
    final String url = '$_url/dist/data/sura_slug.json';

    final Uri uri = Uri.parse(url);
    final http.Response response = await http.get(uri);
    final List<dynamic> json = jsonDecode(response.body);

    return json;
  }

  /// Get detail information on a certain ayah.
  ///
  /// Argument [surah] is the surah index.
  /// The value is between 1 to 114.
  ///
  /// Argument [surahSlug] is the slug fetched from [getAllSurahInformation].
  ///
  /// Argument [ayah] is the starting ayah index which will be retrieved.
  /// The value start from 1.
  static Future<Map<String, String>> getLafazs(
    int surah,
    String surahSlug,
    int ayah,
  ) async {
    assert(1 <= surah && surah <= 114);
    assert(1 <= ayah);

    final String url = '$_url/id/$surah-$surahSlug/ayat-$ayah/';

    final Uri uri = Uri.parse(url);
    final HttpClient client = HttpClient();
    final HttpClientRequest request = await client.getUrl(uri);
    final HttpClientResponse response = await request.close();
    final String content = await response.transform(utf8.decoder).join();

    final Document document = parse(content);
    final List<Element> elements = document
        .getElementsByClassName('quran-container')
        .first
        .children;

    final Map<String, String> result = <String, String>{};

    for (final Element element in elements) {
      result[element.children[1].text.trim()] = element.children[2].text.trim();
    }

    return result;
  }
}
