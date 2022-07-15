import 'package:cas_finance_management/presentation/authentication_pages/authentication_page.dart';
import 'package:cas_finance_management/presentation/authentication_pages/login_form.dart';
import 'package:cas_finance_management/presentation/screens/course/course_edit_page.dart';

import 'package:cas_finance_management/presentation/widgets/widgets.dart';

import 'package:cas_finance_management/repository/firebase/firestore_services/firestore_course.dart';
import 'package:cas_finance_management/repository/firebase_model_class/course_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../configuration.dart';

class CoursePage extends StatefulWidget {
  static const routeName = '/courses';

  const CoursePage({Key? key}) : super(key: key);

  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  late Responsive _responsive;
  final TextEditingController _courseTitleController = TextEditingController();
  final TextEditingController _courseTeacherController =
      TextEditingController();
  final TextEditingController _courseFeeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    _responsive = Responsive(
        height: _size.height,
        width: _size.width,
        size: _size,
        aspectRatio: _size.aspectRatio);

    Future<void> _addCourseDialog() async {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Add Course'),
                scrollable: true,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                content: SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InputFormField(
                        labelText: 'Course title',
                        hintText: 'Android',
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        controller: _courseTitleController,
                      ),
                      InputFormField(
                        labelText: 'Course Teacher',
                        hintText: 'Noman Ameer Khan',
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        controller: _courseTeacherController,
                      ),
                      InputFormField(
                        labelText: 'Course Fee',
                        hintText: '50000.00',
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        controller: _courseFeeController,
                      )
                    ],
                  ),
                ),
                actions: <Widget>[
                  IconButton(
                      onPressed: () {
                        FireStoreCourse fireStoreCourse = FireStoreCourse();
                        fireStoreCourse.addCourse(
                            courseTitle: _courseTitleController.text,
                            courseTeacher: _courseTeacherController.text,
                            courseFee: double.parse(_courseFeeController.text));
                      },
                      icon: const Icon(Icons.post_add)),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.cancel))
                ],
              ));
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              userAuth.logOut().then((value) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    AuthenticationPage.routeName,
                    (Route<dynamic> route) => false);
              });
            },
            icon: const Icon(Icons.logout)),
      ),
      body: CourseList(
        responsive: _responsive,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addCourseDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CourseList extends StatelessWidget {
  final Responsive? responsive;

  const CourseList({Key? key, this.responsive}) : super(key: key);

  Widget _courseView({
    String? courseTitle = 'Course title',
    String? courseTeacher = 'Course Teacher',
    double? courseFee = 0.00,
    VoidCallback? onDeleteTap,
    VoidCallback? onEditTap,
    VoidCallback? onViewGroupTap,
  }) {
    double _containerHeight = responsive!.height! * 0.40;
    double _containerWidth = responsive!.width! * 0.50;

    return Card(
      elevation: 8.0,
      child: Container(
        width: _containerWidth,
        height: _containerHeight,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Positioned(
                right: _containerWidth * 0,
                top: _containerHeight * 0,
                child: IconButton(
                    onPressed: onDeleteTap,
                    icon: const Icon(
                      Icons.delete_forever_outlined,
                      color: ColorSchema.blue,
                    ))),
            Positioned(
                top: _containerHeight * 0,
                right: _containerWidth * 0.20,
                child: IconButton(
                  onPressed: onEditTap,
                  icon: const Icon(
                    Icons.edit_outlined,
                    color: ColorSchema.blue,
                  ),
                )),
            Positioned(
                top: _containerHeight * 0.12,
                right: _containerWidth * 0.35,
                child: Container(
                  height: _containerWidth * 0.30,
                  width: _containerWidth * 0.30,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 1, color: ColorSchema.grey),
                      image: const DecorationImage(
                          image: AssetImage('assets/images/courseIcon.jpg'),
                          fit: BoxFit.cover)),
                )),
            Positioned(
                top: _containerHeight * 0.32,
                right: _containerWidth * 0.03,
                left: _containerWidth * 0.03,
                child: Text(
                  '$courseTitle',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                )),
            Positioned(
                top: _containerHeight * 0.45,
                right: _containerWidth * 0.06,
                left: _containerWidth * 0.06,
                child: Text(
                  '$courseTeacher',
                  textAlign: TextAlign.center,
                )),
            Positioned(
                top: _containerHeight * 0.58,
                right: _containerWidth * 0.06,
                left: _containerWidth * 0.06,
                child: Text(
                  'Fee: $courseFee',
                  textAlign: TextAlign.center,
                )),
            Positioned(
              top: _containerHeight * 0.68,
              left: _containerWidth * 0.15,
              right: _containerWidth * 0.15,
              child: GestureDetector(
                onTap: onViewGroupTap,
                child: Container(
                  height: _containerHeight * 0.15,
                  alignment: Alignment.center,
                  child: Text(
                    'View Groups',
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 12),
                  ),
                  decoration: const BoxDecoration(
                      color: ColorSchema.blue,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String _uid = FirebaseAuth.instance.currentUser!.uid;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(_uid)
          .collection('course')
          .orderBy('courseServerStamp', descending: true)
          .snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasData) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: responsive!.width! * 0.50,
                mainAxisExtent: responsive!.height! * 0.35),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot userData = snapshot.data!.docs[index];

              Map<String, dynamic> course =
                  userData.data() as Map<String, dynamic>;

              Course _cour = Course.fromMap(course);

              return _courseView(
                courseTitle: _cour.courseTitle,
                courseTeacher: _cour.courseTeacher,
                courseFee: _cour.courseFee,
                onViewGroupTap: () {},
                // onViewGroupTap
                onEditTap: () {
                  Navigator.pushNamed(context, CourseEditPage.routeName,
                      arguments: ScreenArguments(
                          courseTitle: _cour.courseTitle,
                          courseTeacher: _cour.courseTeacher,
                          courseFee: _cour.courseFee,
                          documentId: userData.id,
                          userId: _uid));
                },
                onDeleteTap: () => showDeleteWarningDialog(
                  context: context,
                  onTap: () async {
                    Navigator.pop(context);
                    await FireStoreCourse().deleteCourse(docId: userData.id);
                  },
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              overflow: TextOverflow.ellipsis,
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class ScreenArguments {
  final String? documentId;
  final String? courseTitle;
  final String? userId;
  final String? courseTeacher;
  final double? courseFee;

  ScreenArguments(
      {this.courseTeacher,
      this.courseFee,
      this.documentId,
      this.courseTitle,
      this.userId});
}
