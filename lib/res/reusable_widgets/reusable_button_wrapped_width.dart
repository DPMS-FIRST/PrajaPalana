import 'package:praja_palana/res/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ReusableNoWidthButton extends StatelessWidget {
  const ReusableNoWidthButton(
      {super.key, this.onPressed, required this.ButtonText});
  final Function()? onPressed;
  final String ButtonText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                AppColors.appColor,
              ),
            ),
            onPressed: onPressed,
            child: Text(
              ButtonText,
              style: TextStyle(color: Colors.white, fontSize: 17),
            )),
      ),
    );
  }
}
