import 'package:flutter/material.dart';

class RowComponentTagged extends StatelessWidget {
  final String? title;
  final String? value;
  final Color? color;
  final Color? valueColor;
  final FontWeight? fontWeight;
  final int? titleFlex;
  final int? valueFlex;
  const RowComponentTagged(
      {super.key,
      this.title,
      this.value,
      this.color,
      this.fontWeight,
      this.titleFlex,
      this.valueFlex,
      this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: titleFlex ?? 4,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
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
          flex: valueFlex ?? 6,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Text(
              "$value",
              style: TextStyle(
                color: valueColor ?? Colors.black,
              ),
            ),
          ),
        ),
        Expanded(
          flex: valueFlex ?? 2,
          child: Padding(
            
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: CircleAvatar(
              foregroundColor: Colors.red,
              
              child: Text(
                "22",
                style: TextStyle(
                  color: valueColor ?? Colors.orange,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
