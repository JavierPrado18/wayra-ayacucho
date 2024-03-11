import 'package:dio/dio.dart';
import 'package:wayra_ayacucho/Business/Entities/place.dart';
import 'package:wayra_ayacucho/Business/Entities/place_dto.dart';

class PlacesService {
  final dio = Dio(BaseOptions(baseUrl: 'http://172.17.0.1:8004/api'));

  Future<List<PlaceDto>> getPlaces() async {
    final response = await dio.get('/Places');
    print(response.data);
    final placesResponse = response.data as List;
    final List<PlaceDto> places =placesResponse.map((place) => PlaceDto.fromJson(place)).toList() ;
    return places;
  }
  Future<Place> getPlaceById(String id) async {
    final response = await dio.get('/Places/$id');
    print(response.data);
    //final placesResponse = response.data as List;
    final Place place =Place.fromJson(response.data) ;
    return place;
  }
  Future<Place> createPlace(Place newPlace) async {
    final response = await dio.post('/Places',data:newPlace
  );
    print(response.data);
    final Place place =Place.fromJson(response.data) ;
    return place;
  }
  Future updatePlace(int id,Place place) async {
    final response = await dio.put('/Places/$id',data: place);
    print(response.data);
    //final placesResponse = response.data as List;
    
  }
  Future deletePlace(int id) async {
    final response = await dio.delete('/Places/$id');
    print(response.data);
    //final placesResponse = response.data as List;
    
  }

}
