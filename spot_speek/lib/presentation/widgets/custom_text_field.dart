import 'package:flutter/material.dart';

class BorderedTextField extends StatelessWidget {
  final TextEditingController controller;
  final String placeholder;
  final bool obscureText;
  final Icon? leftIcon;
  final TextInputType keyboardType;
  final String? Function(String?) validator;

  const BorderedTextField(
      {super.key,
      this.obscureText = false,
      required this.placeholder,
      required this.validator,
      this.leftIcon,
      this.keyboardType = TextInputType.text,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
          prefixIcon: leftIcon,
          prefixIconColor: Theme.of(context).colorScheme.primary,
          label: Text(placeholder),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)))),
      keyboardType: keyboardType,
      validator: validator,
    );
  }
}
