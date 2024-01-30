import 'package:praja_palana/res/constants/app_colors.dart';
import 'package:flutter/material.dart';

class Declaration extends StatelessWidget {
  const Declaration(
      {super.key, this.onChanged, required this.finalDayOut, this.declaration});
  final void Function(bool?)? onChanged;
  final bool finalDayOut;
  final String? declaration;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          fillColor: MaterialStateColor.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return Colors.red; // Set the desired color for the checked state
            }
            return Colors
                .white; // Set the desired color for the unchecked state
          }),
          visualDensity: VisualDensity(horizontal: -4, vertical: -4),
          value: finalDayOut,
          onChanged: onChanged,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              declaration ?? "",
              softWrap: true,
              style: TextStyle(
                  fontSize: 15,
                  color: AppColors.appColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
