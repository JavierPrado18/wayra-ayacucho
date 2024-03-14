import 'package:dio/dio.dart';
import 'package:wayra_ayacucho/Business/Entities/place.dart';
import 'package:wayra_ayacucho/Business/Entities/place_dto.dart';

class PlacesService {
  final dio = Dio(BaseOptions(baseUrl: 'http://172.17.0.1:8004/api'));

  Future<List<PlaceDto>> getPlaces() async {
    final response = await dio.get('/Places');
    final placesResponse = response.data as List;
    final List<PlaceDto> places =placesResponse.map((place) => PlaceDto.fromJson(place)).toList() ;
    return places;
  }

  Future<Place> getPlaceById(String id) async {
    final response = await dio.get('/Places/$id');
    final Place place =Place.fromJson(response.data) ;
    return place;
  }

  Future<Place> createPlace(Place newPlace) async {
    final response = await dio.post('/Places',data:{
      "latitude": newPlace.latitude,
      "longitute":newPlace.longitute,
      "imageUrl": newPlace.imageUrl,
      "description": newPlace.description,
      "title": newPlace.title,
      "idCategory": newPlace.idCategory
    }
  );
    final Place place =Place.fromJson(response.data) ;
    return place;
  }
  Future updatePlace(int id,Place place) async {
    await dio.put('/Places/$id',data: {
      "id": place.id,
      "latitude": place.latitude,
      "longitute": place.longitute,
      "imageUrl": place.imageUrl,
      "description": place.description,
      "title": place.title,
      "idCategory": place.idCategory
    });
    
  }
  Future deletePlace(int id) async {
    await dio.delete('/Places/$id');
    
  }

}
