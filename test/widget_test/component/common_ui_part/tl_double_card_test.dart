import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/resource/tl_theme_type.dart';
import 'package:today_list/view/component/common_ui_part/tl_double_card.dart';

void main() {
  testWidgets('TLDoubleCard renders correctly', (WidgetTester tester) async {
    // Define test child widget
    const testChild = Text('Test Child');

    // Build our widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TLTheme(
            data: TLThemeType.sunOrange.config,
            child: const TLDoubleCard(
              borderRadius: 15.0,
              child: testChild,
            ),
          ),
        ),
      ),
    );

    // Verify the widget renders
    expect(find.byType(TLDoubleCard), findsOneWidget);
    expect(find.byType(Card), findsNWidgets(2)); // Should find two Card widgets
    expect(find.text('Test Child'), findsOneWidget);

    // Verify the border radius is applied
    final outerCard = tester.widget<Card>(find.byType(Card).first);
    final outerShape = outerCard.shape as RoundedRectangleBorder;
    expect(outerShape.borderRadius, BorderRadius.circular(15.0));
  });

  testWidgets('TLDoubleCard uses default border radius when not specified',
      (WidgetTester tester) async {
    // Build our widget without specifying borderRadius
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TLTheme(
            data: TLThemeType.sunOrange.config,
            child: const TLDoubleCard(
              child: Text('Test Child'),
            ),
          ),
        ),
      ),
    );

    // Verify the default border radius is applied
    final outerCard = tester.widget<Card>(find.byType(Card).first);
    final outerShape = outerCard.shape as RoundedRectangleBorder;
    expect(outerShape.borderRadius,
        BorderRadius.circular(10.0)); // Default is 10.0
  });
}
