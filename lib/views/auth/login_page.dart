// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartnote/models/user.dart';
import 'package:smartnote/backend/auth_services.dart';
import 'package:smartnote/theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _emailSignInLoading = false;
  bool _googleSignInLoading = false;

  AuthService authService = AuthService();
  void signIn() async {
    // if there is signed in user, sign out
    if (authService.currentUser != null) {
      await authService.signOut();
    }

    setState(() {
      _emailSignInLoading = true; // start loading
    });

    await authService
        .signInWithEmailAndPassword(
            _emailController.text.trim(), _passwordController.text.trim())
        .then((value) {
      setState(() {
        _emailSignInLoading = false; // stop loading after sign-in
      });
      if (value != null) {
        print("User is not null--------- ${value}");
        Navigator.pushNamed(context, '/main');
      } else {
        print("User is null--------- ${value}");
      }
      return value;
      // Navigator.pushNamed(context, '/main');
    });
  }

  void signInWithGoogle() async {
    setState(() {
      _googleSignInLoading = true; // start loading
    });
    UserModel? user = await authService.signInWithGoogle().then((value) {
      setState(() {
        _googleSignInLoading = false; // stop loading after sign-in
      });
      if (value != null) {
        print("User is not null--------- ${value}");
        Navigator.pushNamed(context, '/main');
      } else {
        print("User is null--------- ${value}");
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        //   elevation: 0,
        // ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
              child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // add logo
                Image.asset(
                  'assets/logo_white_bg_blue.png',
                  // replace with the actual logo path
                  height: 80,
                  width: 80,
                ),
                SizedBox(
                  height: 50,
                ),
                // Hello gain!
                Text("Sign in to access your notes anywhere",
                    style: themeFontFamily.copyWith(
                        color: Colors.grey[800],
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),

                SizedBox(
                  height: 30,
                ),
                // email textfield
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12.0)),
                      child: Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                              hintText: "Email", border: InputBorder.none),
                        ),
                      ),
                    )),

                SizedBox(height: 10.0),

                // password tetfield

                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12.0)),
                      child: Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: "Password", border: InputBorder.none),
                        ),
                      ),
                    )),

                // signin button

                SizedBox(
                  height: 20,
                ),

                GestureDetector(
                  onTap: _emailSignInLoading ? null : () => signIn(),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: themeColor,
                            borderRadius: BorderRadius.circular(12.0)),
                        child: Center(
                            child: _emailSignInLoading
                                ? CircularProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation(Colors.white))
                                : Text(
                                    "Sign In",
                                    style: themeFontFamily.copyWith(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )),
                      )),
                ),

                SizedBox(
                  height: 30,
                ),

                Text(
                  "or Sign In with",
                  style: themeFontFamily.copyWith(
                      color: Colors.grey[500], fontSize: 15),
                ),

                SizedBox(
                  height: 20,
                ),

                // add a google sign in button
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          // add boarder
                          border: Border.all(
                            color: const Color.fromARGB(255, 196, 196,
                                196), // Choose the color for the border
                            width: 1.0, // Choose the width for the border
                          ),
                          color: whiteBgColor,
                          borderRadius: BorderRadius.circular(12.0)),
                      // a
                      child: GestureDetector(
                        onTap: () {
                          signInWithGoogle();
                        },
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Image.asset(
                                  "assets/google_icon.png",
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                              _googleSignInLoading
                                  ? CircularProgressIndicator(
                                      valueColor:
                                          AlwaysStoppedAnimation(themeColor))
                                  : Text(
                                      "Continue with Google",
                                      style: themeFontFamily.copyWith(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                              SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),

                // not a member? register now

                SizedBox(
                  height: 30,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?  ",
                      style: themeFontFamily.copyWith(
                          color: Colors.grey[500], fontSize: 15),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigate to the Sign Up screen
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: Text(
                        "Sign Up",
                        style: themeFontFamily.copyWith(
                            color: themeColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
        ));
  }
}
