import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppInputTextfield extends StatelessWidget {
  const AppInputTextfield({
    super.key,
    required this.hintText,
    required this.nameController,
    this.errorMessage,
    this.input_type,
    //  this.obsecuretext,
    //  this.node,
    //  this.action,
    //  this.onEditingComplete,
    this.prefixIcon,
    // this.isSecured,
    // this.isVisible,
    this.onTap,
    this.suffixIcon,
    this.length,
    this.inputFormatters,
    this.autofocus,
    this.textfieldwidth,
    this.isReadOnly,
    this.textColor,
    this.stringToCompare,
    this.errorMessage2,
  });
  final String? hintText, errorMessage;
  final TextEditingController nameController;
  final TextInputType? input_type;
  // final bool? obsecuretext;
  // final FocusScopeNode? node;
  // final TextInputAction? action;
  // final VoidCallback? onEditingComplete;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? length;
  final List<TextInputFormatter>? inputFormatters;
  final double? textfieldwidth;
  final bool? autofocus;
  final void Function()? onTap;
  final bool? isReadOnly;
  final textColor;
  final String? stringToCompare;
  final errorMessage2;

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: TextField(
          autofocus: autofocus ?? false,
          readOnly: isReadOnly ?? false,
          maxLength: length,
          inputFormatters: inputFormatters,
          // obscureText: obsecuretext,
          textInputAction: TextInputAction.done,
          // onEditingComplete: onEditingComplete,
          //style:  TextStyle(),
          controller: nameController,
          decoration: InputDecoration(
              counterText: '',
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white)),
              labelStyle: TextStyle(
                color: Colors.white,
              ),
              labelText: hintText,
              errorMaxLines: 3),

          style: TextStyle(
            color: textColor ?? Colors.white,
          ),
          keyboardType: input_type ?? TextInputType.text,
          /* Platform.isIOS
              ? TextInputType.text
              : input_type, */
        ),
      ),
    );
  }
}
