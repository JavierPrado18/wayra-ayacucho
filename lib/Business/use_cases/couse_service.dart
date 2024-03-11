import 'package:dio/dio.dart';
import 'package:wayra_ayacucho/Business/Entities/course.dart';

class CourseService {
  final Dio dio = Dio();

  Future<List<Course>> obtenerCourses() async {
    final response = await dio.get('http://172.17.0.1:8002/api/Cursos');
    print(response.data);
    final courses = response.data as List;
    final listCourses = courses.map((j) => Course.fromJson(j)).toList();
    return listCourses;
  }
}
