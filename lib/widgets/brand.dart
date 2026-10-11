import 'package:flutter/material.dart';

import '../core/app_info.dart';
import '../theme/app_theme.dart';

/// Rounded gradient app mark with an "eye + play" lens glyph.
class BrandMark extends StatelessWidget {
  const BrandMark({super.key, this.size = 44});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: AppTheme.brandGradient,
        borderRadius: BorderRadius.circular(size * 0.28),
      ),
      child: CustomPaint(painter: _EyePainter()),
    );
  }
}

class _EyePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint white = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final Paint stroke = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.075
      ..strokeCap = StrokeCap.round;

    final double w = size.width;
    final double h = size.height;
    final Offset c = Offset(w * 0.5, h * 0.5);

    // Eye outline: two arcs forming a lens/almond shape.
    final Path eye = Path()
      ..moveTo(w * 0.16, h * 0.5)
      ..quadraticBezierTo(w * 0.5, h * 0.16, w * 0.84, h * 0.5)
      ..quadraticBezierTo(w * 0.5, h * 0.84, w * 0.16, h * 0.5)
      ..close();

    // Draw the rim (stroke) and a soft fill.
    canvas.drawPath(
      eye,
      Paint()
        ..color = Colors.white.withValues(alpha: 0.22)
        ..style = PaintingStyle.fill,
    );
    canvas.drawPath(eye, stroke);

    // Play triangle inside the eye (the pupil).
    final Path play = Path()
      ..moveTo(c.dx - w * 0.06, c.dy - h * 0.13)
      ..lineTo(c.dx - w * 0.06, c.dy + h * 0.13)
      ..lineTo(c.dx + w * 0.13, c.dy)
      ..close();
    canvas.drawPath(play, white);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Wordmark row used in headers.
class BrandHeader extends StatelessWidget {
  const BrandHeader({super.key, this.showSubtitle = true});

  final bool showSubtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const BrandMark(size: 40),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              AppInfo.name,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.6,
              ),
            ),
            if (showSubtitle)
              const Text(
                AppInfo.tagline,
                style: TextStyle(fontSize: 12, color: AppTheme.muted),
              ),
          ],
        ),
      ],
    );
  }
}

/// Small pill badge.
class Pill extends StatelessWidget {
  const Pill({
    super.key,
    required this.label,
    this.color = AppTheme.accent2,
    this.icon,
  });

  final String label;
  final Color color;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (icon != null) ...<Widget>[
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

/// Privacy reassurance chip shown in the header.
class OfflineChip extends StatelessWidget {
  const OfflineChip({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.divider),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(Icons.verified_user_outlined, size: 15, color: AppTheme.accent2),
          SizedBox(width: 6),
          Text(
            'Offline',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppTheme.muted,
            ),
          ),
        ],
      ),
    );
  }
}

/// A circular numeric order badge (used in the detail list).
class OrderBadge extends StatelessWidget {
  const OrderBadge({super.key, required this.number, this.optional = false});

  final int number;
  final bool optional;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: optional ? null : AppTheme.brandGradient,
        color: optional ? AppTheme.surfaceAlt : null,
        border: optional
            ? Border.all(color: AppTheme.divider)
            : null,
      ),
      child: Text(
        '$number',
        style: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 16,
          color: optional ? AppTheme.muted : Colors.white,
        ),
      ),
    );
  }
}
