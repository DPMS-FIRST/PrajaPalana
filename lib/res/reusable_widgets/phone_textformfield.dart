import 'package:praja_palana/res/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneTextformfield extends StatelessWidget {
  const PhoneTextformfield({
    super.key,
    required this.hintText,
    required this.controller,
    this.obscureText,
    this.node,
    this.action,
    this.globalKey,
    this.prefixIcon,
    this.onTap,
    this.suffixIcon,
    this.TextLength,
    this.filterPattern,
    this.labelstyle,
    this.topLabel,
    this.keyboardType,
    this.maxLength, this.inputFormatters,
  });
  final String hintText;
  final TextEditingController controller;
  final bool? obscureText;
  final FocusScopeNode? node;
  final TextInputAction? action;
  final GlobalKey? globalKey;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final void Function()? onTap;
  final int? TextLength;
  final Pattern? filterPattern;
  final TextStyle? labelstyle;
  final TextStyle? topLabel;
  final TextInputType? keyboardType;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FocusScope(
        node: node,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.06,
          child: TextFormField(
            maxLength: maxLength,
            style: TextStyle(
              color: AppColors.black,
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "$hintText can't be Empty ";
              } else {
                return null;
              }
            },
            obscureText: obscureText ?? false,
            textInputAction: TextInputAction.done,
            onEditingComplete: () {
              node!.unfocus();
            },
            controller: controller,
            decoration: InputDecoration(
              counterText: "",
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.0),
                borderSide: BorderSide(
                  color: Colors.grey.shade300,
                ),
              ),
              errorBorder: UnderlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.0),
                borderSide: BorderSide(
                  color: AppColors.appColor,
                ),
              ),
              labelText: hintText,
              floatingLabelStyle: topLabel,
              labelStyle: labelstyle,
            ),
            inputFormatters: inputFormatters,
            keyboardType: keyboardType,
          ),
        ),
      ),
    );
  }
}
