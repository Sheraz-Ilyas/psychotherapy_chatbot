import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextFieldBody extends StatelessWidget {
  TextFieldBody({Key? key, this.textField}) : super(key: key);

  Widget? textField;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 5,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: textField,
        ),
      ),
    );
  }
}
