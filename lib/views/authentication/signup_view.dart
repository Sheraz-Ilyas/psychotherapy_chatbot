import 'package:flutter/material.dart';
import 'package:psychotherapy_chatbot/constants/colors.dart';
import 'package:psychotherapy_chatbot/constants/controllers.dart';
import 'package:psychotherapy_chatbot/router/route_generator.dart';
import 'package:psychotherapy_chatbot/widgets/auth_button.dart';
import 'package:psychotherapy_chatbot/widgets/textfield_body.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _submit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    navigationController.navigateTo(navBody);
    if (isValid) {
      _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Signup to\nget started',
                    style: Theme.of(context).textTheme.headline1?.copyWith(
                          fontSize: 40,
                          color: blue,
                        ),
                  ),
                ),
              ],
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFieldBody(
                    textField: TextFormField(
                      controller: nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintText: 'Name',
                          hintStyle: Theme.of(context).textTheme.bodyText1),
                      textInputAction: TextInputAction.next,
                      onSaved: (value) {},
                    ),
                  ),
                  TextFieldBody(
                    textField: TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintText: 'Email Address',
                          hintStyle: Theme.of(context).textTheme.bodyText1),
                      textInputAction: TextInputAction.next,
                      onSaved: (value) {},
                    ),
                  ),
                  TextFieldBody(
                    textField: TextFormField(
                      controller: passwordController,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 8) {
                          return 'Password must be atleast 8 characters';
                        }
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintText: 'Password',
                          hintStyle: Theme.of(context).textTheme.bodyText1),
                      textInputAction: TextInputAction.done,
                      onSaved: (value) {},
                    ),
                  ),
                ],
              ),
            ),
            AuthButton(
              text: Text(
                'Signup',
                style: Theme.of(context).textTheme.headline1?.copyWith(
                      color: Colors.white,
                      fontSize: 20,
                    ),
              ),
              onClick: _submit,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Already Have An Account?',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  TextButton(
                    onPressed: () {
                      navigationController.sheetController.animateToPage(1,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.decelerate);
                    },
                    child: Text(
                      'Sign In',
                      style: Theme.of(context).textTheme.headline1?.copyWith(
                            fontSize: 18,
                            color: blue,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
