import 'package:flutter/material.dart';
import 'package:mazzad/Utils/AppColors.dart';

class customElevatedButton extends StatelessWidget {
  late Function() onTap;

  late Widget child;
  late Color color;

  late double width;

  late double height;
  late bool isLoading;

  customElevatedButton({
    required this.onTap,
    required this.child,
    required this.color,
    this.width = double.infinity,
    this.height = 50,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (!isLoading) {
          onTap();
        }
      },
      child: Center(
        child:
        !isLoading?
        child:
        CircularProgressIndicator(
          color: AppColors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        primary: color,
        minimumSize: Size(width, height),
      ),
    );
  }
}
