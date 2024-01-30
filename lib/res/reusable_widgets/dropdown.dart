import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String errorMessage;
  final List<String> occupationOptions;
  final void Function()? onTap;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  CustomDropdown({
    required this.hintText,
    required this.controller,
    required this.errorMessage,
    required this.occupationOptions,
    this.onTap,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.95,
        child: TextFormField(
          style: const TextStyle(color: Colors.black),
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.black),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.black),
            ),
            labelStyle: TextStyle(
              color: Colors.black,
              fontSize: 14.0,
            ),
            labelText: hintText,
          ),
          onTap: onTap,
          readOnly: true,
          /*   validator: (value) {
            if (value!.isEmpty) {
              return errorMessage;
            }
          }, */
        ),
      ),
    );
  }
}
