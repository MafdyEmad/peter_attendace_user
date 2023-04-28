import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final height;
  final width;
  final child;
  final onTap;
  const MyButton(
      {super.key,
      this.child,
      double? this.height,
      double? this.width,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        height: height,
        width: width,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 136, 136, 136),
              offset: Offset(0, 3),
              blurRadius: 5,
            ),
          ],
          borderRadius: BorderRadius.circular(8),
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 62, 130, 224),
              Color.fromARGB(255, 154, 135, 228)
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: child,
      ),
    );
  }
}
