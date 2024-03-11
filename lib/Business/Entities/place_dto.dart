
import 'dart:convert';

List<PlaceDto> placeDtoFromJson(String str) => List<PlaceDto>.from(json.decode(str).map((x) => PlaceDto.fromJson(x)));

String placeDtoToJson(List<PlaceDto> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PlaceDto {
    final int id;
    final String imageUrl;
    final String title;
    final int idCategory;

    PlaceDto({
        required this.id,
        required this.imageUrl,
        required this.title,
        required this.idCategory,
    });

    factory PlaceDto.fromJson(Map<String, dynamic> json) => PlaceDto(
        id: json["id"],
        imageUrl: json["imageUrl"],
        title: json["title"],
        idCategory: json["idCategory"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "imageUrl": imageUrl,
        "title": title,
        "idCategory": idCategory,
    };
}
