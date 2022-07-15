import 'package:cas_finance_management/presentation/authentication_pages/authentication_page.dart';
import 'package:cas_finance_management/presentation/screens/course/course_edit_page.dart';
import 'package:cas_finance_management/presentation/screens/course/course_page.dart';
import 'package:cas_finance_management/presentation/screens/enrolled_groups/enrolled_groups_page.dart';
import 'package:cas_finance_management/presentation/screens/home_page.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColorSchema {
  static const Color grey = Color(0xff635570);
  static const Color blue = Color(0xff1795C2);
  static const Color inputFieldFillColor = Color(0xfff3f3f4);
  static const List<Color> gradientColor = <Color>[
    Color(0xff635570),
    Color(0xff1795C2)
  ];
}

class Responsive {
  final Size? size;
  final double? height;
  final double? width;
  final double? aspectRatio;

  Responsive({
    this.size,
    this.height,
    this.width,
    this.aspectRatio,
  });
}

Map<String, WidgetBuilder> appRoutes = <String, WidgetBuilder>{
  AuthenticationPage.routeName: (context) => const AuthenticationPage(),
  CoursePage.routeName: (context) => const CoursePage(),
  CourseEditPage.routeName: (context) => const CourseEditPage(),
  EnrolledGroupsPage.routeName: (context) => const EnrolledGroupsPage(),
  HomePage.routeName: (context) => const HomePage(),
};
