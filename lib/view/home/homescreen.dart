import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:student_app/core/constants.dart';
import 'package:student_app/view/entryform/add_student.dart';
import 'package:student_app/model/student_model.dart';
import 'package:student_app/view/entryform/widgets/details_page.dart';
import 'package:student_app/view/entryform/widgets/edit_profile.dart';
import 'package:student_app/view/entryform/widgets/search.dart';

class Homescreen extends StatelessWidget {
  Homescreen({Key? key}) : super(key: key);

  Box<Student> studentbox = Hive.box<Student>(boxName);

  // Student? student = Hive.openBox(getAT)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions :[
              IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: Search(),
              );
            },
            icon: const Icon(
              Icons.search,
              size: 30,
            ),
          )
            
          ],
          backgroundColor: Colors.black,
          title: Text('STUDENT APP', style: GoogleFonts.oswald(fontSize: 25)),
          centerTitle: true,
        ),
        body: Column(
          children: [
            kHeight2,
            Expanded(
              child: ValueListenableBuilder<Box<Student>>(
                  valueListenable: studentbox.listenable(),
                  builder: (BuildContext context, Box<Student> box, _) {
                    //Students_List//
                    return ListView.separated(
                      itemCount: box.length,
                      separatorBuilder: (context, index) => kHeight2,
                      itemBuilder: (BuildContext context, index) {
                        Student? student = box.getAt(index);

                        return Slidable(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.teal[100],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: FileImage(
                                      File(student!.imagee.toString())),
                                  radius: 20,
                                ),
                                onTap: () {
                                  box.deleteAt(index);
                                },
                                title: Center(
                                  child: Text(
                                    student.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 20),
                                  ),
                                ),
                                subtitle: Center(child: Text(student.branch)),
                                trailing: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailsPage(
                                                  index: index,
                                                )));
                                  },
                                  icon: const Icon(
                                    Icons.arrow_forward,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
            ),
            kHeight2,
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Addstudent()));
          },
        ));
  }
}
