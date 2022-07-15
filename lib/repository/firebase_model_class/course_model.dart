import 'package:cloud_firestore/cloud_firestore.dart';

class Course {
  FieldValue? courseServerStamp;
  String? courseTitle;
  String? courseTeacher;
  double? courseFee;

//<editor-fold desc="Data Methods">

  Course({
    this.courseServerStamp,
    this.courseTitle,
    this.courseTeacher,
    this.courseFee,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Course &&
          runtimeType == other.runtimeType &&
          courseServerStamp == other.courseServerStamp &&
          courseTitle == other.courseTitle &&
          courseTeacher == other.courseTeacher &&
          courseFee == other.courseFee);

  @override
  int get hashCode =>
      courseServerStamp.hashCode ^
      courseTitle.hashCode ^
      courseTeacher.hashCode ^
      courseFee.hashCode;

  @override
  String toString() {
    return 'Course{'
        ' courseServerStamp: $courseServerStamp,'
        ' courseTitle: $courseTitle,'
        ' courseTeacher: $courseTeacher,'
        ' courseFee: $courseFee,'
        '}';
  }

  Map<String, dynamic> toMap() {
    return {
      'courseServerStamp': courseServerStamp,
      'courseTitle': courseTitle,
      'courseTeacher': courseTeacher,
      'courseFee': courseFee,
    };
  }

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      courseTitle: map['courseTitle'] as String,
      courseTeacher: map['courseTeacher'] as String,
      courseFee: map['courseFee'] as double,
    );
  }

//</editor-fold>
}
