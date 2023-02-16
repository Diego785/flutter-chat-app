import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final IconData buttonIcon;
  final void Function()? onTap;
  MyButton(
      {required this.buttonText,
      required this.buttonColor,
      required this.buttonIcon,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      margin: EdgeInsets.only(top: 50, right: 90, left: 90),
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          buttonText,
          style: const TextStyle(
              fontSize: 20, color: Colors.white, fontStyle: FontStyle.italic),
        ),
        trailing: Icon(
          buttonIcon,
          color: Colors.white,
        ),
        onTap: onTap,
      ),
    );
  }
}
