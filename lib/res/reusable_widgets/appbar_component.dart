import 'package:praja_palana/res/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:praja_palana/routes/app_routes.dart';

class AppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final void Function()? onPressedHome;
  final void Function()? onPressedBack;

  const AppBarComponent(
      {super.key, this.title, this.onPressedHome, this.onPressedBack});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: AppColors.appColor,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: onPressedBack ?? () => Navigator.pop(context),
        /*  onPressed: () {
          FocusScope.of(context).unfocus();
          Navigator.pop(context);
        }, */
      ),
      iconTheme: IconThemeData(
        color: AppColors.white,
      ),
      title: Text(
        title ?? '',
        style: TextStyle(fontSize: 18, color: AppColors.white),
      ),
      actions: [
        IconButton(
            icon: Icon(
              Icons.home,
              color: AppColors.white,
            ),
            onPressed: onPressedHome ??
                () => Navigator.pushReplacementNamed(
                    context, AppRoutes.dashboard)),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
