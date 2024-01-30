import 'package:flutter/material.dart';
import 'package:praja_palana/res/constants/app_colors.dart';

class SearchComponent extends StatelessWidget {
  const SearchComponent(
      {super.key,
      required this.controller,
      this.onChanged,
      this.hintText,
      this.height,
      this.onPressed,
      this.onCloseSearch,
      this.crossIcon});
  final TextEditingController controller;
  final Function(String)? onChanged;
  final String? hintText;
  final double? height;
  final void Function()? onPressed;
  final void Function()? onCloseSearch;
  final IconData? crossIcon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColors.black,
          overflow: TextOverflow.visible,
          fontSize: 12,
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(
                  crossIcon,
                  color: Colors.black,
                ),
                onPressed: onCloseSearch,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                color: Colors.blue, // Adjust the color as needed
                child: TextButton(
                  onPressed: onPressed,
                  child: Text(
                    'Search',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
        /* Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.05,
            color: AppColors.appColor,
            child: TextButton(
              onPressed: onPressed,
              child: Text(
                'Search',
                style: TextStyle(color: AppColors.white),
              ),
            ),
          ),
        ), */
        //prefixIcon: IconButton(onPressed: onSearch, icon: Icon(Icons.search)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1.0),
          borderRadius: BorderRadius.circular(0.0),
        ),
      ),
    );
  }
}
/*  IconButton(
                  onPressed: onCloseSearch,
                  icon: Icon(
                    crossIcon,
                    color: Colors.grey,
                  ),
                ), */