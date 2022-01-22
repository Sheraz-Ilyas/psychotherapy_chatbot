import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:psychotherapy_chatbot/constants/colors.dart';
import 'package:psychotherapy_chatbot/constants/controllers.dart';
import 'package:psychotherapy_chatbot/views/authentication/login_view.dart';
import 'package:psychotherapy_chatbot/views/authentication/signup_view.dart';

class AuthBody extends StatelessWidget {
  const AuthBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.white));
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          Align(
            alignment: Alignment.topLeft,
            child: ElevatedButton(
              onPressed: () {
                navigationController.goBack();
              },
              child: const Padding(
                padding:
                    EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 5),
                child: Icon(Icons.arrow_back_ios),
              ),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                onPrimary: blue,
                primary: blue.withOpacity(0.1),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                )),
              ),
            ),
          ),
          Expanded(
              child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: navigationController.sheetController,
            children: const [
              SignupScreen(),
              LoginScreen(),
            ],
          ))
        ],
      ),
    );
  }
}
