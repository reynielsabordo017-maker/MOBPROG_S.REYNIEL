import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tip_calculator/main.dart';

void main() {
  // Test the tip calculation function
  test('Calculates 15% tip correctly', () {
    final result = computeTip(500, 15);

    expect(result.tip, 75.0);
    expect(result.total, 575.0);
  });

  // Test another tip percentage
  test('Calculates 20% tip correctly', () {
    final result = computeTip(500, 20);

    expect(result.tip, 100.0);
    expect(result.total, 600.0);
  });

  // Test bill input validation
  test('Returns null for invalid bill input', () {
    expect(parseBill('abc'), isNull);
    expect(parseBill(''), isNull);
  });

  // Test the Tip Calculator screen
  testWidgets('Displays Tip Calculator interface', (tester) async {
    await tester.pumpWidget(const TipApp());

    expect(find.text('Tip Calculator'), findsOneWidget);
    expect(find.text('Calculate Your Tip'), findsOneWidget);
    expect(find.text('Bill Amount'), findsOneWidget);
    expect(find.text('Select Tip Percentage'), findsOneWidget);
    expect(find.text('10%'), findsOneWidget);
    expect(find.text('15%'), findsOneWidget);
    expect(find.text('20%'), findsOneWidget);
  });

  // Test bill input and automatic calculation
  testWidgets('Calculates tip when bill is entered', (tester) async {
    await tester.pumpWidget(const TipApp());

    await tester.enterText(find.byType(TextField), '500');
    await tester.pump();

    expect(find.text('₱75.00'), findsOneWidget);
    expect(find.text('₱575.00'), findsOneWidget);
  });
}
