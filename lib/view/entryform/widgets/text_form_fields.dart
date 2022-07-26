import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.type,
    required this.validator,
    required this.controller,
  }) : super(key: key);
  final String text;
  final IconData icon;
  final TextInputType type;
  final FormFieldValidator<String> validator;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        
          prefixIcon: Icon(icon),
          labelText: text,
          border: OutlineInputBorder()),
      keyboardType: type,
    );
  }
}
