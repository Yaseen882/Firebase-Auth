// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cas_finance_management/presentation/widgets/widgets.dart';

import 'package:cas_finance_management/repository/firebase_model_class/course_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

List _courseDropDownList = <String>[];
// Loading Data From Firebase
Future<void> populatingList() async {
  String _uid = FirebaseAuth.instance.currentUser!.uid;
  final QuerySnapshot result = await FirebaseFirestore.instance
      .collection('users')
      .doc(_uid)
      .collection('course')
      .orderBy('courseServerStamp', descending: true)
      .get();
  final List<DocumentSnapshot> _documents = result.docs;
  for (var element in _documents) {
    var cour = Course.fromMap(element.data() as Map<String, dynamic>);
    _courseDropDownList.add(cour.courseTitle);

    print('DocID: ${cour.courseTitle}');
    print(_courseDropDownList.length);
  }
}

// End populating

class EnrolledGroupsPage extends StatefulWidget {
  static const routeName = '/enrolled_groups';
  const EnrolledGroupsPage({Key? key}) : super(key: key);

  @override
  _EnrolledGroupsPageState createState() => _EnrolledGroupsPageState();
}

class _EnrolledGroupsPageState extends State<EnrolledGroupsPage> {
  //final TextEditingController _timePickerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: Center(child: CourseDropDown())
          // Center(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: <Widget>[
          //       InputFormField(
          //         labelText: 'Lecture Time',
          //         hintText: TimeOfDay.now().format(context).toLowerCase(),
          //         readOnly: true,
          //         controller: _timePickerController,
          //         onTap: () async {
          //           TimeOfDay? lectureTime;
          //           lectureTime = await showTimePicker(
          //             initialTime: TimeOfDay.now(),
          //             context: context,
          //           );
          //           _timePickerController.text =
          //               lectureTime!.format(context).toLowerCase();
          //         },
          //         icon: const Icon(Icons.access_time),
          //         keyboardType: TextInputType.datetime,
          //         textInputAction: TextInputAction.next,
          //       ),
          //       InputFormField(
          //         labelText: 'Group Title',
          //         hintText: 'Flutter F3',
          //         icon: const Icon(Icons.groups_outlined),
          //         keyboardType: TextInputType.text,
          //         textInputAction: TextInputAction.next,
          //       ),
          //       CourseDropDown(),
          //       InputFormField(
          //         labelText: 'Group CR',
          //         hintText: 'John Doe',
          //         icon: const Icon(Icons.person_outline),
          //         keyboardType: TextInputType.text,
          //         textInputAction: TextInputAction.done,
          //       ),
          //     ],
          //   ),
          // ),
          ),
    );
  }
}

class CourseDropDown extends StatefulWidget {
  const CourseDropDown({Key? key}) : super(key: key);

  @override
  _CourseDropDownState createState() => _CourseDropDownState();
}

class _CourseDropDownState extends State<CourseDropDown> {
  var _chosenValue = 'Select Course';
  @override
  Widget build(BuildContext context) {
    Provider.of<LoadCourseList>(context).loadingCourseList();
    return Consumer<LoadCourseList>(
      builder: (context, value, child) => SizedBox(
        height: 100,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: DropdownButton<dynamic>(
            focusColor: Colors.white,
            value: _chosenValue,

            //elevation: 5,
            style: TextStyle(color: Colors.white),
            iconEnabledColor: Colors.black,
            items: _courseDropDownList
                .map<DropdownMenuItem<dynamic>>((dynamic value) {
              return DropdownMenuItem<dynamic>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(color: Colors.black),
                ),
              );
            }).toList(),
            hint: Text(
              "Select Course",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),

            onChanged: (value) {
              _chosenValue = value;
              Provider.of<LoadCourseList>(context).dropDownItemSlected();
            },
          ),
        ),
      ),
    );
  }
}

class LoadCourseList extends ChangeNotifier {
  void loadingCourseList() async {
    if (_courseDropDownList.isEmpty) {
      _courseDropDownList.add('Select Course');
      await populatingList();

      notifyListeners();
    }
  }

  void dropDownItemSlected() {
    notifyListeners();
  }
}
