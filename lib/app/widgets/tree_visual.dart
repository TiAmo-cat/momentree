import 'package:flutter/material.dart';
import '../themes/app_theme_config.dart';

class TreeVisual extends StatelessWidget {
  final int stage; // 0-3
  final bool withered;
  final AppThemeConfig theme;
  final double size;

  const TreeVisual({
    super.key,
    required this.stage,
    required this.withered,
    required this.theme,
    this.size = 200,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          // Glow ring behind tree
          if (!withered && theme.foliageGlow != const Color(0x00000000))
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    center: const Alignment(0, -0.2),
                    radius: 0.7,
                    colors: [
                      theme.foliageGlow,
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          CustomPaint(
            size: Size(size, size),
            painter: _TreePainter(
              stage: stage,
              withered: withered,
              theme: theme,
            ),
          ),
        ],
      ),
    );
  }
}

class _TreePainter extends CustomPainter {
  final int stage;
  final bool withered;
  final AppThemeConfig theme;

  _TreePainter({
    required this.stage,
    required this.withered,
    required this.theme,
  });

  Color get trunk => withered ? theme.trunkColorWithered : theme.trunkColor;
  Color get fBase => withered ? theme.foliageWithered : theme.foliageBase;
  Color get fMid => withered ? const Color(0xFF4B5563) : theme.foliageMid;
  Color get fLight => withered ? const Color(0xFF6B7280) : theme.foliageLight;
  Color get ground => withered ? const Color(0xFF374151) : theme.groundColor;

  @override
  void paint(Canvas canvas, Size size) {
    final scaleX = size.width / 200;
    final scaleY = size.height / 200;
    canvas.scale(scaleX, scaleY);

    switch (stage) {
      case 0:
        _drawSeedling(canvas);
        break;
      case 1:
        _drawSapling(canvas);
        break;
      case 2:
        _drawYoungTree(canvas);
        break;
      case 3:
        _drawMatureTree(canvas);
        break;
    }
  }

  Paint _fill(Color color, {double opacity = 1.0}) => Paint()
    ..color = color.withOpacity(opacity)
    ..style = PaintingStyle.fill;

  Paint _stroke(Color color, double width) => Paint()
    ..color = color
    ..style = PaintingStyle.stroke
    ..strokeWidth = width
    ..strokeCap = StrokeCap.round;

  void _drawSeedling(Canvas canvas) {
    // Ground patch
    canvas.drawOval(
      Rect.fromCenter(center: const Offset(100, 168), width: 60, height: 16),
      _fill(ground, opacity: 0.6),
    );
    // Stem
    final stemPath = Path()
      ..moveTo(100, 165)
      ..quadraticBezierTo(97, 145, 100, 130);
    canvas.drawPath(stemPath, _stroke(trunk, 4));

    // Left leaf
    canvas.save();
    canvas.translate(88, 143);
    canvas.rotate(-35 * 3.14159 / 180);
    canvas.drawOval(
      Rect.fromCenter(center: Offset.zero, width: 20, height: 12),
      _fill(fMid),
    );
    canvas.restore();

    // Right leaf
    canvas.save();
    canvas.translate(112, 140);
    canvas.rotate(35 * 3.14159 / 180);
    canvas.drawOval(
      Rect.fromCenter(center: Offset.zero, width: 20, height: 12),
      _fill(fLight),
    );
    canvas.restore();

    // Top bud
    canvas.drawCircle(const Offset(100, 128), 7, _fill(fLight));
  }

  void _drawSapling(Canvas canvas) {
    // Ground
    canvas.drawOval(
      Rect.fromCenter(center: const Offset(100, 170), width: 84, height: 20),
      _fill(ground, opacity: 0.7),
    );
    // Trunk
    final trunkPath = Path()
      ..moveTo(95, 170)
      ..quadraticBezierTo(93, 145, 96, 120)
      ..lineTo(104, 120)
      ..quadraticBezierTo(107, 145, 105, 170)
      ..close();
    canvas.drawPath(trunkPath, _fill(trunk));

    // Side branches
    final lBranch = Path()
      ..moveTo(97, 155)
      ..quadraticBezierTo(82, 148, 75, 150);
    canvas.drawPath(lBranch, _stroke(trunk, 3));
    final rBranch = Path()
      ..moveTo(103, 152)
      ..quadraticBezierTo(118, 145, 125, 147);
    canvas.drawPath(rBranch, _stroke(trunk, 3));

    // Canopy
    final glowPaint = _fill(fBase)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    canvas.drawCircle(const Offset(100, 108), 30, glowPaint);
    canvas.drawCircle(const Offset(80, 115), 22, _fill(fMid));
    canvas.drawCircle(const Offset(120, 113), 20, _fill(fMid));
    canvas.drawCircle(const Offset(100, 95), 23, _fill(fLight));
    canvas.drawCircle(const Offset(92, 88), 10, _fill(fLight, opacity: 0.6));
  }

  void _drawYoungTree(Canvas canvas) {
    // Ground
    canvas.drawOval(
      Rect.fromCenter(center: const Offset(100, 172), width: 110, height: 24),
      _fill(ground, opacity: 0.8),
    );
    // Roots
    _drawPath(canvas, [const Offset(93, 170), const Offset(80, 175), const Offset(68, 178)], trunk, 3.5, opacity: 0.7);
    _drawPath(canvas, [const Offset(107, 170), const Offset(120, 175), const Offset(132, 178)], trunk, 3.5, opacity: 0.7);

    // Trunk
    final trunkPath = Path()
      ..moveTo(92, 172)
      ..quadraticBezierTo(89, 140, 93, 105)
      ..lineTo(107, 105)
      ..quadraticBezierTo(111, 140, 108, 172)
      ..close();
    canvas.drawPath(trunkPath, _fill(trunk));

    // Branches
    _drawPath(canvas, [const Offset(94, 148), const Offset(75, 138), const Offset(66, 142)], trunk, 4);
    _drawPath(canvas, [const Offset(106, 145), const Offset(125, 135), const Offset(134, 139)], trunk, 4);

    // Canopy
    final glowPaint = _fill(fBase)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    canvas.drawCircle(const Offset(100, 90), 45, glowPaint);
    canvas.drawCircle(const Offset(70, 105), 32, _fill(fMid));
    canvas.drawCircle(const Offset(130, 100), 30, _fill(fMid));
    canvas.drawCircle(const Offset(100, 82), 34, _fill(fMid));
    canvas.drawCircle(const Offset(80, 92), 22, _fill(fLight));
    canvas.drawCircle(const Offset(118, 88), 20, _fill(fLight));
    canvas.drawCircle(const Offset(100, 70), 20, _fill(fLight));
    canvas.drawCircle(const Offset(87, 72), 11, _fill(fLight, opacity: 0.65));
    canvas.drawCircle(const Offset(110, 76), 9, _fill(fLight, opacity: 0.5));
  }

  void _drawMatureTree(Canvas canvas) {
    // Ground
    canvas.drawOval(
      Rect.fromCenter(center: const Offset(100, 178), width: 140, height: 28),
      _fill(ground, opacity: 0.9),
    );
    // Root system
    _drawPath(canvas, [const Offset(90, 175), const Offset(72, 182), const Offset(58, 186)], trunk, 5, opacity: 0.8);
    _drawPath(canvas, [const Offset(110, 175), const Offset(128, 182), const Offset(142, 186)], trunk, 5, opacity: 0.8);
    _drawPath(canvas, [const Offset(95, 176), const Offset(88, 185), const Offset(82, 190)], trunk, 3, opacity: 0.6);
    _drawPath(canvas, [const Offset(105, 176), const Offset(112, 185), const Offset(118, 190)], trunk, 3, opacity: 0.6);

    // Trunk
    final trunkPath = Path()
      ..moveTo(88, 178)
      ..quadraticBezierTo(84, 135, 90, 90)
      ..lineTo(110, 90)
      ..quadraticBezierTo(116, 135, 112, 178)
      ..close();
    canvas.drawPath(trunkPath, _fill(trunk));

    // Branches
    _drawPath(canvas, [const Offset(92, 140), const Offset(70, 125), const Offset(60, 130)], trunk, 5);
    _drawPath(canvas, [const Offset(108, 136), const Offset(130, 121), const Offset(140, 126)], trunk, 5);
    _drawPath(canvas, [const Offset(94, 120), const Offset(82, 108), const Offset(78, 112)], trunk, 3.5);
    _drawPath(canvas, [const Offset(106, 118), const Offset(118, 106), const Offset(122, 110)], trunk, 3.5);

    // Canopy layers
    final glowPaint = _fill(fBase)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    canvas.drawCircle(const Offset(100, 72), 58, glowPaint);
    canvas.drawCircle(const Offset(60, 100), 38, _fill(fBase));
    canvas.drawCircle(const Offset(140, 95), 36, _fill(fBase));
    canvas.drawCircle(const Offset(75, 82), 35, _fill(fMid));
    canvas.drawCircle(const Offset(125, 78), 33, _fill(fMid));
    canvas.drawCircle(const Offset(100, 60), 40, _fill(fMid));
    canvas.drawCircle(const Offset(62, 88), 26, _fill(fLight));
    canvas.drawCircle(const Offset(138, 84), 24, _fill(fLight));
    canvas.drawCircle(const Offset(85, 65), 28, _fill(fLight));
    canvas.drawCircle(const Offset(115, 62), 26, _fill(fLight));
    canvas.drawCircle(const Offset(100, 45), 25, _fill(fLight));
    canvas.drawCircle(const Offset(80, 52), 15, _fill(fLight, opacity: 0.6));
    canvas.drawCircle(const Offset(115, 48), 13, _fill(fLight, opacity: 0.55));
    canvas.drawCircle(const Offset(68, 74), 12, _fill(fLight, opacity: 0.5));
    canvas.drawCircle(const Offset(134, 72), 11, _fill(fLight, opacity: 0.45));
  }

  void _drawPath(Canvas canvas, List<Offset> points, Color color, double width, {double opacity = 1.0}) {
    if (points.length < 2) return;
    final path = Path()..moveTo(points[0].dx, points[0].dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }
    final paint = Paint()
      ..color = color.withOpacity(opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = width
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_TreePainter oldDelegate) =>
      oldDelegate.stage != stage ||
      oldDelegate.withered != withered ||
      oldDelegate.theme != theme;
}

