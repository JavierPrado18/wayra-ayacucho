import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wayra_ayacucho/Business/Entities/festivity.dart';
import 'package:wayra_ayacucho/Business/Entities/place.dart';
import 'package:wayra_ayacucho/Business/use_cases/festivities_service.dart';
import 'package:wayra_ayacucho/Business/use_cases/geolocator_servoce.dart';
import 'package:wayra_ayacucho/Business/use_cases/places_service.dart';
import 'package:http/http.dart' as http;

class FormularioProvider extends ChangeNotifier {
  final placeService = PlacesService();
  final festivityService = FestivitiesService();
  final locationServie = GeolocatorService();

  // Text editing controllers for form fields
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();
  final TextEditingController imagenController = TextEditingController(
      text:
          "https://images.pexels.com/photos/1051076/pexels-photo-1051076.jpeg?auto=compress&cs=tinysrgb&w=300"); // Default image
  final TextEditingController fechaController = TextEditingController();

  // Getters for form field values
  String get titulo => tituloController.text;
  String get descripcion => descripcionController.text;
  String get imagen => imagenController.text;
  DateTime? get fecha => fechaController.text.isNotEmpty
      ? DateTime.parse(fechaController.text)
      : null;
  int categoryId = 1;
  double latitude = 0;
  double longitude = 0;
  int? id;



  // Setters for form field values (updating controllers and notifying listeners)
  void setTitulo(String titulo) {
    tituloController.text = titulo;
  }

  void setDescripcion(String descripcion) {
    descripcionController.text = descripcion;
  }

  void setImagen(String path) async {
    if (path.startsWith("http")) {
      imagenController.text = path;
    } else {
      final newImage = await uploadImage(path);
      imagenController.text = newImage!;
    }

    notifyListeners();
  }

  Future<String?> uploadImage(String path) async {
    //ponemos la url del cloudynari
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/duxzbm4vb/image/upload?upload_preset=trer70za');

    //creamos la peticion POST
    final imageUploadRequest = http.MultipartRequest('POST', url);

    //este es el archibvo que queremos mandar
    final file = await http.MultipartFile.fromPath('file', path);

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final response = await http.Response.fromStream(streamResponse);

    if (response.statusCode != 200 && response.statusCode != 201) {
      return null;
    }
    //

    final responseData = json.decode(response.body);
    return responseData['secure_url'];
  }

  void setFecha(DateTime? fecha) {
    fechaController.text = fecha.toString();
    notifyListeners();
  }

  void setCategoryId(int? value) {
    categoryId = value ?? 1;
    notifyListeners();
  }

  // Additional methods for form management (consider adding based on requirements)
  bool _esFestividad = false; // Default festivity type
  bool get esFestividad => _esFestividad;

  void setEsFestividad(bool value) {
    _esFestividad = value;
    notifyListeners();
  }

  bool _pedirPermisosUbicacion = false; // Default location permission request
  bool get pedirPermisosUbicacion => _pedirPermisosUbicacion;

  void setPedirPermisosUbicacion(bool value) async {
    _pedirPermisosUbicacion = value;

    final location = await locationServie.determinePosition();
    latitude = location.latitude;
    longitude = location.longitude;
    notifyListeners();
  }

  // Example logic for form validation (can be expanded for specific checks)
  bool validateForm() {
    if (titulo.isEmpty) {
      return false;
    }
    if (descripcion.isEmpty) {
      return false;
    }
    // Add more validation checks as needed
    return true;
  }

  void changeValuesForm(
      {String? title,
      String? description,
      String? image,
      DateTime? fecha,
      bool? isFestivity,
      int? category,
      double? latitude,
      int? id,
      double? longitude}) {
    setTitulo(title ?? "");
    setDescripcion(description ?? "");
    setImagen(image ??
        "https://images.pexels.com/photos/1051076/pexels-photo-1051076.jpeg?auto=compress&cs=tinysrgb&w=300");
    setFecha(fecha ?? DateTime.now());
    setEsFestividad(isFestivity ?? false);
    setCategoryId(category);
    this.latitude = latitude ?? 0;
    this.latitude = longitude ?? 0;
    this.id = id;
  }

  void submitForm() async {
    if (validateForm()) {

      if (_esFestividad) {
        final festivity = Festivity(
            nombre: titulo,
            descripcion: descripcion,
            imgUrl: imagen,
            dia: fecha?.day,
            mes: fecha?.month,
            id: id);
        if (festivity.id == null) {
          await festivityService.createFestivity(festivity);
        } else {
          await festivityService.updateFestivity(festivity.id!, festivity);
        }

      }else{
        final place = Place(
          latitude: latitude,
          longitute: longitude,
          imageUrl: imagen,
          description: descripcion,
          title: titulo,
          idCategory: categoryId,
          id: id);
        if (place.id == null) {
          await placeService.createPlace(place);
        } else {
          await placeService.updatePlace(place.id!, place);
        }
        setPedirPermisosUbicacion(false);
      }
      notifyListeners();
    }
  }
}
