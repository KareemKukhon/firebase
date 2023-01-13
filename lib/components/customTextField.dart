import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final Function validation;
  final TextEditingController controller;
  bool isPassword;
  final TextInputType textInputType;
  bool? enabled;
  String? value;
  final String label;
  CustomTextfield({
    Key? key,
    required this.validation,
    required this.controller,
    this.isPassword = false,
    this.textInputType = TextInputType.text,
    this.enabled,
    this.value,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFormField(
      keyboardType: textInputType,
      obscureText: isPassword,
      controller: controller,
      // initialValue: value,
      validator: (v) => validation(v),
      decoration: InputDecoration(
        enabled: enabled??true,
          label: Text(label + value!),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
    );
  }
}
