import 'package:flutter/foundation.dart';

import '../core/eye_engine.dart';
import '../core/series_order.dart';

/// App-wide state for AniEye. Holds only a search query in memory — nothing is
/// written to disk, so the app stores no data at all.
class EyeState extends ChangeNotifier {
  EyeState({EyeEngine? engine}) : _engine = engine ?? const EyeEngine();

  final EyeEngine _engine;

  String _query = '';

  String get query => _query;
  int get seriesCount => _engine.seriesCount;
  int get totalSteps => _engine.totalSteps;

  List<SeriesOrder> get visible => _engine.search(_query);

  SeriesOrder? byId(String id) => _engine.byId(id);

  void setQuery(String value) {
    if (_query == value) return;
    _query = value;
    notifyListeners();
  }
}
