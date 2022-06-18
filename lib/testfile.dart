import 'package:flutter/material.dart';

class TestFile extends StatelessWidget {
  const TestFile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test"),
      ),
      body: Container(
          color: Colors.red,
          height: MediaQuery.of(context).size.height * 0.2,
          child: Center(
            child: Text(
              "App Body",
            ),
          )),
    );
  }
}
