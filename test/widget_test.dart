import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:watchanimetv/core/eye_data.dart';
import 'package:watchanimetv/main.dart';
import 'package:watchanimetv/state/eye_state.dart';

void main() {
  testWidgets('AniEye shows the offline series list', (WidgetTester tester) async {
    await tester.pumpWidget(const AniEyeApp());
    await tester.pumpAndSettle();

    expect(find.text('AniEye'), findsWidgets);
    expect(find.text('Offline'), findsOneWidget);
    expect(find.textContaining('steps bundled'), findsOneWidget);
    expect(find.text('Fate'), findsOneWidget);
    expect(find.text('Orders'), findsOneWidget);
    expect(find.text('About'), findsOneWidget);
  });

  testWidgets('tapping a series opens its watch order', (WidgetTester tester) async {
    await tester.pumpWidget(const AniEyeApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Fate'));
    await tester.pumpAndSettle();

    expect(find.text('WATCH ORDER'), findsOneWidget);
    expect(find.text('Optional'), findsWidgets);
  });

  testWidgets('search filters the list', (WidgetTester tester) async {
    await tester.pumpWidget(const AniEyeApp());
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'jojo');
    await tester.pumpAndSettle();

    expect(find.text("JoJo's Bizarre Adventure"), findsOneWidget);
    expect(find.text('Fate'), findsNothing);
  });

  testWidgets('About tab exposes the privacy policy button',
      (WidgetTester tester) async {
    await tester.pumpWidget(const AniEyeApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('About'));
    await tester.pumpAndSettle();

    expect(find.text('Read Privacy Policy'), findsOneWidget);
    expect(find.text('Private by design'), findsOneWidget);
  });

  test('EyeState search updates visible list', () {
    final EyeState state = EyeState();
    expect(state.visible.length, EyeData.series.length);
    state.setQuery('gintama');
    expect(state.visible.length, 1);
    expect(state.visible.first.name, 'Gintama');
  });
}
