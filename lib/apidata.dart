import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;



// class getapidata extends ChangeNotifier {
//   Feed? fd;
//   bool status = false;
//
//   Future<void> getapi() async {
//     var url = Uri.parse(
//         'https://rss.applemarketingtools.com/api/v2/us/apps/top-free/50/apps.json');
//     var response = await http.get(url);
//     print('Response status: ${response.statusCode}');
//     var map = jsonDecode(response.body);
//     print('map status: ${map}');
//     fd = Feed.fromJson(map);
//     status = true;
//     notifyListeners();
//
//     // print(await http.read(Uri.https('example.com', 'foobar.txt')));
//   }
// }

class Apps {
  Feed feed;

  Apps({
    required this.feed,
  });

  factory Apps.fromJson(Map json) => Apps(
    feed: Feed.fromJson(json["feed"]),
  );

  Map<String, dynamic> toJson() => {
    "feed": feed.toJson(),
  };
}

class Feed {
  String title;
  String id;
  Author author;
  List<Link> links;
  String copyright;
  String country;
  String icon;
  String updated;
  List<Result> results;

  Feed({
    required this.title,
    required this.id,
    required this.author,
    required this.links,
    required this.copyright,
    required this.country,
    required this.icon,
    required this.updated,
    required this.results,
  });

  factory Feed.fromJson(Map json) => Feed(
    title: json["title"],
    id: json["id"],
    author: Author.fromJson(json["author"]),
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    copyright: json["copyright"],
    country: json["country"],
    icon: json["icon"],
    updated: json["updated"],
    results:
    List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "id": id,
    "author": author.toJson(),
    "links": List<dynamic>.from(links.map((x) => x.toJson())),
    "copyright": copyright,
    "country": country,
    "icon": icon,
    "updated": updated,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Author {
  String name;
  String url;

  Author({
    required this.name,
    required this.url,
  });

  factory Author.fromJson(Map json) => Author(
    name: json["name"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "url": url,
  };
}

class Link {
  String self;

  Link({
    required this.self,
  });

  factory Link.fromJson(Map json) => Link(
    self: json["self"],
  );

  Map<String, dynamic> toJson() => {
    "self": self,
  };
}

class Result {
  String artistName;
  String id;
  String name;
  DateTime releaseDate;
  Kind kind;
  String artworkUrl100;
  List<Genre> genres;
  String url;

  Result({
    required this.artistName,
    required this.id,
    required this.name,
    required this.releaseDate,
    required this.kind,
    required this.artworkUrl100,
    required this.genres,
    required this.url,
  });

  factory Result.fromJson(Map json) => Result(
    artistName: json["artistName"],
    id: json["id"],
    name: json["name"],
    releaseDate: DateTime.parse(json["releaseDate"]),
    kind: kindValues.map[json["kind"]]!,
    artworkUrl100: json["artworkUrl100"],
    genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "artistName": artistName,
    "id": id,
    "name": name,
    "releaseDate":
    "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
    "kind": kindValues.reverse[kind],
    "artworkUrl100": artworkUrl100,
    "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
    "url": url,
  };
}

class Genre {
  String genreId;
  String name;
  String url;

  Genre({
    required this.genreId,
    required this.name,
    required this.url,
  });

  factory Genre.fromJson(Map json) => Genre(
    genreId: json["genreId"],
    name: json["name"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "genreId": genreId,
    "name": name,
    "url": url,
  };
}

enum Kind { APPS }

final kindValues = EnumValues({"apps": Kind.APPS});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}