import 'package:flutter/foundation.dart';

/// One step in a series watch order.
@immutable
class WatchStep {
  const WatchStep({
    required this.order,
    required this.title,
    this.note,
    this.isOptional = false,
  });

  /// 1-based position in the recommended viewing order.
  final int order;

  /// The arc, season or film name.
  final String title;

  /// Short, original editorial note about this step.
  final String? note;

  /// True when the step can be skipped without losing the main story.
  final bool isOptional;
}

/// A series with its recommended watch order.
@immutable
class SeriesOrder {
  const SeriesOrder({
    required this.id,
    required this.name,
    required this.short,
    required this.blurb,
    required this.steps,
    this.orderType = 'Release order',
  });

  final String id;
  final String name;

  /// One-line subtitle, e.g. "Monogatari series".
  final String short;

  /// Short original description.
  final String blurb;

  /// The ordered steps.
  final List<WatchStep> steps;

  /// A label such as "Release order" or "Chronological order".
  final String orderType;

  int get stepCount => steps.length;

  @override
  bool operator ==(Object other) => other is SeriesOrder && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
