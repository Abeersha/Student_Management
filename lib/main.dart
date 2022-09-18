

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:student_app/view/home/homescreen.dart';
import 'package:student_app/model/student_model.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // final directory =await getApplicationDocumentsDirectory();
  await Hive.initFlutter();

  
    Hive.registerAdapter(StudentAdapter());
  
  
  await Hive.openBox<Student>(boxName);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  Homescreen(),
    );
  }
}
