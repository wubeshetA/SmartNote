// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:smartnote/theme.dart';
import 'package:smartnote/views/question/questions_list.dart';


import '../audio/recorder_screen.dart';
import '../note/notes_list.dart';
import '../audio/upload.dart';

class BottomNavBarNavigator extends StatefulWidget {
  const BottomNavBarNavigator({Key? key}) : super(key: key);
  @override
  _BottomNavBarNavigatorState createState() => _BottomNavBarNavigatorState();
}

class _BottomNavBarNavigatorState extends State<BottomNavBarNavigator> {
  final PageController _pageController = PageController(initialPage: 0);
  int _selectedIndex = 0;
  static const List _widgetOptions = [
    Recorder(),
    Upload(),
    Notes(),
    Questions(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        color: themeColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: GNav(
            backgroundColor: Colors.transparent,
            activeColor: Colors.white,
            color: Colors.white,
            // add gradient color for the tab background
            tabBackgroundColor: lighterBgColor,
            gap: 8,
            padding: EdgeInsets.all(10),
            tabs: [
              GButton(
                icon: Icons.mic,
                text: 'Record',
                textStyle: themeFontFamily.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              GButton(
                icon: Icons.file_upload,
                text: 'Upload',
                textStyle: themeFontFamily.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              GButton(
                icon: Icons.note,
                text: 'Notes',
                textStyle: themeFontFamily.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              GButton(
                icon: Icons.question_answer,
                text: 'Questions',
                textStyle: themeFontFamily.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              print(index);
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
