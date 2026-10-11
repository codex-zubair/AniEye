import 'package:flutter_test/flutter_test.dart';
import 'package:watchanimetv/core/eye_data.dart';
import 'package:watchanimetv/core/eye_engine.dart';
import 'package:watchanimetv/core/series_order.dart';

void main() {
  group('EyeData integrity', () {
    test('catalogue is non-empty and ids are unique', () {
      expect(EyeData.series.length, greaterThanOrEqualTo(10));
      final Set<String> ids =
          EyeData.series.map((SeriesOrder s) => s.id).toSet();
      expect(ids.length, EyeData.series.length);
    });

    test('every series has at least one step and a blurb', () {
      for (final SeriesOrder s in EyeData.series) {
        expect(s.steps, isNotEmpty, reason: '${s.id} has no steps');
        expect(s.blurb.trim(), isNotEmpty);
        expect(s.name.trim(), isNotEmpty);
      }
    });

    test('steps are numbered 1..n in order', () {
      for (final SeriesOrder s in EyeData.series) {
        for (int i = 0; i < s.steps.length; i++) {
          expect(s.steps[i].order, i + 1, reason: '${s.id} step ordering');
          expect(s.steps[i].title.trim(), isNotEmpty);
        }
      }
    });

    test('totalSteps matches the sum across series', () {
      final int sum = EyeData.series
          .fold<int>(0, (int a, SeriesOrder s) => a + s.stepCount);
      expect(EyeData.totalSteps, sum);
    });
  });

  group('EyeEngine', () {
    test('byId finds a known series and returns null otherwise', () {
      const EyeEngine e = EyeEngine();
      expect(e.byId('fate')?.name, 'Fate');
      expect(e.byId('nope'), isNull);
    });

    test('search matches name and subtitle, case-insensitive', () {
      const EyeEngine e = EyeEngine();
      expect(e.search('jojo').length, 1);
      expect(e.search('MONOGATARI').length, 1);
      expect(e.search('  ').length, EyeData.series.length);
      expect(e.search('zzzzz'), isEmpty);
    });

    test('counts are exposed', () {
      const EyeEngine e = EyeEngine();
      expect(e.seriesCount, EyeData.series.length);
      expect(e.totalSteps, EyeData.totalSteps);
    });
  });
}
