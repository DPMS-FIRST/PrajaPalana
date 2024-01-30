import 'package:flutter/material.dart';

class DropdownTextFormFieldComponent<T> extends StatelessWidget {
  final String? label;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?)? onChanged;
  final T? value;
  final FormFieldSetter<T>? onSaved;
  final FormFieldValidator<T>? validator;
  final bool? isEnabled;
  final Color? color;
  final String? hintText;
  final String? labelText;
  final bool? isExpanded;

  DropdownTextFormFieldComponent({
    this.label,
    required this.items,
    required this.onChanged,
    required this.value,
    this.isEnabled,
    this.onSaved,
    this.validator,
    this.color,
    this.hintText,
    this.labelText,
    this.isExpanded,
  });

  @override
  Widget build(BuildContext context) {
    return /* Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: DropdownButtonFormField<T>(
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.grey, style: BorderStyle.solid),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.black, style: BorderStyle.solid),
          ),
          labelText: label,
          labelStyle: TextStyle(
            color: color ?? AppColors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        value: value,
        items: items,
        onChanged: isEnabled ? onChanged : null,
        isDense: true,
        isExpanded: true,
        disabledHint: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            value.toString(),
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    ); */
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: DropdownButtonFormField<T>(
                value: value,
                items: items,
                isExpanded: true,
                onChanged: onChanged,
                hint: Text(hintText ?? ""),
                decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.020,
              horizontal: MediaQuery.of(context).size.height * 0.015),
          labelText: labelText,
          labelStyle:
              TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
          hintStyle:
              TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.grey)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.grey)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.grey)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.grey)),
                ),
              ),
        );
  }
}
