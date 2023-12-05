import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:smartnote/models/user.dart';
import 'package:smartnote/views/auth/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smartnote/backend/auth_services.dart';
import 'package:smartnote/firebase_options.dart';
import 'package:smartnote/views/widgets/bottom_navigator.dart';
import 'package:firebase_core/firebase_core.dart';
import './mock.dart';
import 'package:mockito/mockito.dart';

// Define a simple MockAuthService for testing purposes

void main() {
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });

  group('LoginPage Tests', () {
    testWidgets('Widgets are rendered', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: LoginPage(),
      ));
      expect(find.byType(Image), findsNWidgets(2));
      expect(
          find.text("Sign in to access your notes anywhere"), findsOneWidget);
      expect(find.byType(TextField), findsNWidgets(2));
      expect(find.text("Sign In"), findsOneWidget);
      expect(find.text("or Sign In with"), findsOneWidget);
      expect(find.text("Continue with Google"), findsOneWidget);
      expect(find.text("Don't have an account?  "), findsOneWidget);
      expect(find.text("Sign Up"), findsOneWidget);
    });

    testWidgets('Sign In button triggers sign in process',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginPage(), routes: {
        '/main': (context) => BottomNavBarNavigator(), // Add this line
      }));

      await tester.enterText(find.byType(TextField).at(0), 'test@example.com');
      await tester.enterText(find.byType(TextField).at(1), 'password');

      await tester.tap(find.text("Sign In"));
      await tester.pump();

      expect(find.text('Sign In'), findsNothing);

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });

  testWidgets('Email and password fields are empty by default',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: LoginPage(),
    ));

    // Find the text fields by their hintText
    final emailTextField = find.widgetWithText(TextField, 'Email');
    final passwordTextField = find.widgetWithText(TextField, 'Password');

    // Verify that the email and password fields are empty by default
    expect(
        (emailTextField.evaluate().first.widget as TextField).controller!.text,
        '');
    expect(
        (passwordTextField.evaluate().first.widget as TextField)
            .controller!
            .text,
        '');
  });
}
