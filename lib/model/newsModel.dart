// To parse this JSON data, do
//
//     final articles = articlesFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Articles> articlesFromJson(String str) =>
    List<Articles>.from(json.decode(str).map((x) => Articles.fromJson(x)));

class Articles {
  final Source source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final DateTime publishedAt;
  final String content;

  Articles({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory Articles.fromJson(Map<String, dynamic> json) => Articles(
        source: Source.fromJson(json["source"]),
        author: json["author"]?? "",
        title: json["title"]??"",
        description: json["description"]??"",
        url: json["url"]??"",
        urlToImage: json["urlToImage"]??"",
        publishedAt: DateTime.parse(json["publishedAt"]),
        content: json["content"]??"",
      );
}

class Source {
  final String name;

  Source({
    required this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        name: json["name"]??"",
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
