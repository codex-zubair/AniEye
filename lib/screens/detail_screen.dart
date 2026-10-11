import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/series_order.dart';
import '../state/eye_state.dart';
import '../theme/app_theme.dart';
import '../widgets/brand.dart';

/// Detail: the ordered watch steps for one series.
class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.seriesId});

  final String seriesId;

  @override
  Widget build(BuildContext context) {
    final SeriesOrder? series = context.read<EyeState>().byId(seriesId);

    if (series == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Not found')),
        body: const Center(child: Text('This series is unavailable.')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(series.name)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    AppTheme.accent.withValues(alpha: 0.24),
                    AppTheme.accent2.withValues(alpha: 0.16),
                  ],
                ),
                borderRadius: BorderRadius.circular(22),
                border:
                    Border.all(color: AppTheme.accent.withValues(alpha: 0.4)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Pill(
                        label: series.orderType,
                        color: AppTheme.accent2,
                        icon: Icons.list_alt_rounded,
                      ),
                      const Spacer(),
                      Pill(
                        label: '${series.stepCount} steps',
                        color: AppTheme.gold,
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    series.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    series.short,
                    style: const TextStyle(color: AppTheme.muted),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    series.blurb,
                    style: const TextStyle(height: 1.5, fontSize: 14.5),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 4, bottom: 10),
              child: Text(
                'WATCH ORDER',
                style: TextStyle(
                  color: AppTheme.muted,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.4,
                ),
              ),
            ),
            for (int i = 0; i < series.steps.length; i++)
              _StepTile(
                step: series.steps[i],
                isLast: i == series.steps.length - 1,
              ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppTheme.surfaceAlt,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Icon(Icons.info_outline_rounded,
                      size: 18, color: AppTheme.accent2),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Watch orders are editorial suggestions, not official. '
                      'Optional steps can be skipped without losing the main '
                      'story.',
                      style: const TextStyle(
                          color: AppTheme.muted, height: 1.45, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StepTile extends StatelessWidget {
  const _StepTile({required this.step, required this.isLast});

  final WatchStep step;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            children: <Widget>[
              OrderBadge(number: step.order, optional: step.isOptional),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    color: AppTheme.divider,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          step.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 15.5,
                          ),
                        ),
                      ),
                      if (step.isOptional)
                        const Pill(
                          label: 'Optional',
                          color: AppTheme.muted,
                        ),
                    ],
                  ),
                  if (step.note != null) ...<Widget>[
                    const SizedBox(height: 4),
                    Text(
                      step.note!,
                      style: const TextStyle(
                        color: AppTheme.muted,
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
