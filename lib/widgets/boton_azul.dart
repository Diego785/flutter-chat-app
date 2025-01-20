import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {
  final String buttonText;
  final void Function()? onPressed;

  const BotonAzul({
    Key? key,
    required this.buttonText,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: this.onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue, // Change the background color
        foregroundColor: Colors.white, // Change the text (foreground) color
        minimumSize: const Size(double.infinity, 55), // Set minimum size
        padding: const EdgeInsets.symmetric(horizontal: 16), // Add some padding
        textStyle: const TextStyle(fontSize: 17), // Set text style
        shape: RoundedRectangleBorder(
          // Set rounded corners
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Container(
        width: double.infinity,
        height: 55,
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
        ),
      ),
    );
  }
}
