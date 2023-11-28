import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:smartnote/views/widgets/bottom_navigator.dart';

void main() {
  testWidgets('BottomNavBarNavigator renders correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BottomNavBarNavigator(),
      ),
    );

    // Add a delay to allow the initial page to render
    await tester.pumpAndSettle();

    // Verify that the initial page is Recorder
    expect(find.text('Record'), findsOneWidget);

    // Tap on the Upload tab
    await tester.tap(find.text('Upload'));
    await tester.pumpAndSettle();

    // Verify that the page changes to Upload
    expect(find.text('Upload'), findsOneWidget);

    // Tap on the Notes tab
    await tester.tap(find.text('Notes'));
    await tester.pumpAndSettle();

    // Verify that the page changes to Notes
    expect(find.text('Notes'), findsOneWidget);

    // Tap on the Questions tab
    await tester.tap(find.text('Questions'));
    await tester.pumpAndSettle();

    // Verify that the page changes to Questions
    expect(find.text('Questions'), findsOneWidget);
  });

  testWidgets('BottomNavBarNavigator changes pages on tap',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BottomNavBarNavigator(),
      ),
    );

    // Verify that the initial page is Recorder
    expect(find.text('Record'), findsOneWidget);

    // Tap on the Upload tab
    await tester.tap(find.text('Upload'));
    await tester.pumpAndSettle();
    // Verify that the page changes to Upload
    expect(find.text('Upload'), findsOneWidget);

    // Tap on the Notes tab
    await tester.tap(find.text('Notes'));
    await tester.pumpAndSettle();
    // Verify that the page changes to Notes
    expect(find.text('Notes'), findsOneWidget);

    // Tap on the Questions tab
    await tester.tap(find.text('Questions'));
    await tester.pumpAndSettle();
    // Verify that the page changes to Questions
    expect(find.text('Questions'), findsOneWidget);

    // Tap on the Record tab
    await tester.tap(find.text('Record'));
    await tester.pumpAndSettle();
    // Verify that the page changes back to Record
    expect(find.text('Record'), findsOneWidget);
  });
}
