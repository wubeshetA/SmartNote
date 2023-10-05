import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Color.fromRGBO(139,0,247, 1)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: GNav(
            backgroundColor: Colors.transparent,
            activeColor: Colors.white,
            color: Colors.white,
            // add gradient color for the tab background
            tabBackgroundGradient: LinearGradient(
              colors: [Color.fromRGBO(139,0,247, 1,), Colors.blue, ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            gap: 8,
            padding: EdgeInsets.all(16),
            tabs: [
              GButton(
                icon: Icons.mic,
                text: 'Record',
              ),
              GButton(
                icon: Icons.file_upload,
                text: 'Upload File',
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
          ),
        ),
      ),
    );
  }
}
