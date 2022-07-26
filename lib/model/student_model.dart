import 'package:hive_flutter/hive_flutter.dart';

part 'student_model.g.dart';


@HiveType(typeId: 1)
class Student {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String branch;
  @HiveField(2)
  final int age;
  @HiveField(3)
  final String email;
   @HiveField(4)
  String? imagee;
  

  Student({
    required this.name,
    required this.branch,
    required this.age,
    required this.email,
    required this.imagee,
  });
}

 const String boxName = "Student";
