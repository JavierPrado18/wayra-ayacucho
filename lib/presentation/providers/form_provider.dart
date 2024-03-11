import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wayra_ayacucho/Business/Entities/place.dart';
import 'package:wayra_ayacucho/Business/use_cases/geolocator_servoce.dart';
import 'package:wayra_ayacucho/Business/use_cases/places_service.dart';
import 'package:http/http.dart' as http;

class FormularioProvider extends ChangeNotifier {
  final placeService = PlacesService();

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

  void setImagen(String imagen) {
    imagenController.text = imagen;
    notifyListeners();
  }

Future<String?> uploadImage(String path) async {
    
    //ponemos la url del cloudynari
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/duxzbm4vb/image/upload?upload_preset=trer70za');

    //creamos la peticion POST
    final imageUploadRequest = http.MultipartRequest('POST', url);

    //este es el archibvo que queremos mandar
    final file = await http.MultipartFile.fromPath('file', imagen);

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
    final location = await GeolocatorService().determinePosition();
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

  // Example logic for form submission (replace with your actual implementation)
  void submitForm(Place place) {
    if (validateForm()) {
      // Process form data
      if (place.id == null) {
        placeService.createPlace(place);
      } else {
        placeService.updatePlace(place.id!, place);
      }
    } else {
      print('Formulario inválido');
    }
  }
}
