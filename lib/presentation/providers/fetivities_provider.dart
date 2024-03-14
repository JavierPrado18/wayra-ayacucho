import 'package:flutter/material.dart';
import 'package:wayra_ayacucho/Business/Entities/festivity.dart';
import 'package:wayra_ayacucho/Business/use_cases/festivities_service.dart';

class FestivitiesProvider extends ChangeNotifier {
  final FestivitiesService festivitiesService = FestivitiesService();

  List<Festivity> _festivities = [];

  List<Festivity> get places => _festivities;

  Future<List<Festivity>> getFestivities() async {
    _festivities = await festivitiesService.getFestivities();
    notifyListeners();
    return _festivities;
  }

  Future<Festivity> getFestivityById(String id) async {
    final festivity = await festivitiesService.getFestivityById(id);
    notifyListeners();
    return festivity;
  }

  // Future<Festivity> createPlace(Place newPlace) async {
  //   final Place place = await placeservice.createPlace(newPlace);
  //   getPlaces();
  //   return place;
  // }

  // Future updatePlace(int id, Place place) async {
  //   await placeservice.updatePlace(id, place);
  //   getPlaces();
  // }

  Future deleteFestivity(int id) async {
    await festivitiesService.deleteFestivity(id);
    getFestivities();
  }
}
