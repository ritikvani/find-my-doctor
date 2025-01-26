import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget customTextField({
  required String labelText,
  required String hintText,
  required TextEditingController controller,
  bool isEditable = true,
  String? defaultValue,
}) {
  if (defaultValue != null && controller.text.isEmpty) {
    controller.text = defaultValue;
  }

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: 40,
          child: TextField(
            controller: controller,
            enabled: isEditable,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: isEditable ? Colors.white : Colors.grey[300],
              contentPadding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
