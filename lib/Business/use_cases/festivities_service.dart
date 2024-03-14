import 'package:dio/dio.dart';
import 'package:wayra_ayacucho/Business/Entities/festivity.dart';

class FestivitiesService {
  final dio = Dio(BaseOptions(baseUrl: 'http://172.17.0.1:8004/api'));

  Future<List<Festivity>> getFestivities() async {
    final response = await dio.get('/Festividades');
    final festivitiesResponse = response.data as List;
    final List<Festivity> festivities = festivitiesResponse
        .map((festivity) => Festivity.fromJson(festivity))
        .toList();
    return festivities;
  }

  Future<Festivity> getFestivityById(String id) async {
    final response = await dio.get('/Festividades/$id');
    final Festivity festivity = Festivity.fromJson(response.data);
    return festivity;
  }

  Future<Festivity> createFestivity(Festivity newFestivity) async {
    final response = await dio.post('/Festividades', data: {
      "nombre": newFestivity.nombre,
      "descripcion": newFestivity.descripcion,
      "imgUrl": newFestivity.imgUrl,
      "dia": newFestivity.dia,
      "mes": newFestivity.mes,
    });
    final Festivity festivity = Festivity.fromJson(response.data);
    return festivity;
  }

  Future updateFestivity(int id, Festivity festivity) async {
    await dio.put('/Festividades/$id', data: {
      "id": id,
      "nombre": festivity.nombre,
      "descripcion": festivity.descripcion,
      "imgUrl": festivity.imgUrl,
      "dia": festivity.dia,
      "mes": festivity.mes,
    });
  }

  Future deleteFestivity(int id) async {
    await dio.delete('/Festividades/$id');
  }
}
