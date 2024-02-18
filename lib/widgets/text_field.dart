import 'package:flutter/material.dart';

class TextFiledWidget extends StatelessWidget {
  final bool obscure;
  final String hintText;
  final TextInputType inputType;
  final TextEditingController controller;
  const TextFiledWidget({
    Key? key,
    required this.obscure,
    required this.hintText,
    required this.inputType,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: inputBorder,
        enabledBorder: inputBorder,
        focusedBorder: inputBorder,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.shade500),
        filled: true,
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType: inputType,
      obscureText: obscure,
    );
  }
}
