// ignore_for_file: avoid_print

import 'package:cas_finance_management/repository/firebase/firebase_auth/firebase_auth_services.dart';
import 'package:cas_finance_management/repository/firebase_model_class/course_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreCourse {
  late User _user;
  FireStoreCourse() {
    _user = UserAuthentication.firebaseUser!;
  }

  final Course course = Course();
  bool isCourseAdded = false;
  bool isCourseRemoved = false;
  bool isAddingError = false;
  bool isRemovingError = false;

  String? get uid => _user.uid;

  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> addCourse(
      {String? courseTitle, String? courseTeacher, double? courseFee}) async {
    DocumentReference documentReference = _userCollection.doc(uid);

    return documentReference
        .collection('course')
        .doc()
        .set((Course(
                courseServerStamp: FieldValue.serverTimestamp(),
                courseTitle: courseTitle,
                courseTeacher: courseTeacher,
                courseFee: courseFee)
            .toMap()))
        .then((value) {
      isAddingError = false;
      isCourseAdded = true;
    }).catchError((error) {
      isCourseAdded = false;
      isAddingError = true;
    });
  }

  Future<void> deleteCourse({required String docId}) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('course')
        .doc(docId)
        .delete()
        .then((value) {
      isCourseRemoved = true;
    }).catchError((error) {
      isRemovingError = true;
    });
  }

  Future<void> updateCourse(
      {required String? userId,
      required String? docId,
      required Map<String, Object?> data}) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('course')
        .doc(docId)
        .update(data)
        .then((value) => print('Recorde updated'));
  }
}
