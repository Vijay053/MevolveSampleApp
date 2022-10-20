import 'package:flutter/material.dart';

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
        backgroundColor: const Color(0xffEDF8FF),
        foregroundColor: const Color(0xff1DA1F2),
      ),
      child: child,
    );
  }
}
