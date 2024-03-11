import 'package:flutter/material.dart';
import 'package:wayra_ayacucho/Business/Entities/course.dart';
import 'package:wayra_ayacucho/Business/use_cases/couse_service.dart';

class CourseProvider extends ChangeNotifier {
  final CourseService courseService = CourseService();

  List<Course> _courses = [];

  List<Course> get courses => _courses;

  Future<List<Course>> obtenerCourses() async {
    _courses = await courseService.obtenerCourses();
    notifyListeners();
    return _courses;
  }
}
