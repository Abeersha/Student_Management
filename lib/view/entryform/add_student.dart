import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_app/controller/controller.dart';
import 'package:student_app/core/constants.dart';
import 'package:student_app/model/student_model.dart';
import 'package:student_app/view/entryform/widgets/text_form_fields.dart';

class Addstudent extends StatelessWidget {
  final int? index;
  final bool isEditing;
  final Student? editing;

  Addstudent({
    Key? key,
    this.index,
    this.isEditing = false,
    this.editing,
  }) : super(key: key);

  final TextEditingController namecontroller = TextEditingController();

  final TextEditingController branchcontroller = TextEditingController();

  final TextEditingController agecontroller = TextEditingController();

  final TextEditingController emailcontroller = TextEditingController();

  final Box<Student> studentbox = Hive.box<Student>(boxName);

  final _formKey = GlobalKey<FormState>();

  final Controller obj = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APPBAR

      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('ADD STUDENT'),
        centerTitle: true,
      ),

      body: GetBuilder<Controller>(
          init: Controller(),
          dispose: (_) {
            obj.imagePath = "";
          },
          initState: (state) {
            if (isEditing == true) {
              namecontroller.text = editing!.name;
              branchcontroller.text = editing!.branch;
              agecontroller.text = editing!.age.toString();
              emailcontroller.text = editing!.email;
              obj.imagePath = editing!.imagee.toString();
            }
          },
          builder: (access) {
            return ListView(
              children: [
                Center(
                  child: Stack(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: access.imagePath != null
                              ? CircleAvatar(
                                  radius: 80,
                                  backgroundImage: FileImage(
                                      File(access.imagePath.toString())),
                                )
                              : const CircleAvatar(
                                  radius: 80,
                                )),
                      Positioned(
                        bottom: 3.0,
                        right: 1.0,
                        child: InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: bottomsheet,
                            );
                          },
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.black,
                            child: IconButton(
                              icon: const Icon(
                                Icons.camera_alt,
                                color: Color.fromARGB(255, 184, 188, 196),
                                size: 28.0,
                              ),
                              onPressed: () {
                                obj.pickimage(ImageSource.gallery);
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                kHeight3,
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormFieldWidget(
                              controller: namecontroller,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "required field";
                                }
                                return null;
                              },
                              icon: Icons.person,
                              text: 'Name',
                              type: TextInputType.text,
                            ),
                            kHeight3,
                            TextFormFieldWidget(
                                controller: branchcontroller,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "required field";
                                  }
                                  return null;
                                },
                                icon: CupertinoIcons.person_2_square_stack,
                                text: 'Branch',
                                type: TextInputType.text),
                            kHeight3,
                            TextFormFieldWidget(
                                controller: agecontroller,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "requied field";
                                  }
                                  return null;
                                },
                                icon: CupertinoIcons
                                    .person_crop_circle_fill_badge_plus,
                                text: 'Age',
                                type: TextInputType.number),
                            kHeight3,
                            TextFormFieldWidget(
                              controller: emailcontroller,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "required field";
                                }
                                return null;
                              },
                              icon: CupertinoIcons.mail,
                              text: 'Email',
                              type: TextInputType.emailAddress,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                kHeight4,
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            onPressed: () {}, child: const Text('Cancel')),
                        ElevatedButton(
                            onPressed: () {
                              bool isValid = _formKey.currentState!.validate();

                              if (isValid) {
                                Student newStudent = Student(
                                  imagee: access.imagePath.toString(),
                                  name: namecontroller.text.toUpperCase(),
                                  branch: branchcontroller.text.toUpperCase(),
                                  age: int.parse(agecontroller.text),
                                  email: emailcontroller.text,
                                );

                                if (isEditing == true) {
                                  access.editStudent(index!, newStudent);
                                } else {
                                  access.addStudent(newStudent);
                                }

                                Navigator.pop(context);
                              }
                            },
                            child: isEditing
                                ? const Text('Update')
                                : const Text('Submit'))
                      ],
                    )
                  ],
                )
              ],
            );
          }),
    );
  }

// BOTTOMSHEET
  Widget bottomsheet(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: <Widget>[
          const Text(
            "Choose profile photo",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            ElevatedButton.icon(
                onPressed: () {
                  //  _getFromGallery();
                },
                icon: const Icon(Icons.camera_alt),
                label: const Text('Camera')),
            ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.camera),
                label: const Text('Gallery')),
          ]),
        ],
      ),
    );
  }
}
