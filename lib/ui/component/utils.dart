import 'package:flutter/material.dart';

enum Shape {
  circle,
  rectangle,
}

extension ShapeExtension on Shape {
  Widget getShapeContainer({
    double width = 100.0,
    double height = 100.0,
    Color color = Colors.blue,
    double bRadius = 0,
    Widget? child,
  }) {
    switch (this) {
      case Shape.circle:
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
          child: child,
        );
      case Shape.rectangle:
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: color,
            borderRadius: BorderRadius.circular(bRadius),
          ),
          child: child,
        );
    }
  }
}
