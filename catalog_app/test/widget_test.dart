
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:catalog_app/main.dart';

void main() {
  testWidgets('GAMEHUB catalog loads successfully',
      (WidgetTester tester) async {
    // Build the GAMEHUB application.
    await tester.pumpWidget(const GameHubApp());

    // Verify that the app title appears.
    expect(find.text('GAMEHUB'), findsOneWidget);

    // Verify that the catalog heading appears.
    expect(find.text('Level Up Your Setup'), findsOneWidget);

    // Verify that the theme toggle button exists.
    expect(find.byIcon(Icons.light_mode), findsOneWidget);
  });
}
