import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReusableTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType keyboardType;
  final int? maxLength;
  final int? maxLines;
  final bool? readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final String? prefixText;
  final TextStyle? prefixStyle;
  final double? left;
  final double? right;
  final void Function(String)? onChanged;
  final TextCapitalization? charcterTextCapitalization;

  ReusableTextFormField(
      {required this.controller,
      required this.labelText,
      this.keyboardType = TextInputType.text,
      this.maxLength,
      this.maxLines,
      this.inputFormatters,
      this.readOnly,
      this.prefixText,
      this.prefixStyle,
      this.left,
      this.right,
      this.onChanged,
      this.charcterTextCapitalization});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(top: 8.0, left: left ?? 8.0, right: right ?? 8.0),
      child: TextFormField(
        onChanged: onChanged,
        readOnly: readOnly ?? false,
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        maxLength: maxLength,
        textCapitalization:
            charcterTextCapitalization ?? TextCapitalization.none,
        inputFormatters: inputFormatters ??
            [
              if (keyboardType == TextInputType.phone)
                FilteringTextInputFormatter.digitsOnly
            ],
        decoration: InputDecoration(
          prefixText: prefixText,
          prefixStyle: prefixStyle,
          contentPadding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.020,
            horizontal: MediaQuery.of(context).size.height * 0.015,
          ),
          counterText: "",
          labelText: labelText,
          labelStyle: TextStyle(
            overflow: TextOverflow.visible,
            color: Colors.black,
            fontSize: 14.0,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.grey, style: BorderStyle.solid),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.grey, style: BorderStyle.solid),
          ),
        ),
        validator: (value) {
          if (maxLength != null && value != null && value.length != maxLength) {
            return 'Invalid length. Must be $maxLength digits.';
          }
          return null;
        },
      ),
    );
  }
}
