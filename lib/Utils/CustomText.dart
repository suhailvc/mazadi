import 'package:flutter/material.dart';



class AppText extends StatelessWidget {
  final String text;
  TextStyle? textStyle;


  AppText(
      {required this.text,
        this.textStyle,
      });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle,
    );
  }
}
