import 'package:flutter/material.dart';
import 'package:wayra_ayacucho/Business/Entities/place.dart';
import 'package:wayra_ayacucho/Business/use_cases/places_service.dart';

class PlaceDetailProvider extends ChangeNotifier {
  final PlacesService placeservice = PlacesService();
  Future<Place> getPlaceById(String id) async {
    final place = await placeservice.getPlaceById(id);
    notifyListeners();
    return place;
  }

    Future updatePlace(int id,Place place) async {
    await placeservice.updatePlace(id,place);
    notifyListeners();
  }

}