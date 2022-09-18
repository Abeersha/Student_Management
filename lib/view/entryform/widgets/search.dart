import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:student_app/model/student_model.dart';
import 'package:student_app/view/entryform/widgets/details_page.dart';

class Search extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, query);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(query),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    Box<Student> studentBox = Hive.box<Student>(boxName);

    List<Student> student = studentBox.values.toList();

    final searchItem = query.isEmpty
        ? student
        : student
            .where(
              (element) => element.name.toLowerCase().contains(
                    query.toLowerCase().toString(),
                  ),
            )
            .toList();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.separated(
          itemCount: searchItem.length,
          itemBuilder: (context, index) {
            // StudentModel? student = box.getAt(index);
            return Card(
              color: const Color.fromARGB(255, 51, 51, 51),
              shadowColor: Colors.white,
              elevation: 8,
              // shape: BeveledRectangleBorder(
              //   borderRadius: BorderRadius.circular(20),
              // ),
              shape: const StadiumBorder(
                side: BorderSide(
                  color: Colors.white,
                  width: 1.8,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  iconColor: Colors.red,
                  textColor: Colors.white,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsPage(
                          index: student.indexWhere((element) =>
                              element.name == searchItem[index].name),
                        ),
                      ),
                    );
                  },
                  leading: searchItem[index].imagee == null
                      ? const CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage("assets/download.jpeg"),
                        )
                      : CircleAvatar(
                          backgroundImage: FileImage(
                            File(searchItem[index].imagee.toString()),
                          ),
                          radius: 30,
                        ),
                  title: Text(searchItem[index].name),
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: 10,
            );
          },
        ),
      ),
    );
  }
}
