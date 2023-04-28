// import 'dart:ui' as ui;

// import 'package:flutter/material.dart';

// //Copy this CustomPainter code to the Bottom of the File
// class ClockOut extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Path path_0 = Path();
//     path_0.moveTo(size.width * 0.9447862, size.height * 0.6370103);
//     path_0.cubicTo(
//         size.width * 0.9790276,
//         size.height * 0.5335931,
//         size.width * 0.9774276,
//         size.height * 0.4216552,
//         size.width * 0.9402483,
//         size.height * 0.3192597);
//     path_0.cubicTo(
//         size.width * 0.9030690,
//         size.height * 0.2168628,
//         size.width * 0.8324759,
//         size.height * 0.1299772,
//         size.width * 0.7398621,
//         size.height * 0.07262034);
//     path_0.cubicTo(
//         size.width * 0.6472448,
//         size.height * 0.01526362,
//         size.width * 0.5380069,
//         size.height * -0.009219552,
//         size.width * 0.4297724,
//         size.height * 0.003120931);
//     path_0.cubicTo(
//         size.width * 0.3215345,
//         size.height * 0.01546141,
//         size.width * 0.2206114,
//         size.height * 0.06390586,
//         size.width * 0.1432841,
//         size.height * 0.1406386);
//     path_0.cubicTo(
//         size.width * 0.06595655,
//         size.height * 0.2173714,
//         size.width * 0.01673455,
//         size.height * 0.3179172,
//         size.width * 0.003558793,
//         size.height * 0.4260552);
//     path_0.cubicTo(
//         size.width * -0.009617000,
//         size.height * 0.5341931,
//         size.width * 0.01402203,
//         size.height * 0.6436172,
//         size.width * 0.07066207,
//         size.height * 0.7366724);
//     path_0.cubicTo(
//         size.width * 0.1273021,
//         size.height * 0.8297276,
//         size.width * 0.2136400,
//         size.height * 0.9009897,
//         size.width * 0.3157469,
//         size.height * 0.9389586);
//     path_0.cubicTo(
//         size.width * 0.4178552,
//         size.height * 0.9769276,
//         size.width * 0.5297759,
//         size.height * 0.9793897,
//         size.width * 0.6334517,
//         size.height * 0.9459517);
//     path_0.lineTo(size.width * 0.6185759, size.height * 0.8998241);
//     path_0.cubicTo(
//         size.width * 0.5252655,
//         size.height * 0.9299172,
//         size.width * 0.4245345,
//         size.height * 0.9277034,
//         size.width * 0.3326397,
//         size.height * 0.8935310);
//     path_0.cubicTo(
//         size.width * 0.2407434,
//         size.height * 0.8593586,
//         size.width * 0.1630393,
//         size.height * 0.7952241,
//         size.width * 0.1120634,
//         size.height * 0.7114724);
//     path_0.cubicTo(
//         size.width * 0.06108724,
//         size.height * 0.6277241,
//         size.width * 0.03981207,
//         size.height * 0.5292414,
//         size.width * 0.05167034,
//         size.height * 0.4319172);
//     path_0.cubicTo(
//         size.width * 0.06352862,
//         size.height * 0.3345931,
//         size.width * 0.1078286,
//         size.height * 0.2441017,
//         size.width * 0.1774231,
//         size.height * 0.1750424);
//     path_0.cubicTo(
//         size.width * 0.2470179,
//         size.height * 0.1059828,
//         size.width * 0.3378486,
//         size.height * 0.06238276,
//         size.width * 0.4352621,
//         size.height * 0.05127655);
//     path_0.cubicTo(
//         size.width * 0.5326759,
//         size.height * 0.04017000,
//         size.width * 0.6309897,
//         size.height * 0.06220483,
//         size.width * 0.7143414,
//         size.height * 0.1138259);
//     path_0.cubicTo(
//         size.width * 0.7976966,
//         size.height * 0.1654469,
//         size.width * 0.8612276,
//         size.height * 0.2436441,
//         size.width * 0.8946897,
//         size.height * 0.3358010);
//     path_0.cubicTo(
//         size.width * 0.9281517,
//         size.height * 0.4279586,
//         size.width * 0.9295931,
//         size.height * 0.5287000,
//         size.width * 0.8987759,
//         size.height * 0.6217759);
//     path_0.lineTo(size.width * 0.9447862, size.height * 0.6370103);
//     path_0.close();

//     Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
//     paint_0_fill.shader = ui.Gradient.linear(
//         Offset(size.width * 0.2068966, size.height * 0.1034503),
//         Offset(size.width * 0.05253448, size.height * 0.2757155),
//         [Color(0xff5BB2C8).withOpacity(1), Color(0xff6671E7).withOpacity(1)],
//         [0, 1]);
//     canvas.drawPath(path_0, paint_0_fill);

//     Path path_1 = Path();
//     path_1.moveTo(size.width * 0.8882000, size.height * 0.6933069);
//     path_1.lineTo(size.width * 0.7691862, size.height * 0.7134586);
//     path_1.lineTo(size.width * 0.7699310, size.height * 0.7016069);
//     path_1.lineTo(size.width * 0.9127069, size.height * 0.6780345);
//     path_1.lineTo(size.width * 0.8790414, size.height * 0.8185172);
//     path_1.lineTo(size.width * 0.8671621, size.height * 0.8184621);
//     path_1.lineTo(size.width * 0.8954862, size.height * 0.7010931);
//     path_1.lineTo(size.width * 0.6813448, size.height * 0.9009448);
//     path_1.lineTo(size.width * 0.6740724, size.height * 0.8931483);
//     path_1.lineTo(size.width * 0.8882000, size.height * 0.6933069);
//     path_1.close();

//     Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
//     paint_1_fill.shader = ui.Gradient.linear(
//         Offset(size.width * 0.2068966, size.height * 0.1034503),
//         Offset(size.width * 0.05253448, size.height * 0.2757155),
//         [Color(0xff5BB2C8).withOpacity(1), Color(0xff6671E7).withOpacity(1)],
//         [0, 1]);
//     canvas.drawPath(path_1, paint_1_fill);

//     Path path_2 = Path();
//     path_2.moveTo(size.width * 0.1724145, size.height * 0.4482793);
//     path_2.lineTo(size.width * 0.1724145, size.height * 0.4137966);
//     path_2.lineTo(size.width * 0.5862069, size.height * 0.4137966);
//     path_2.lineTo(size.width * 0.5862069, size.height * 0.4482793);
//     path_2.lineTo(size.width * 0.1724145, size.height * 0.4482793);
//     path_2.close();

//     Paint paint_2_fill = Paint()..style = PaintingStyle.fill;
//     paint_2_fill.shader = ui.Gradient.linear(
//         Offset(size.width * 0.2068966, size.height * 0.1034503),
//         Offset(size.width * 0.05253448, size.height * 0.2757155),
//         [Color(0xff5BB2C8).withOpacity(1), Color(0xff6671E7).withOpacity(1)],
//         [0, 1]);
//     canvas.drawPath(path_2, paint_2_fill);

//     Path path_3 = Path();
//     path_3.moveTo(size.width * 0.6206897, size.height * 0.6896586);
//     path_3.lineTo(size.width * 0.5862069, size.height * 0.6896586);
//     path_3.lineTo(size.width * 0.5862069, size.height * 0.4137966);
//     path_3.lineTo(size.width * 0.6206897, size.height * 0.4137966);
//     path_3.lineTo(size.width * 0.6206897, size.height * 0.6896586);
//     path_3.close();

//     Paint paint_3_fill = Paint()..style = PaintingStyle.fill;
//     paint_3_fill.shader = ui.Gradient.linear(
//         Offset(size.width * 0.2068966, size.height * 0.1034503),
//         Offset(size.width * 0.05253448, size.height * 0.2757155),
//         [Color(0xff5BB2C8).withOpacity(1), Color(0xff6671E7).withOpacity(1)],
//         [0, 1]);
//     canvas.drawPath(path_3, paint_3_fill);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }
