import 'package:flutter/material.dart';

class FollowButton extends StatelessWidget {
  final Color borderColor;
  final Color backgroundColor;
  final Color textColor;
  final String text;
  Function()? onPressFunction;
  FollowButton(
      {super.key,
      required this.borderColor,
      required this.backgroundColor,
      required this.text, required this.textColor, this.onPressFunction});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 1),
      child: TextButton(
        onPressed: onPressFunction,
        child: Container(
          
          decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.circular(5)),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold, 
            ),
          ),
          width: 250,
          height: 27,
        ),
      ),
    );
  }
}
