import 'package:flutter/material.dart';
import 'package:mevolve/app_colors.dart';

class CancelButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget? child;

  const CancelButton({@required this.onPressed, @required this.child, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.lightBlue,
        foregroundColor: AppColors.darkBlue,
      ),
      child: child,
    );
  }
}
