import 'package:flutter/material.dart';

class WidgetTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;

  const WidgetTextField({Key? key, this.controller, this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      ),
    );
  }
}
