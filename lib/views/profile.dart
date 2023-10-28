import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartnote/models/user.dart';
import 'package:smartnote/services/auth_services.dart';
import 'package:smartnote/theme.dart';
import 'package:smartnote/views/widgets/appbar.dart';

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
      appBar: SmartNoteAppBar(appBarTitle: "Your Profile"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top:80),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    
                    backgroundColor: themeColor,
                    child: Text(
                      user!.displayName!.substring(0, 1).toUpperCase(),
                      // ignore: prefer_const_constructors
                      style: themeFontFamily.copyWith(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    user.displayName!,
                    style:themeFontFamily.copyWith(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,)
                  ),
                  SizedBox(height: 5),
                  Text(
                    user.email!,
                    style: themeFontFamily.copyWith(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                  // Add horizontal line separator
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 20.0),
                    child: Container(
                      height: 1.0,
                      width: double.infinity,
                      color: Colors.grey[300],
                    ),
                  ),
                ],
              ),
            ),
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
      ),
    );
  }
}
