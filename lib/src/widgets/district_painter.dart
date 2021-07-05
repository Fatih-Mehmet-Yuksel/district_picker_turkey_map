import 'package:district_picker_turkey_map/district_picker_turkey_map.dart';
import 'package:district_picker_turkey_map/src/size_controller.dart';
import 'package:flutter/material.dart';

class DistrictPainter extends CustomPainter {
  final District district;
  final District? selectedDistrict;
  final Color? strokeColor;
  final Color? selectedColor;
  final Color? dotColor;

  final sizeController = SizeController.instance;

  double _scale = 1.0;

  DistrictPainter(
      {required this.district,
        required this.selectedDistrict,
        this.selectedColor,
        this.strokeColor,
        this.dotColor});

  @override
  void paint(Canvas canvas, Size size) {

    final pen = Paint()
      ..color = strokeColor ?? Colors.white60
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final selectedPen = Paint()
      ..color = selectedColor ?? Colors.blue
      ..strokeWidth = 1.0
      ..style = PaintingStyle.fill;

    final redDot = Paint()
      ..color = dotColor ?? Colors.red
      ..strokeWidth = 3.0
      ..style = PaintingStyle.fill;

    final bounds = district.path.getBounds();

    _scale = sizeController.calculateScale(size);
    canvas.scale(_scale);

    if (district.id == selectedDistrict?.id) {
      canvas.drawPath(district.path, selectedPen);
    }
    canvas.drawCircle(bounds.center, 3.0, redDot);
    canvas.drawPath(district.path, pen);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  @override
  bool hitTest(Offset position) {
    double inverseScale = sizeController.inverseOfScale(_scale);
    return district.path.contains(position.scale(inverseScale, inverseScale));
  }
}