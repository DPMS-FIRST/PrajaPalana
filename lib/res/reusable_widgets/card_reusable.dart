import 'package:flutter/material.dart';
import 'package:praja_palana/res/constants/app_colors.dart';

class CardReusable extends StatelessWidget {
  const CardReusable({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
        surfaceTintColor: AppColors.white,
      elevation: 4, // Adjust the elevation as needed
      margin: EdgeInsets.all(8), // Adjust the margin as needed
      child: Padding(
        padding: EdgeInsets.all(10), // Adjust the padding as needed
        child: child,
      ),
    );
  }
}

class RichTextReusable extends StatelessWidget {
  const RichTextReusable({
    super.key,
    required this.text,
  });
  //final String heading;
  final String text;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: [
        // TextSpan(
        //   text: heading,
        //   style: TextStyle(
        //       color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16),
        // ),
        TextSpan(
          text: text,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16),
        ),
      ]),
    );
  }
}
