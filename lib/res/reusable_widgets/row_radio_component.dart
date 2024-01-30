import 'package:flutter/material.dart';

class RowRadioComponent extends StatelessWidget {
  final String? title;
  final Widget? row;
  const RowRadioComponent({super.key, this.title, this.row});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(title.toString()),
        ),
        Expanded(
          flex: 2,
          child: row ?? Container(),
        ),
      ],
    );
  }
}
