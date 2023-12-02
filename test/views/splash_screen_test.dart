import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smartnote/views/widgets/bottom_navigator.dart';
import 'package:smartnote/views/splash_screen.dart';
import 'package:smartnote/views/auth/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import './mock.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });

  testWidgets('SplashScreen widgets are rendered', (WidgetTester tester) async {
    // Builds app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: SplashScreen(),
    ));

    // Verify that the logo is rendered
    expect(find.byType(Image), findsOneWidget);

    // Verify that the slogan text is rendered
    expect(find.text('Your AI-powered Note-taking and Study Companion!'),
        findsOneWidget);

    // Verify that the "Sign In" button is rendered
    expect(find.widgetWithText(ElevatedButton, 'Sign In'), findsOneWidget);

    // Verify that the "Continue As Guest" button is rendered
    expect(find.widgetWithText(ElevatedButton, 'Continue As Guest'),
        findsOneWidget);
  });

  testWidgets('Tapping "Sign In" navigates to login screen',
      (WidgetTester tester) async {
    // Build app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: SplashScreen(),
      routes: {
        '/login': (context) => LoginPage(), // Add this line
        // Add other routes used in your app
      },
    ));

    // Tap on the "Sign In" button
    await tester.tap(find.widgetWithText(ElevatedButton, 'Sign In'));

    // Wait for navigation
    await tester.pumpAndSettle();

    // Verify that navigation occurred
    expect(find.byType(LoginPage), findsOneWidget);
  });

  testWidgets('Tapping "Continue As Guest" navigates to main screen',
      (WidgetTester tester) async {
    // Build app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: SplashScreen(), routes: {
      '/main': (context) => BottomNavBarNavigator(), // Add this line
    }));

    // Tap on the "Continue As Guest" button
    await tester.tap(find.widgetWithText(ElevatedButton, 'Continue As Guest'));

    // Wait for navigation
    await tester.pumpAndSettle();

    // Verify that navigation occurred
    expect(find.text('Continue As Guest'), findsNothing);
    expect(find.text('Record'), findsOneWidget);
  });
}
