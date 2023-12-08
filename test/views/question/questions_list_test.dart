// import 'package:smartnote/views/question/questions_list.dart';
// import 'package:smartnote/models/noteAndQuestion.dart';
// import 'package:smartnote/backend/storage/cloud/cloud_database.dart';
// import 'package:mockito/mockito.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:mockito/annotations.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter/material.dart';
// import 'package:smartnote/theme.dart';
// import 'package:smartnote/views/note/note_view.dart';

// import '../auth/mock.dart';

// void main() {
//   setupFirebaseAuthMocks();

//   setUpAll(() async {
//     await Firebase.initializeApp();
//   });

//   testWidgets('QuestionsList shows loading indicator before data loaded',
//       (WidgetTester tester) async {
//     // Build the widget
//     await tester.pumpWidget(MaterialApp(home: Questions()));

//     // Verify loading indicator is displayed
//     expect(find.byType(CircularProgressIndicator), findsOneWidget);
//   });

//   testWidgets('build() displays data correctly', (WidgetTester tester) async {
//     // ... mock data

//     // Build the widget using tester.pumpWidget
//     await tester.pumpWidget(widget);

//     // Find the title card using tester.findCardWithTitle
//     final titleCard = tester.findCardWithTitle('Test Note');

//     // Verify the title card exists using expect
//     expect(titleCard, findsOneWidget);

//     // Find the date text using tester.findText
//     final dateText = tester.findText('2023-10-26 17:08:32');

//     // Verify the date text exists and has correct format using expect
//     expect(dateText, findsOneWidget);
//     expect(tester.widget<Text>(dateText).style.color, Colors.grey[600]);

//     // Find the note icon using tester.findIcon
//     final noteIcon = tester.findIcon(Icons.note);

//     // Verify the note icon exists using expect
//     expect(noteIcon, findsOneWidget);
//     expect(tester.widget<Icon>(noteIcon).color, themeColor);

//     // Tap the note card using tester.tap
//     await tester.tap(titleCard);

//     // Verify navigates to NoteView using expect
//     expect(find.byType(NoteView), findsOneWidget);
//   });
// }
