import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:smartnote/theme.dart';
import 'package:smartnote/views/note/webview_interface.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:smartnote/views/note/note_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:io';
import 'dart:convert';
import 'package:smartnote/backend/storage/local/sqlite_db_helper.dart';

import '../auth/mock.dart';

class MockNavigatorState extends Mock implements NavigatorState {
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    return super.toString();
  }
}

class MockFile extends Mock implements File {
  @override
  Future<String> readAsString({Encoding encoding = utf8}) {
    return super.noSuchMethod(
      Invocation.method(#readAsString, [], {#encoding: encoding}),
      returnValue: Future.value(''),
      returnValueForMissingStub: Future.value(''),
    );
  }
}

class MockWebViewController extends Mock implements WebViewController {}

class MockWebView extends Mock implements WebViewInterface {
  @override
  Future<void> loadHtmlString(String? htmlContent) {
    return super.noSuchMethod(
      Invocation.method(#loadHtmlString, [htmlContent]),
      returnValue: Future.value(),
      returnValueForMissingStub: Future.value(),
    );
  }
}

class MockSqliteDatabaseHelper extends Mock implements SqliteDatabaseHelper {
  @override
  Future<List<Map<String, dynamic>>> getPaths() {
    return super.noSuchMethod(
      Invocation.method(#getPaths, []),
      returnValue: Future.value([]),
      returnValueForMissingStub: Future.value([]),
    );
  }
}

void main() {
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });
  setUp(() {
    // Mock dependencies
    MockNavigatorState mockNavigatorState = MockNavigatorState();
    MockFile mockFile = MockFile();
    MockWebViewController mockController = MockWebViewController();
    MockSqliteDatabaseHelper mockDatabaseHelper = MockSqliteDatabaseHelper();

    // Set up stubs
    when(mockFile.readAsString())
        .thenAnswer((_) => Future.value(File('test.html').readAsStringSync()));
  });
  test('NoteView widget builds correctly', () {
    Key keyForWidget<T extends Widget>(T widget) {
      return ValueKey(widget.hashCode);
    }

    // Arrange
    const String htmlFilePath = './test.html';
    const String topicTitle = 'Test Note';

    // Act
    final widget = NoteView(
      key: ValueKey('NoteView'),
      htmlFilePath: './test.html',
      topicTitle: 'Test Note',
    );

// Assert
    expect(widget.key, equals(ValueKey('NoteView')));
    expect(widget.htmlFilePath, htmlFilePath);
    expect(widget.topicTitle, topicTitle);
  });
}



//   testWidgets('NoteView widget fetches data from SQlite database',
//       (WidgetTester tester) async {
//     final mockDatabaseHelper = MockSqliteDatabaseHelper();

//     // Arrange
//     const String htmlFilePath = 'test/test.html';
//     const String topicTitle = 'Test Note';

//     // Act
//     await tester.pumpWidget(MaterialApp(
//       home: NoteView(
//         htmlFilePath: './test.html',
//         topicTitle: 'Sample Topic',
//       ),
//     ));
//     // Wait for the widget to build.
//     await tester.pumpAndSettle();
//     // Assert
//     verify(mockDatabaseHelper.getPaths()).called(1);
//   });
// }


//   // testWidgets('NoteView displays login icon in app bar',
//   //     (WidgetTester tester) async {
//   //   // Build our app and trigger a frame.
//   //   await tester.pumpWidget(NoteView(
//   //     htmlFilePath: './test.html',
//   //     topicTitle: 'Sample Topic',
//   //   ));

//   //   // Verify that the login icon is displayed in the app bar.
//   //   expect(find.byIcon(Icons.login), findsOneWidget);
//   // });

//   // Add more tests as needed based on your specific requirements.
// }

//   // testWidgets('NoteView widget test', (WidgetTester tester) async {
//   //   // Build our app and trigger a frame.
//   //   await tester.pumpWidget(MaterialApp(
//   //     home: NoteView(htmlFilePath: 'test.html', topicTitle: 'Test Topic'),
//   //   ));

//   //   // Verify that the AppBar title is displayed.
//   //   expect(find.text('Test Topic'), findsOneWidget);

//   //   // Verify that the WebViewWidget is displayed.
//   //   expect(find.byType(WebView), findsOneWidget);
//   // });

