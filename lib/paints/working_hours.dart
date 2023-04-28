import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class WorkingHours extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.3331864, size.height * 0.9450357);
    path_0.cubicTo(
        size.width * 0.4366321,
        size.height * 0.9792857,
        size.width * 0.5485964,
        size.height * 0.9776857,
        size.width * 0.6510214,
        size.height * 0.9404964);
    path_0.cubicTo(
        size.width * 0.7534429,
        size.height * 0.9033071,
        size.width * 0.8403536,
        size.height * 0.8326964,
        size.width * 0.8977250,
        size.height * 0.7400571);
    path_0.cubicTo(
        size.width * 0.9550964,
        size.height * 0.6474179,
        size.width * 0.9795857,
        size.height * 0.5381500,
        size.width * 0.9672429,
        size.height * 0.4298857);
    path_0.cubicTo(
        size.width * 0.9549000,
        size.height * 0.3216196,
        size.width * 0.9064429,
        size.height * 0.2206700,
        size.width * 0.8296893,
        size.height * 0.1433221);
    path_0.cubicTo(
        size.width * 0.7529357,
        size.height * 0.06597429,
        size.width * 0.6523643,
        size.height * 0.01673900,
        size.width * 0.5441964,
        size.height * 0.003559743);
    path_0.cubicTo(
        size.width * 0.4360286,
        size.height * -0.009619500,
        size.width * 0.3265775,
        size.height * 0.01402575,
        size.width * 0.2334975,
        size.height * 0.07068071);
    path_0.cubicTo(
        size.width * 0.1404171,
        size.height * 0.1273357,
        size.width * 0.06913786,
        size.height * 0.2136964,
        size.width * 0.03115864,
        size.height * 0.3158304);
    path_0.cubicTo(
        size.width * -0.006820536,
        size.height * 0.4179643,
        size.width * -0.009284500,
        size.height * 0.5299143,
        size.width * 0.02416432,
        size.height * 0.6336214);
    path_0.lineTo(size.width * 0.07030393, size.height * 0.6187393);
    path_0.cubicTo(
        size.width * 0.04020000,
        size.height * 0.5254036,
        size.width * 0.04241750,
        size.height * 0.4246464,
        size.width * 0.07659893,
        size.height * 0.3327275);
    path_0.cubicTo(
        size.width * 0.1107800,
        size.height * 0.2408071,
        size.width * 0.1749318,
        size.height * 0.1630825,
        size.width * 0.2587039,
        size.height * 0.1120929);
    path_0.cubicTo(
        size.width * 0.3424761,
        size.height * 0.06110357,
        size.width * 0.4409821,
        size.height * 0.03982286,
        size.width * 0.5383321,
        size.height * 0.05168393);
    path_0.cubicTo(
        size.width * 0.6356821,
        size.height * 0.06354536,
        size.width * 0.7262000,
        size.height * 0.1078571,
        size.width * 0.7952750,
        size.height * 0.1774700);
    path_0.cubicTo(
        size.width * 0.8643536,
        size.height * 0.2470832,
        size.width * 0.9079643,
        size.height * 0.3379379,
        size.width * 0.9190750,
        size.height * 0.4353750);
    path_0.cubicTo(
        size.width * 0.9301857,
        size.height * 0.5328143,
        size.width * 0.9081429,
        size.height * 0.6311536,
        size.width * 0.8565071,
        size.height * 0.7145321);
    path_0.cubicTo(
        size.width * 0.8048750,
        size.height * 0.7979071,
        size.width * 0.7266571,
        size.height * 0.8614571,
        size.width * 0.6344750,
        size.height * 0.8949286);
    path_0.cubicTo(
        size.width * 0.5422929,
        size.height * 0.9283964,
        size.width * 0.4415250,
        size.height * 0.9298357,
        size.width * 0.3484239,
        size.height * 0.8990143);
    path_0.lineTo(size.width * 0.3331864, size.height * 0.9450357);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.shader = ui.Gradient.linear(
        Offset(size.width * 0.2142857, size.height * 0.08928571),
        Offset(size.width * 0.07274393, size.height * 0.2680421),
        [Color(0xff5BB2C8).withOpacity(1), Color(0xff6671E7).withOpacity(1)],
        [0, 1]);
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.7082321, size.height * 0.3185854);
    path_1.lineTo(size.width * 0.7281071, size.height * 0.3378864);
    path_1.lineTo(size.width * 0.4289429, size.height * 0.6459179);
    path_1.lineTo(size.width * 0.4090714, size.height * 0.6266179);
    path_1.lineTo(size.width * 0.7082321, size.height * 0.3185854);
    path_1.close();

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.shader = ui.Gradient.linear(
        Offset(size.width * 0.2142857, size.height * 0.08928571),
        Offset(size.width * 0.07274393, size.height * 0.2680421),
        [Color(0xff5BB2C8).withOpacity(1), Color(0xff6671E7).withOpacity(1)],
        [0, 1]);
    canvas.drawPath(path_1, paint_1_fill);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.2500839, size.height * 0.4722107);
    path_2.lineTo(size.width * 0.2693846, size.height * 0.4523357);
    path_2.lineTo(size.width * 0.4482429, size.height * 0.6260429);
    path_2.lineTo(size.width * 0.4289429, size.height * 0.6459179);
    path_2.lineTo(size.width * 0.2500839, size.height * 0.4722107);
    path_2.close();

    Paint paint_2_fill = Paint()..style = PaintingStyle.fill;
    paint_2_fill.shader = ui.Gradient.linear(
        Offset(size.width * 0.2142857, size.height * 0.08928571),
        Offset(size.width * 0.07274393, size.height * 0.2680421),
        [Color(0xff5BB2C8).withOpacity(1), Color(0xff6671E7).withOpacity(1)],
        [0, 1]);
    canvas.drawPath(path_2, paint_2_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
