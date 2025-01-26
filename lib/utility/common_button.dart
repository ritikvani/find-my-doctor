import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final String buttonText;
  final Color textColor ;
  final Color backgroundColor;
  final VoidCallback onPressed;

  const CommonButton({
    Key? key,
    required this.buttonText,
    required this.backgroundColor,
    required this.onPressed,
    required this.textColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 207,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: backgroundColor,

          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(22), // Optional for rounded corners
          ),
          padding: const EdgeInsets.symmetric(
              horizontal: 24, vertical: 12), // Optional padding
        ),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style:  TextStyle(
              fontSize: 18, color: textColor), // Customize text style
        ),
      ),
    );
  }
}
