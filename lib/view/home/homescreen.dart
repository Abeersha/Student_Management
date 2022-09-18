import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:student_app/controller/controller.dart';
import 'package:student_app/core/constants.dart';
import 'package:student_app/view/entryform/add_student.dart';
import 'package:student_app/model/student_model.dart';
import 'package:student_app/view/entryform/widgets/details_page.dart';
import 'package:student_app/view/entryform/widgets/search.dart';

// ignore: must_be_immutable
class Homescreen extends StatelessWidget {
  Homescreen({Key? key}) : super(key: key);

  Box<Student> box = Hive.box<Student>(boxName);

  Controller obj = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
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
        body: GetBuilder<Controller>(
            init: Controller(),
            builder: (controller) {
              return Column(
                children: [
                  kHeight2,
                  Expanded(
                    child:
                        //Students_List//
                        ListView.separated(
                      itemCount: box.length,
                      separatorBuilder: (context, index) => kHeight2,
                      itemBuilder: (BuildContext context, index) {
                        Student? student = box.getAt(index);
                        // print(student!.imagee.toString());

                        return Slidable(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
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
                                  // box.deleteAt(index);
                                  controller.delestudent(index);
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
                                  onPressed: () async {
                                    await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailsPage(
                                                  index: index,
                                                )));
                                    controller.update();
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
                    ),
                  ),
                  kHeight2,
                ],
              );
            }),
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
