import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class DropdownTextFormField<T> extends StatelessWidget {
  final String label;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?)? onChanged;
  final T value;
  final FormFieldSetter<T>? onSaved;
  final FormFieldValidator<T>? validator;
  final bool isEnabled;

  DropdownTextFormField({
    required this.label,
    required this.items,
    required this.onChanged,
    required this.value,
    required this.isEnabled,
    this.onSaved,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        InputDecorator(
          decoration: InputDecoration(
            labelText: label.toUpperCase(),
            labelStyle: TextStyle(
              color: AppColors.primaryColor,
            ),
            border: InputBorder.none,
          ),
          child: DropdownButtonFormField<T>(
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
        ),
      ],
    );
  }
}
