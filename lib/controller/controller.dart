import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../model/student_model.dart';

class Controller extends GetxController {
  Box<Student> studentbox = Hive.box<Student>(boxName);

  String? imagePath;

  Future pickimage(ImageSource gallery) async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (file == null) return;
    imagePath = file.path;
    update();
  }

  void addStudent(Student studentDetails) {
    studentbox.add(studentDetails);
    update();
  }

  void editStudent(int index, Student studentDetails) {
    studentbox.putAt(index, studentDetails);
  }

  void delestudent(int index) {
    studentbox.deleteAt(index);
    update();
  }
}
