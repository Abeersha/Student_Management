// import 'dart:io';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_app/core/constants.dart';
import 'package:student_app/model/student_model.dart';

import '../add_student.dart';

class DetailsPage extends StatelessWidget {
final int index;

    Box<Student> studentbox = Hive.box<Student>(boxName);
   DetailsPage({Key? key ,required this.index,
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 233, 225, 225),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('STUDENT DETAILS'),
        centerTitle: true,
      ),
body:ValueListenableBuilder(valueListenable: studentbox.listenable() ,
 builder: (BuildContext context, Box<Student>box,_){
  
  Student? studentDetails = box.getAt(index);
  






   return    Column(
     children: [
        Padding(
         padding: EdgeInsets.all(18.0),
         child: Align(
             child: CircleAvatar(
              // backgroundImage: FileImage(File(studentDetails!.imagee.toString())), ,
              backgroundImage: FileImage(File(studentDetails!.imagee.toString())),
           radius: 80,
         )),
       ),
       const Divider(
         color: Colors.black,
         thickness: 1,
       ),
       kHeight6,
        Text(
         'Name : ${studentDetails.name.toUpperCase()}',
         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
       ),
       kHeight4,
        Text(
         'Age : ${studentDetails.age}',
         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
       ),
       kHeight4,
        Text(
         'Branch :${studentDetails.branch}',
         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
       ),
       kHeight4,
        Text(
         'Email : ${studentDetails.email} ',
         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
       ),
       kHeight6,
       ElevatedButton(onPressed: () {

         Navigator.push(
                context, MaterialPageRoute(builder: (context) => Addstudent(index: index, isEditing: true,editing: studentDetails ,)));



       }, child: Text('Edit Profile'))
     ],
   );
  },),
    );
  }
}
