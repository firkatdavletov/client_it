import 'package:flutter/material.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.backgroundColor = Colors.blueAccent
  }) : super(key: key);

  final VoidCallback onPressed;
  final String text;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
          fixedSize: MaterialStateProperty.all<Size>(
              const Size(double.maxFinite, 40)
          )
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
