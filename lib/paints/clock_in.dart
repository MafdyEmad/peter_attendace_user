import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class ClockIn extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.3629931, size.height * 0.9447862);
    path_0.cubicTo(
        size.width * 0.4664103,
        size.height * 0.9790276,
        size.width * 0.5783448,
        size.height * 0.9774276,
        size.width * 0.6807414,
        size.height * 0.9402483);
    path_0.cubicTo(
        size.width * 0.7831379,
        size.height * 0.9030690,
        size.width * 0.8700241,
        size.height * 0.8324759,
        size.width * 0.9273828,
        size.height * 0.7398621);
    path_0.cubicTo(
        size.width * 0.9847379,
        size.height * 0.6472448,
        size.width * 1.009221,
        size.height * 0.5380069,
        size.width * 0.9968828,
        size.height * 0.4297724);
    path_0.cubicTo(
        size.width * 0.9845414,
        size.height * 0.3215345,
        size.width * 0.9360966,
        size.height * 0.2206114,
        size.width * 0.8593621,
        size.height * 0.1432841);
    path_0.cubicTo(
        size.width * 0.7826310,
        size.height * 0.06595690,
        size.width * 0.6820862,
        size.height * 0.01673455,
        size.width * 0.5739483,
        size.height * 0.003558793);
    path_0.cubicTo(
        size.width * 0.4658103,
        size.height * -0.009616966,
        size.width * 0.3563862,
        size.height * 0.01402207,
        size.width * 0.2633297,
        size.height * 0.07066207);
    path_0.cubicTo(
        size.width * 0.1702741,
        size.height * 0.1273021,
        size.width * 0.09901345,
        size.height * 0.2136400,
        size.width * 0.06104414,
        size.height * 0.3157469);
    path_0.cubicTo(
        size.width * 0.02307517,
        size.height * 0.4178552,
        size.width * 0.02061186,
        size.height * 0.5297759,
        size.width * 0.05405172,
        size.height * 0.6334517);
    path_0.lineTo(size.width * 0.1001793, size.height * 0.6185759);
    path_0.cubicTo(
        size.width * 0.07008345,
        size.height * 0.5252655,
        size.width * 0.07230034,
        size.height * 0.4245345,
        size.width * 0.1064724,
        size.height * 0.3326397);
    path_0.cubicTo(
        size.width * 0.1406448,
        size.height * 0.2407434,
        size.width * 0.2047793,
        size.height * 0.1630393,
        size.width * 0.2885293,
        size.height * 0.1120634);
    path_0.cubicTo(
        size.width * 0.3722793,
        size.height * 0.06108724,
        size.width * 0.4707621,
        size.height * 0.03981241,
        size.width * 0.5680862,
        size.height * 0.05167034);
    path_0.cubicTo(
        size.width * 0.6654103,
        size.height * 0.06352862,
        size.width * 0.7559000,
        size.height * 0.1078286,
        size.width * 0.8249586,
        size.height * 0.1774231);
    path_0.cubicTo(
        size.width * 0.8940207,
        size.height * 0.2470179,
        size.width * 0.9376207,
        size.height * 0.3378486,
        size.width * 0.9487241,
        size.height * 0.4352621);
    path_0.cubicTo(
        size.width * 0.9598310,
        size.height * 0.5326759,
        size.width * 0.9377966,
        size.height * 0.6309897,
        size.width * 0.8861759,
        size.height * 0.7143414);
    path_0.cubicTo(
        size.width * 0.8345552,
        size.height * 0.7976966,
        size.width * 0.7563586,
        size.height * 0.8612276,
        size.width * 0.6642000,
        size.height * 0.8946897);
    path_0.cubicTo(
        size.width * 0.5720448,
        size.height * 0.9281517,
        size.width * 0.4713000,
        size.height * 0.9295931,
        size.width * 0.3782241,
        size.height * 0.8987759);
    path_0.lineTo(size.width * 0.3629931, size.height * 0.9447862);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.shader = ui.Gradient.linear(
        Offset(size.width * 0.8965517, size.height * 0.2068966),
        Offset(size.width * 0.7242862, size.height * 0.05253448),
        [Color(0xff6671E7).withOpacity(1), Color(0xff5BB2C8).withOpacity(1)],
        [0, 1]);
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.3066955, size.height * 0.8882000);
    path_1.lineTo(size.width * 0.2865428, size.height * 0.7691862);
    path_1.lineTo(size.width * 0.2983955, size.height * 0.7699310);
    path_1.lineTo(size.width * 0.3219679, size.height * 0.9127069);
    path_1.lineTo(size.width * 0.1814859, size.height * 0.8790414);
    path_1.lineTo(size.width * 0.1815410, size.height * 0.8671621);
    path_1.lineTo(size.width * 0.2989107, size.height * 0.8954862);
    path_1.lineTo(size.width * 0.09905897, size.height * 0.6813448);
    path_1.lineTo(size.width * 0.1068528, size.height * 0.6740724);
    path_1.lineTo(size.width * 0.3066955, size.height * 0.8882000);
    path_1.close();

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.shader = ui.Gradient.linear(
        Offset(size.width * 0.8965517, size.height * 0.2068966),
        Offset(size.width * 0.7242862, size.height * 0.05253448),
        [Color(0xff6671E7).withOpacity(1), Color(0xff5BB2C8).withOpacity(1)],
        [0, 1]);
    canvas.drawPath(path_1, paint_1_fill);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.5517241, size.height * 0.1724145);
    path_2.lineTo(size.width * 0.5862069, size.height * 0.1724145);
    path_2.lineTo(size.width * 0.5862069, size.height * 0.5862069);
    path_2.lineTo(size.width * 0.5517241, size.height * 0.5862069);
    path_2.lineTo(size.width * 0.5517241, size.height * 0.1724145);
    path_2.close();

    Paint paint_2_fill = Paint()..style = PaintingStyle.fill;
    paint_2_fill.shader = ui.Gradient.linear(
        Offset(size.width * 0.8965517, size.height * 0.2068966),
        Offset(size.width * 0.7242862, size.height * 0.05253448),
        [Color(0xff6671E7).withOpacity(1), Color(0xff5BB2C8).withOpacity(1)],
        [0, 1]);
    canvas.drawPath(path_2, paint_2_fill);

    Path path_3 = Path();
    path_3.moveTo(size.width * 0.3103448, size.height * 0.6206897);
    path_3.lineTo(size.width * 0.3103448, size.height * 0.5862069);
    path_3.lineTo(size.width * 0.5862069, size.height * 0.5862069);
    path_3.lineTo(size.width * 0.5862069, size.height * 0.6206897);
    path_3.lineTo(size.width * 0.3103448, size.height * 0.6206897);
    path_3.close();

    Paint paint_3_fill = Paint()..style = PaintingStyle.fill;
    paint_3_fill.shader = ui.Gradient.linear(
        Offset(size.width * 0.8965517, size.height * 0.2068966),
        Offset(size.width * 0.7242862, size.height * 0.05253448),
        [Color(0xff6671E7).withOpacity(1), Color(0xff5BB2C8).withOpacity(1)],
        [0, 1]);
    canvas.drawPath(path_3, paint_3_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
