import 'package:cas_finance_management/presentation/screens/course/course_page.dart';
import 'package:cas_finance_management/presentation/screens/enrolled_groups/enrolled_groups_page.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/';
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final _widgetOption = <Widget>[
    const Text('HomePage'),
    const CoursePage(),
    ChangeNotifierProvider(
        create: (context) => LoadCourseList(),
        child: const EnrolledGroupsPage())
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOption.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          iconSize: 25,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.content_paste_outlined), label: 'Courses'),
            BottomNavigationBarItem(icon: Icon(Icons.groups), label: 'Groups')
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped),
    );
  }
}
