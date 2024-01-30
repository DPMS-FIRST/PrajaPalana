import 'package:flutter/material.dart';
import 'package:praja_palana/res/constants/app_assets.dart';
import 'package:praja_palana/res/constants/app_colors.dart';

class CustomFooterContainer extends StatelessWidget {
  const CustomFooterContainer({Key? key, this.radius}) : super(key: key);
  final double? radius;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 1.0),
      height: MediaQuery.of(context).size.height * 0.06,
      decoration: BoxDecoration(
        color: AppColors.appColor,
        /* borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius ?? 20),
          topRight: Radius.circular(radius ?? 20),
        ), */
      ),
      child: Image.asset(
        AppAssets.footerCgg,
        width: double.infinity,
      ),
    );
  }
}
