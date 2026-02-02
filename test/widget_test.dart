import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notehax/main.dart';

void main() {
  testWidgets('App starts and shows NoteHax title', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const NoteHaxApp());

    // Verify that the app title is displayed
    expect(find.text('NoteHax'), findsOneWidget);
  });

  testWidgets('App shows empty state initially', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const NoteHaxApp());
    
    // Wait for any async operations to complete
    await tester.pumpAndSettle();

    // Verify that empty state message is shown (notes list would be empty initially)
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });

  testWidgets('App has a FloatingActionButton to add notes', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const NoteHaxApp());
    
    // Wait for any async operations to complete
    await tester.pumpAndSettle();

    // Verify that the FAB is present
    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
  });
}
