import 'dart:convert';

Place placeFromJson(String str) => Place.fromJson(json.decode(str));

String placeToJson(Place data) => json.encode(data.toJson());

class Place {
    final int? id;
    final double latitude;
    final double longitute;
    final String imageUrl;
    final String description;
    final String title;
    final int idCategory;

    Place({
        this.id,
        required this.latitude,
        required this.longitute,
        required this.imageUrl,
        required this.description,
        required this.title,
        required this.idCategory,
    });

    factory Place.fromJson(Map<String, dynamic> json) => Place(
        id: json["id"],
        latitude: json["latitude"]?.toDouble(),
        longitute: json["longitute"]?.toDouble(),
        imageUrl: json["imageUrl"],
        description: json["description"],
        title: json["title"],
        idCategory: json["idCategory"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "latitude": latitude,
        "longitute": longitute,
        "imageUrl": imageUrl,
        "description": description,
        "title": title,
        "idCategory": idCategory,
    };
}
