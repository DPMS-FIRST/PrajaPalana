import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class datePickerComponent extends StatelessWidget {
  const datePickerComponent(
      {super.key,
      required this.hintText,
      required this.nameController,
      required this.errorMessage,
      this.input_type,
      required this.obsecuretext,
      this.node,
      required this.action,
      required this.onEditingComplete,
      this.globalKey,
      this.prefixIcon,
      // this.isSecured,
      // this.isVisible,
      this.futureValuesDisable,
      this.onTap,
      this.suffixIcon,
      this.editable,
      this.firstDate,
      this.lastDate});
  final String hintText, errorMessage;
  final TextEditingController nameController;
  final TextInputType? input_type;
  final bool obsecuretext;
  final FocusScopeNode? node;
  final TextInputAction action;
  final VoidCallback? onEditingComplete;
  final GlobalKey? globalKey;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? editable;
  final bool? futureValuesDisable;
  final DateTime? firstDate;
  final DateTime? lastDate;

  // final IconData? suffixIcon;
  // final bool? isSecured;
  // final bool? isVisible;

  final void Function()? onTap;
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.95,
        height: MediaQuery.of(context).size.height * 0.065,
        child: TextFormField(
          readOnly: true,
          obscureText: obsecuretext,
          textInputAction: action,
          onEditingComplete: onEditingComplete,
          style: const TextStyle(color: Colors.black),
          controller: nameController,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
                borderSide: BorderSide(color: Colors.black)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
                borderSide: BorderSide(color: Colors.grey)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
                borderSide: BorderSide(color: Colors.black)),
            labelStyle: TextStyle(
              color: Colors.black,
              fontSize: 14.0,
            ),
            labelText: hintText,
          ),
          onTap: (editable ?? true)
              ? () async {
                  await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: firstDate ?? DateTime(1900),
                    lastDate: (futureValuesDisable ?? false)
                        ? DateTime.now()
                        : DateTime(3000),
                  ).then((selectedDate) {
                    if (selectedDate != null) {
                      nameController.text =
                          DateFormat('dd/MM/yyyy').format(selectedDate);
                    }
                  });
                }
              : null,
          /*  validator: (value) {
            if (value!.isEmpty) {
              return errorMessage;
            }
          }, */
          keyboardType: input_type,
        ),
      ),
    );
  }
}
