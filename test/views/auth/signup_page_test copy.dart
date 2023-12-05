import 'package:flutter_test/flutter_test.dart';
import './mock.dart';
import 'package:flutter/material.dart';
import 'package:smartnote/models/user.dart';
import 'package:smartnote/views/auth/signup_page.dart';
import 'package:smartnote/views/auth/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smartnote/backend/auth_services.dart';
import 'package:smartnote/firebase_options.dart';
import 'package:smartnote/views/widgets/bottom_navigator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mockito/mockito.dart';

class MockAuthService extends Mock implements AuthService {}

void main() {
  setupFirebaseAuthMocks();

  setUpAll(() {
    Firebase.initializeApp();
  });

  final mockAuthService = MockAuthService();

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
      // Arrange: Return a valid user object when signUp is called
      // when(mockAuthService.signUp(any, any, any))
      //     .thenAnswer((_) async => UserModel());

      // Provide the mock to the widget under test
      await tester.pumpWidget(MaterialApp(
        home: SignupPage(),
        // provide the mock to the widget
      ));

      // Act: Populate form fields and submit form
      await tester.enterText(find.byType(TextField).at(0), 'TestName');
      await tester.enterText(find.byType(TextField).at(1), 'test@example.com');
      await tester.enterText(find.byType(TextField).at(2), 'password');
      await tester.tap(find.text('Sign Up'));
      await tester.pumpAndSettle(); // Wait for navigation to finish

      // Assert: Verify that the login page is pushed to the Navigator
      expect(find.byType(LoginPage), findsOneWidget);
    });

    // Test for unsuccessful signup case
    testWidgets('Shows error message on unsuccessful signup',
        (WidgetTester tester) async {
      // // Arrange: Return null when signUp is called to simulate failure
      // when(mockAuthService.signUp(any, any, any)).thenAnswer((_) async => null);

      // Provide the mock to the widget under test
      await tester.pumpWidget(MaterialApp(
        home: SignupPage(),
        // provide the mock to the widget
      ));

      // Act: Populate form fields and submit form
      await tester.enterText(find.byType(TextField).at(0), 'TestName');
      await tester.enterText(find.byType(TextField).at(1), 'test@example.com');
      await tester.enterText(find.byType(TextField).at(2), 'password');
      await tester.tap(find.text('Sign Up'));
      await tester.pump(); // Trigger a frame

      // Assert: Verify that the error message is displayed
      // (Assuming there's a widget for showing error messages)
      expect(find.text('Error message or widget goes here'), findsOneWidget);
    });
    // testWidgets(
    //     'Signup page should navigate to login page on successful signup',
    //     (WidgetTester tester) async {
    //   await tester.pumpWidget(MaterialApp(
    //     home: SignupPage(),
    //   ));
    //   final mockAuthService = MockAuthService();
    //   final mockNavigator = MockNavigator();
    //   final widget = SignupPage(authService: mockAuthService);

    //   when(mockAuthService.signUp(
    //           'Test User', 'test@example.com', 'testpassword'))
    //       .thenReturn(Future.value(UserModel(
    //           id: 'user_id', name: 'Test User', email: 'test@example.com')));

    //   when(mockNavigator.pushNamed(any(), any())).thenAnswer((_) async => true);

    //   widget.signUp();

    //   verify(mockNavigator.pushNamed('/login'));
    // });

    // test('Signup page should show error message on unsuccessful signup', () {
    //   final mockAuthService = MockAuthService();
    //   final widget = SignupPage(authService: mockAuthService);

    //   when(mockAuthService.signUp(
    //           'Test User', 'test@example.com', 'testpassword'))
    //       .thenReturn(Future.value(null));

    //   // TODO: Implement test for error message
    // });
  });
}
