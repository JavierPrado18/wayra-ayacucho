import 'package:flutter/material.dart';
import 'package:wayra_ayacucho/Business/Entities/place.dart';
import 'package:wayra_ayacucho/Business/Entities/place_dto.dart';
import 'package:wayra_ayacucho/Business/use_cases/places_service.dart';

class PlacesProvider extends ChangeNotifier {
  final PlacesService placeservice = PlacesService();

  List<PlaceDto> _places = [];

  List<PlaceDto> get places => _places;

  Future<List<PlaceDto>> getPlaces() async {
    _places = await placeservice.getPlaces();
    notifyListeners();
    return _places;
  }

  Future<Place> createPlace(Place newPlace) async {
    final Place place = await placeservice.createPlace(newPlace);
    notifyListeners();
    return place;
  }

  Future updatePlace(int id,Place place) async {
    await placeservice.updatePlace(id,place);
    notifyListeners();
  }

  Future deletePlace( int id) async {
    await placeservice.deletePlace(id);
    notifyListeners();
  }
}
