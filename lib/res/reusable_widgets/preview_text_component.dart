import 'package:flutter/material.dart';

class TextRowComponent extends StatelessWidget {
  final String? title;
  final String? value;
  final Color? color;
  final Color? valueColor;
  final FontWeight? fontWeight;

  const TextRowComponent(
      {super.key,
      this.title,
      this.value,
      this.color,
      this.fontWeight,
      this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Text(
              "$title",
              style: TextStyle(
                color: color ?? Colors.black,
                fontWeight: fontWeight ?? FontWeight.normal,
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Text(
              "$value",
              style: TextStyle(
                color: valueColor ?? Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
