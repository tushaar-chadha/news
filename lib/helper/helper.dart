import 'dart:convert';

import 'package:news/model/newsModel.dart';
import 'package:http/http.dart' as http;

class Helper {
  Future<List<Articles>?> getNewsData() async {
    var client = http.Client();
    List totalList = [];
    var url = Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=in&apiKey=635711bea30e4a13a43e70cb79edce06');
    var response = await client.get(url);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      totalList = json["articles"];
      totalList.shuffle();
      return articlesFromJson(jsonEncode(totalList));
    } // Add this line to handle the case where response status code is not 200
  }

  Future<List<Articles>?> getNewsJustForYou(List<String> category) async {
    var client = http.Client();
    var totalList = [];
    for (var elementx in category) {
      var url = Uri.parse(
          'https://newsapi.org/v2/top-headlines?category=${elementx}&country=in&apiKey=635711bea30e4a13a43e70cb79edce06');
      var response = await client.get(url);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        for (var elementy in json["articles"]) {
          elementy["category"] = elementx;
          print(elementy["category"]);
          for (var elementz in json["articles"]) {
            totalList.add(elementz);
          }
        }
      }
    }
    totalList.shuffle();
    return articlesFromJson(jsonEncode(totalList));
  }
}
