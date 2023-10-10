// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:smartnote/views/screens/question/questionsList.dart';

// Local imports
import 'note/note.dart';
import 'recorder/recorderScreen.dart';
import 'note/notes.dart';
import 'question/question.dart';
import 'upload.dart';

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
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: GNav(
            backgroundColor: Colors.transparent,
            activeColor: Colors.white,
            color: Colors.white,
            // add gradient color for the tab background
            tabBackgroundColor: Colors.grey.shade800,
            gap: 8,
            padding: EdgeInsets.all(16),
            tabs: [
              GButton(
                icon: Icons.mic,
                text: 'Record',
              ),
              GButton(
                icon: Icons.file_upload,
                text: 'Upload',
              ),
              GButton(
                icon: Icons.note,
                text: 'Notes',
              ),
              GButton(
                icon: Icons.question_answer,
                text: 'Questions',
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
