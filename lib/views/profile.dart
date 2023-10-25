import 'package:flutter/material.dart';
import 'package:smartnote/services/auth_services.dart';

class UserProfilePage extends StatefulWidget {
  // const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          // asign out button
          ElevatedButton(
            onPressed: () async {
              // Navigate to the SplashScreen
              // remove the current navigated screen
              try {
                await authService.signOut();
                Navigator.pop(context);
              } catch (e) {
                print(e);
              }
            },
            child: Text('Sign Out'),
          ),
        ],
      ),
    ));
  }
}
