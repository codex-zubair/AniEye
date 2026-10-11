import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/series_order.dart';
import '../state/eye_state.dart';
import '../theme/app_theme.dart';
import '../widgets/brand.dart';
import 'detail_screen.dart';

/// Home: a searchable list of series with their watch orders.
class SeriesListScreen extends StatelessWidget {
  const SeriesListScreen({super.key});

  void _open(BuildContext context, SeriesOrder series) {
    context.read<EyeState>();
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => DetailScreen(seriesId: series.id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final EyeState state = context.watch<EyeState>();
    final List<SeriesOrder> items = state.visible;

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 6, 16, 10),
          child: TextField(
            onChanged: state.setQuery,
            style: const TextStyle(fontSize: 14),
            decoration: const InputDecoration(
              hintText: 'Search a series',
              prefixIcon: Icon(Icons.search_rounded, size: 20),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
          child: Row(
            children: <Widget>[
              Text(
                '${items.length} ${items.length == 1 ? 'series' : 'series'}',
                style: const TextStyle(
                  color: AppTheme.muted,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Pill(label: '${state.totalSteps} steps bundled'),
            ],
          ),
        ),
        Expanded(
          child: items.isEmpty
              ? const Center(child: Text('No series found.'))
              : ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
                  itemCount: items.length,
                  separatorBuilder: (_, _) =>
                      const Divider(height: 1, color: AppTheme.divider),
                  itemBuilder: (BuildContext context, int i) => _SeriesRow(
                    series: items[i],
                    onTap: () => _open(context, items[i]),
                  ),
                ),
        ),
      ],
    );
  }
}

class _SeriesRow extends StatelessWidget {
  const _SeriesRow({required this.series, required this.onTap});

  final SeriesOrder series;
  final VoidCallback onTap;

  Color _tone() {
    const List<Color> tones = <Color>[
      AppTheme.accent,
      AppTheme.accent2,
      AppTheme.gold,
      Color(0xFFB07CFF),
    ];
    int h = 0;
    for (final int c in series.name.codeUnits) {
      h = (h * 31 + c) & 0x7fffffff;
    }
    return tones[h % tones.length];
  }

  @override
  Widget build(BuildContext context) {
    final Color tone = _tone();
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: <Widget>[
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: tone.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: tone.withValues(alpha: 0.4)),
              ),
              child: const Icon(Icons.playlist_play_rounded,
                  size: 24, color: Colors.white),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    series.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.w800, fontSize: 15.5),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '${series.short} · ${series.stepCount} steps',
                    style: const TextStyle(
                        color: AppTheme.muted, fontSize: 12.5),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: AppTheme.muted),
          ],
        ),
      ),
    );
  }
}
