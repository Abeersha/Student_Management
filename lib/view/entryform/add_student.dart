import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_app/core/constants.dart';
import 'package:student_app/model/student_model.dart';
import 'package:student_app/view/entryform/widgets/text_form_fields.dart';

// ignore: must_be_immutable
class Addstudent extends StatefulWidget {
int? index;
bool isEditing;
Student? editing ;


  Addstudent({Key? key,
   this.index,
   this.isEditing=false,
   this.editing,
  }) : super(key: key);

  @override
  State<Addstudent> createState() => _AddstudentState();
}

class _AddstudentState extends State<Addstudent> {
  XFile?  xFile;

  String ? imagepath;

  
  TextEditingController namecontroller = TextEditingController();

  TextEditingController branchcontroller = TextEditingController();

  TextEditingController agecontroller = TextEditingController();

  TextEditingController emailcontroller = TextEditingController();

  Box<Student> studentbox = Hive.box<Student>(boxName);

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
if (widget.isEditing == true){
namecontroller.text = widget.editing!.name;
branchcontroller.text = widget.editing!.branch;
agecontroller.text = widget.editing!.age.toString();
emailcontroller.text = widget.editing!.email;
imagepath = widget.editing!.imagee.toString();



}

   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APPBAR

      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('ADD STUDENT'),
        centerTitle: true,
      ),

      body: ListView(
        children: [
          Center(
            child: Stack(
              children: [
                //  image !=null ?
                // const Padding(
                //   padding: EdgeInsets.only(top: 15),

                //   child: CircleAvatar(
                //     radius: 80,
                //     backgroundImage: NetworkImage(

                //         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGvkLE9Ne2P3N_ZK-5vyXO4RKE3BDEe_26oA&usqp=CAU'),
                //     backgroundColor: Colors.transparent,
                //   ),
                // ):
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage: FileImage(File(imagepath.toString())),
                   // backgroundColor: Colors.black,
                  ),
                ),

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
                        onPressed: () async{
                          ImagePicker imagePicker = ImagePicker();
                          xFile = await imagePicker.pickImage(source: ImageSource.gallery);
                          if(xFile==null)return;
                          imagepath = xFile!.path;
                          setState(() {});
                         
                         
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
                          icon:
                              CupertinoIcons.person_crop_circle_fill_badge_plus,
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
                  ElevatedButton(onPressed: () {}, child: const Text('Cancel')),


                  ElevatedButton(
                      onPressed: () {
                        bool isValid = _formKey.currentState!.validate();

                        if (isValid) {
                          Student newStudent = Student(
                            imagee: imagepath.toString(),
                            name: namecontroller.text.toUpperCase(),
                            branch: branchcontroller.text.toUpperCase(),
                            age: int.parse(agecontroller.text),
                            email: emailcontroller.text,
                          );

                          if (widget.isEditing== true)
                          {
                            studentbox.putAt(widget.index!, newStudent);
                          }else{
                               studentbox.add(newStudent);
                          }

                       
                          Navigator.pop(context);
                        }
                      },
                     child: widget.isEditing?  const Text('Update'):
                     const Text('Submit')
                     
                     
                     )
                ],
              )
            ],
          )
        ],
      ),
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
