import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartnote/models/user.dart';
import 'package:smartnote/theme.dart';

class SmartNoteAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String appBarTitle;

  const SmartNoteAppBar({required this.appBarTitle, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // get the user from context
    final user = Provider.of<UserModel?>(context);
    return AppBar(
      // title: Text('Recorder'),
      title: Text(appBarTitle),
      centerTitle: true,
      backgroundColor: themeColor,
      elevation: 0.0,
      // add a sign in button on the right side
      actions: [
        IconButton(
          onPressed: () {
            // Navigate to the SplashScreen
            // remove the current navigated screen
            try {
              // await authService.signOut();
              // Navigator.pop(context);
              if (user == null) {
                Navigator.pushNamed(context, '/login');
                // return;
              } else {
                Navigator.pushNamed(context, '/profile');
              }
            } catch (e) {
              print(e);
            }
          },
          icon: user != null
              ?
              // add avatar that displays the first letter of the user's name
              CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    user.displayName!.substring(0, 1).toUpperCase(),
                    style: TextStyle(
                      color: themeColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : Icon(Icons.login),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
