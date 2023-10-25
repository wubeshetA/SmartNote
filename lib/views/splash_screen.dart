import 'package:flutter/material.dart';
import 'package:smartnote/theme.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo_white_bg_blue.png',
               // replace with the actual logo path
              height: 150,
              width: 150,
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Text(
                'Your AI-powered note-taking companion!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  color: themeColor,
                ),
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Navigate to the Sign In screen
                Navigator.pushNamed(context, '/login');
              },
              child: Text(
                'Sign In',
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: themeColor,
                foregroundColor: Colors.white,
                minimumSize: Size(200, 40),
              ),
            ),
            SizedBox(height: 15),
           ElevatedButton(
              onPressed: () {
                // Navigate to the Sign In screen
                Navigator.pushNamed(context, '/main');
              },
              child: Text(
                'Continue',
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: themeColor,
                foregroundColor: Colors.white,
                minimumSize: Size(200, 40),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
