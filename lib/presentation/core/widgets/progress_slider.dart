
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../colors/app_colors.dart';

class ProgressSlider extends StatelessWidget {
  final int currentStage;

  const ProgressSlider({
    super.key,
    required this.currentStage,
  });

  @override
  Widget build(BuildContext context) {
    final int stage = currentStage.clamp(1, 6);

    return SizedBox(
      height: 41.w,
      child: SliderTheme(
        data: SliderTheme.of(context).copyWith(
          trackHeight: 8.w,
          trackShape: ThreeCircleTrackShape(
            currentStage: stage,
          ),
          thumbShape: SliderComponentShape.noThumb,
          overlayShape: SliderComponentShape.noOverlay,
          activeTrackColor: blue,
          inactiveTrackColor: const Color(0xFFE5EAFB),
          thumbSize: WidgetStatePropertyAll(Size(30.w, 30.w)),
        ),
        child: Slider(
          value: stage.toDouble(),
          min: 1,
          max: 6,
          onChanged: (_) {},
        ),
      ),
    );
  }
}

class ThreeCircleTrackShape extends SliderTrackShape {
  final int currentStage;

  const ThreeCircleTrackShape({
    required this.currentStage,
  });

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    const double horizontalPadding = 8;
    final double height = 14.w;

    return Rect.fromLTWH(
      offset.dx + horizontalPadding,
      offset.dy + (parentBox.size.height - height) / 2,
      parentBox.size.width - horizontalPadding * 2,
      height,
    );
  }

  @override
  void paint(
      PaintingContext context,
      Offset offset, {
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required Animation<double> enableAnimation,
        required Offset thumbCenter,
        Offset? secondaryOffset,
        bool isEnabled = false,
        bool isDiscrete = false,
        required TextDirection textDirection,
      }) {
    final Canvas canvas = context.canvas;

    final Rect rect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    final double startX = rect.left;
    final double endX = rect.right;
    final double centerY = rect.center.dy;
    final double spacing = (endX - startX) / 2;

    final Color activeColor =
        sliderTheme.activeTrackColor ?? const Color(0xFF4169E1);

    final Color inactiveColor =
        sliderTheme.inactiveTrackColor ?? const Color(0xFFE5EAFB);

    canvas.drawLine(
      Offset(startX, centerY),
      Offset(endX, centerY),
      Paint()
        ..color = inactiveColor
        ..strokeWidth = 14.w
        ..strokeCap = StrokeCap.round,
    );

    final double progress =
    ((currentStage - 1) / 5).clamp(0.0, 1.0);

    final double progressX =
        startX + (endX - startX) * progress;
    final double lineStartX = startX + 18;

    canvas.drawLine(
      Offset(lineStartX, centerY),
      Offset(progressX, centerY),
      Paint()
        ..color = Colors.white
        ..strokeWidth = 11.w
        ..strokeCap = StrokeCap.round,
    );

    canvas.drawLine(
      Offset(startX, centerY),
      Offset(progressX, centerY),
      Paint()
        ..color = activeColor
        ..strokeWidth = 8.w
        ..strokeCap = StrokeCap.round,
    );

    const double circleRadius = 15;

    for (int i = 0; i < 3; i++) {
      final int stageNumber = i * 2 + 1;
      final double circleX = startX + spacing * i;
      final bool isCompleted = stageNumber <= currentStage;

      canvas.drawCircle(
        Offset(circleX, centerY),
        circleRadius,
        Paint()
          ..color = isCompleted ? activeColor : inactiveColor
          ..style = PaintingStyle.fill,
      );

      isCompleted ? canvas.drawCircle(
        Offset(circleX, centerY),
        circleRadius,
        Paint()
          ..color = white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 11,
      ) : SizedBox();

      canvas.drawCircle(
        Offset(circleX, centerY),
        circleRadius,
        Paint()
          ..color = inactiveColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = 5,
      );

      canvas.drawLine(
        Offset(startX, centerY),
        Offset(progressX, centerY),
        Paint()
          ..color = activeColor
          ..strokeWidth = 8.w
          ..strokeCap = StrokeCap.round,
      );
    }
  }
}
