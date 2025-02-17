import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final Color color;
  final bool isFilled;
  final bool isTextWhite;

  const CustomOutlinedButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.color = Colors.blue,
    this.isFilled = false,
    this.isTextWhite = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
        side: WidgetStateProperty.all(BorderSide(color: color)),
        backgroundColor: WidgetStateProperty.all(
            isFilled ? color.withOpacity(0.3) : Colors.transparent),
      ),
      onPressed: () => onPressed(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(
          text,
          style: TextStyle(
              fontSize: 16, color: isTextWhite ? Colors.white : color),
        ),
      ),
    );
  }
}
