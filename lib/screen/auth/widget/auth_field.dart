import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isObscureText;
  const AuthField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isObscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(hintText: hintText),
      obscureText: isObscureText,
      obscuringCharacter: "*", // change the display obscure text
      validator: (value) {
        if (value?.trim().isEmpty == true) {
          return "$hintText is missing";
        }

        return null;
      },
    );
  }
}
