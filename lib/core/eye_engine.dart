import 'eye_data.dart';
import 'series_order.dart';

/// Pure-Dart lookup logic for the watch-order catalogue: search and helpers.
/// No Flutter imports, so it is fully unit-testable.
class EyeEngine {
  const EyeEngine();

  List<SeriesOrder> get all => EyeData.series;

  SeriesOrder? byId(String id) {
    for (final SeriesOrder s in EyeData.series) {
      if (s.id == id) return s;
    }
    return null;
  }

  /// Case-insensitive search over series name and subtitle.
  List<SeriesOrder> search(String query) {
    final String q = query.trim().toLowerCase();
    if (q.isEmpty) return List<SeriesOrder>.of(EyeData.series);
    return EyeData.series
        .where((SeriesOrder s) =>
            s.name.toLowerCase().contains(q) ||
            s.short.toLowerCase().contains(q))
        .toList(growable: false);
  }

  int get seriesCount => EyeData.series.length;
  int get totalSteps => EyeData.totalSteps;
}
