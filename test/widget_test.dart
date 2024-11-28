// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:finance_tracker/main.dart';

void main() {
  testWidgets('App should render with bottom navigation',
      (WidgetTester tester) async {
    await tester.pumpWidget(FinanceTrackerApp());

    // Verify bottom navigation items exist
    expect(find.text('Dashboard'), findsOneWidget);
    expect(find.text('Add Transaction'), findsOneWidget);
    expect(find.text('Insights'), findsOneWidget);

    // Verify initial screen is Dashboard
    expect(find.byIcon(Icons.dashboard), findsOneWidget);
  });
}
