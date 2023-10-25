import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartnote/models/user.dart';
import 'package:smartnote/services/auth_services.dart';

class UserProfilePage extends StatefulWidget {
  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  AuthService authService = AuthService();
  // get user

  @override
  Widget build(BuildContext context) {
  UserModel? user = Provider.of<UserModel?>(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Welcome message on the top right corner
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Hi, ${user!.displayName}", // replace with the actual user's name
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue, // change color based on your theme
                ),
              ),
            ),
          ),
          
          // Other profile details can be added here
          // ...

          // Sign out button at the bottom
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () async {
                try {
                  await authService.signOut();
                  Navigator.pop(context);
                } catch (e) {
                  print(e);
                }
              },
              child: Text('Sign Out'),
              style: ElevatedButton.styleFrom(
                primary: Colors.red, // making it red to highlight action
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
