import 'package:flutter_test/flutter_test.dart';
import './mock.dart';
import 'package:flutter/material.dart';
import 'package:smartnote/views/auth/signup_page.dart';
import 'package:smartnote/views/auth/login_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(() {
    Firebase.initializeApp();
  });

  group('SignupPage Tests', () {
    testWidgets('Signup page should display sign up form',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: SignupPage(),
      ));
      expect(find.byType(Image), findsNWidgets(2));

      expect(
          find.text('Sign Up to access your notes anywhere'), findsOneWidget);
      expect(find.byType(TextField), findsNWidgets(3));

      expect(find.text('Name'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Sign Up'), findsOneWidget);
      expect(find.text('or Sign Up with'), findsOneWidget);
      expect(find.text("Continue with Google"), findsOneWidget);
      expect(find.text("Have an account?  "), findsOneWidget);
      expect(find.text("Sign In"), findsOneWidget);
    });

    testWidgets('Navigates to login page on successful signup',
        (WidgetTester tester) async {
      // Provide the mock to the widget under test
      await tester.pumpWidget(MaterialApp(home: SignupPage(), routes: {
        '/login': (context) => LoginPage(),
      }));

      // Populate form fields and submit form
      await tester.enterText(find.byType(TextField).at(0), 'TestName');
      await tester.enterText(find.byType(TextField).at(1), 'test@example.com');
      await tester.enterText(find.byType(TextField).at(2), 'password');
      await tester.tap(find.text('Sign Up'));
      await tester.pump(); // Wait for navigation to finish

      // Verify that the login page is pushed to the Navigator
      expect(find.text('Sign In'), findsOneWidget);
    });

    // Test for unsuccessful signup case
  });
}
