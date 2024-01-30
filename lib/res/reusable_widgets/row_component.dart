import 'package:flutter/material.dart';

class RowComponent extends StatelessWidget {
  final String? title;
  final String? value;
  final Color? color;
  final Color? valueColor;
  final FontWeight? fontWeight;
  final int? titleFlex;
  final int? valueFlex;
  final double? fontSize;
  const RowComponent({
    super.key,
    this.title,
    this.value,
    this.color,
    this.fontWeight,
    this.titleFlex,
    this.valueFlex,
    this.valueColor,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: titleFlex ?? 4,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 10.0, top: 0.0, bottom: 8.0),
            child: Text(
              "$title",
              style: TextStyle(
                fontSize: fontSize,
                color: color ?? Colors.black,
                fontWeight: fontWeight ?? FontWeight.normal,
              ),
            ),
          ),
        ),
        Expanded(
          flex: valueFlex ?? 6,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 10.0, top: 0.0, bottom: 8.0),
            child: Text(
              "$value",
              style: TextStyle(
                fontSize: fontSize,
                color: valueColor ?? Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
