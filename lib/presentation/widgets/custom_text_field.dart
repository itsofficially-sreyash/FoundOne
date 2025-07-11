import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final Widget? prefixIcon;
  final String hintText;
  final String labelText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final InputBorder? border;
  final int? textLength;

  const CustomTextField({
    super.key,
    required this.controller,
    this.prefixIcon,
    required this.hintText,
    required this.keyboardType,
    this.validator,
    this.focusNode,
    required this.labelText,
    this.border,
    this.textLength,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: [LengthLimitingTextInputFormatter(textLength)],
      controller: controller,
      keyboardType: keyboardType,
      minLines: 1,
      maxLines: 7,
      focusNode: focusNode,
      validator: validator,
      decoration: InputDecoration(
        border: border,
        prefixIcon: prefixIcon,
        hintText: hintText,
        labelText: labelText,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}
