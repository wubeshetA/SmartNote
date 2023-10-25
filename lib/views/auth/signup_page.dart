import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartnote/models/user.dart';
import 'package:smartnote/services/auth_services.dart';
import 'package:smartnote/theme.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  AuthService authService = AuthService();
  bool _loading = false;

  void signUp() async {
    setState(() {
      _loading = true;
    });

    UserModel? user = await authService.signUp(
      _nameController.text.trim(),
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    setState(() {
      _loading = false;
    });

    if (user != null) {
      Navigator.pushNamed(context, '/login');
    } else {
      // Handle error, show some feedback to the user
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
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
                Text("Sign Up to access your notes anywhere",
                    style: themeFontFamily.copyWith(
                        color: Colors.grey[800],
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),

                SizedBox(
                  height: 30,
                ),

                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12.0)),
                      child: Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                              hintText: "Name", border: InputBorder.none),
                        ),
                      ),
                    )),

                SizedBox(height: 10.0),
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
                  onTap: _loading ? null : () => signUp(),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: themeColor,
                            borderRadius: BorderRadius.circular(12.0)),
                        child: Center(
                          child: _loading
                              ? CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.white))
                              : Text(
                                  "Sign Up",
                                  style: themeFontFamily.copyWith(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                        ),
                      )),
                ),

                SizedBox(
                  height: 30,
                ),

                Text(
                  "or Sign Up with",
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
                      child: Center(
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Image.asset(
                                "assets/google_icon.png",
                                height: 30,
                                width: 30,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Continue with Google",
                              style: themeFontFamily.copyWith(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ],
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
                      "Have an account?  ",
                      style: themeFontFamily.copyWith(
                          color: Colors.grey[500], fontSize: 15),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Text(
                        "Sign In",
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
