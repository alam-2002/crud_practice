import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color color;
  final String hintText;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.color,
    required this.hintText,
  }); // const CustomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll<Color>(color),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // Rounded corners
          ),
        ),
      ),
      child: Text(
        hintText,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
