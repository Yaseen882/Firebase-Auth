import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class EnrolledGroup {
  FieldValue? groupEnrollmentDate;
  String? groupTitle;
  DateTime? lectureTime;
  String? groupCourse;
  String? groupInstructor;
  double? groupCourseFee;
  String? groupCR;
  bool? isCourseCompleted;
  EnrolledGroup({
    this.groupEnrollmentDate,
    this.groupTitle,
    this.lectureTime,
    this.groupCourse,
    this.groupInstructor,
    this.groupCourseFee,
    this.groupCR,
    this.isCourseCompleted,
  });

  EnrolledGroup copyWith({
    FieldValue? groupEnrollmentDate,
    String? groupTitle,
    DateTime? lectureTime,
    String? groupCourse,
    String? groupInstructor,
    double? groupCourseFee,
    String? groupCR,
    bool? isCourseCompleted,
  }) {
    return EnrolledGroup(
      groupEnrollmentDate: groupEnrollmentDate ?? this.groupEnrollmentDate,
      groupTitle: groupTitle ?? this.groupTitle,
      lectureTime: lectureTime ?? this.lectureTime,
      groupCourse: groupCourse ?? this.groupCourse,
      groupInstructor: groupInstructor ?? this.groupInstructor,
      groupCourseFee: groupCourseFee ?? this.groupCourseFee,
      groupCR: groupCR ?? this.groupCR,
      isCourseCompleted: isCourseCompleted ?? this.isCourseCompleted,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'groupEnrollmentDate': groupEnrollmentDate,
      'groupTitle': groupTitle,
      'lectureTime': lectureTime?.millisecondsSinceEpoch,
      'groupCourse': groupCourse,
      'groupInstructor': groupInstructor,
      'groupCourseFee': groupCourseFee,
      'groupCR': groupCR,
      'isCourseCompleted': isCourseCompleted,
    };
  }

  factory EnrolledGroup.fromMap(Map<String, dynamic> map) {
    return EnrolledGroup(
      groupEnrollmentDate: map['groupEnrollmentDate'] as FieldValue,
      groupTitle: map['groupTitle'] as String,
      lectureTime: map['lectureTime'] as DateTime,
      groupCourse: map['groupCourse'] as String,
      groupInstructor: map['groupInstructor'] as String,
      groupCourseFee: map['groupCourseFee'] as double,
      groupCR: map['groupCR'] as String,
      isCourseCompleted: map['isCourseCompleted'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory EnrolledGroup.fromJson(String source) =>
      EnrolledGroup.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EnrolledGroup(groupEnrollmentDate: $groupEnrollmentDate, groupTitle: $groupTitle, lectureTime: $lectureTime, groupCourse: $groupCourse, groupInstructor: $groupInstructor, groupCourseFee: $groupCourseFee, groupCR: $groupCR, isCourseCompleted: $isCourseCompleted)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EnrolledGroup &&
        other.groupEnrollmentDate == groupEnrollmentDate &&
        other.groupTitle == groupTitle &&
        other.lectureTime == lectureTime &&
        other.groupCourse == groupCourse &&
        other.groupInstructor == groupInstructor &&
        other.groupCourseFee == groupCourseFee &&
        other.groupCR == groupCR &&
        other.isCourseCompleted == isCourseCompleted;
  }

  @override
  int get hashCode {
    return groupEnrollmentDate.hashCode ^
        groupTitle.hashCode ^
        lectureTime.hashCode ^
        groupCourse.hashCode ^
        groupInstructor.hashCode ^
        groupCourseFee.hashCode ^
        groupCR.hashCode ^
        isCourseCompleted.hashCode;
  }
}
