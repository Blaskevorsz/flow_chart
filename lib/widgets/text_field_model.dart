import 'package:flutter/material.dart';

class TextFieldModel extends StatelessWidget {
  const TextFieldModel(
      {super.key,
      required this.size,
      required this.arrowsController,
      required this.title,
      required this.enabled});

  final String title;
  final Size size;
  final TextEditingController arrowsController;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size.width * 0.25,
        child: TextField(
          enabled: enabled,
          controller: arrowsController,
          style: const TextStyle(
              color: Colors.black, fontSize: 16, fontFamily: 'msbold'),
          cursorColor: Colors.black,
          decoration: InputDecoration(
            hintStyle: const TextStyle(
                color: Colors.black, fontSize: 16, fontFamily: 'mregular'),
            hintText: 'Ingresa algo...',
            contentPadding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05, vertical: size.height * 0.02),
            labelText: title,
            labelStyle: const TextStyle(
                color: Colors.black, fontSize: 16, fontFamily: 'mbold'),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.grey, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.black, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.grey, width: 1.5),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
          ),
        ),
      ),
    );
  }
}
