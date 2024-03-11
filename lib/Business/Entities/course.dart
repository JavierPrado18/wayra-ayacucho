class Course {
  final int id;
  final String name;
  final String area;

  Course({required this.id, required this.name, required this.area});
  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      name: json['nombre'],
      area: json['departamento'],
    );
  }
}
