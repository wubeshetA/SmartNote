// import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
// import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smartnote/views/note/notes_list.dart';
import 'package:smartnote/models/noteAndQuestion.dart';
import 'package:smartnote/backend/storage/cloud/cloud_database.dart';
// import 'package:smartnote/backend/storage/local/sqlite_db_helper.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/annotations.dart';
import 'package:path_provider/path_provider.dart';

import './notes_list_test.mocks.dart';

import 'package:flutter/material.dart';

import '../auth/mock.dart';

@GenerateMocks([SupabaseDatabaseHelper])
@GenerateMocks([FirebaseAuth])
@GenerateMocks([User])
// class MockFirebaseAuth extends Mock implements FirebaseAuth {
//   MockUser? _currentUser;

//   @override
//   MockUser? get currentUser => _currentUser;

//   // Set the mock user if needed
//   void setCurrentUser(MockUser user) {
//     _currentUser = user;
//   }

//   // Add other mocks as needed
// }

void main() {
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });

  late MockSupabaseDatabaseHelper mockSupabaseDbHelper;
  late List<DataNote> mockData;
  late MockFirebaseAuth mockFirebaseAuth;
  late MockUser mockUser;

  setUp(() {
    mockSupabaseDbHelper = MockSupabaseDatabaseHelper();
    mockData = [
      DataNote(
        id: '1',
        title: "Test Note",
        notes: "",
        questions: "",
        created_at: DateTime.now(),
      ),
    ];
  });

  testWidgets('Notes widget renders correctly', (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: Notes()));

    // Verify that the appbar title is rendered.
    expect(find.text('Your Notes'), findsOneWidget);

    // check if the CircularProgressIndicator is displayed initially.
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

//   test('fetches data from Supabase when user is logged in', () async {
//     // Mock user
//     final mockUser = MockUser();
//     // when(mockUser.uid).thenReturn('user_uid');

//     // Mock Supabase response
//     final List<Map<String, dynamic>> mockRawList = [
//       {'id': 1, 'title': 'Test Note', 'created_at': DateTime.now()},
//     ];
//     when(mockSupabaseDbHelper.getPaths()).thenAnswer((_) async => mockData);
//     // Call fetchData
//     final notes = await Notes().fetchData(mockUser);

//     // Verify results
//     expect(notes.length, 1);
//     expect(notes[0].title, 'Test Note');
//     expect(notes[0].created_at, DateTime.now());

//     // Verify Supabase calls
//     verify(mockSupabaseDbHelper.getPaths()).called(1);
//   });

//   testWidgets('Notes widget with data renders correctly',
//       (WidgetTester tester) async {
//     // Mock data for testing
//     final mockData = [
//       DataNote(
//         id: '1', // Provide a unique id for each entry
//         title: 'Note 1',
//         created_at: DateTime.now(),
//         notes: 'Note content',
//         questions: 'Question content',
//       ),
//       DataNote(
//         id: '2', // Provide a unique id for each entry
//         title: 'Note 2',
//         created_at: DateTime.now(),
//         notes: 'Note content',
//         questions: 'Question content',
//       ),
//     ]; // Mock the fetchData method

//     await tester.runAsync(() async {
//       await tester.pumpWidget(MaterialApp(home: Notes()));
//       await tester.pump();
//     });

//     when(mockSupabaseDbHelper.getPaths()).thenAnswer((_) async => mockData);
//     // Call fetchData
//     final notes = await Notes().fetchData;
//     // Verify that the notes are rendered.
//     expect(find.text('Note 1'), findsOneWidget);
//     expect(find.text('Note 2'), findsOneWidget);

//     // Verify that the CircularProgressIndicator is not displayed.
//     expect(find.byType(CircularProgressIndicator), findsNothing);
//   });
}
