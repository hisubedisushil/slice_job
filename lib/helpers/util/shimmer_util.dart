import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

extension WidgetX on Widget {
  Widget shimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: this,
    );
  }
}

Widget shimmerWidget({
  double width = double.infinity,
  double height = 20,
  BorderRadius borderRadius = const BorderRadius.all(
    Radius.circular(5),
  ),
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: Colors.grey,
      ),
    ).shimmer();
