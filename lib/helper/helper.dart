import 'dart:convert';

import 'package:news/model/newsModel.dart';
import 'package:http/http.dart' as http;

class Helper {
  Future<List<Articles>?> getNewsData() async {
    var client = http.Client();
    var url = Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=in&apiKey=635711bea30e4a13a43e70cb79edce06');
    var response = await client.get(url);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      print(jsonEncode(json["articles"]));
      return articlesFromJson(jsonEncode(json["articles"]));
    } // Add this line to handle the case where response status code is not 200
  }
}
