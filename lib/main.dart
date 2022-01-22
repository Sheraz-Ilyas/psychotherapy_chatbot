import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psychotherapy_chatbot/constants/colors.dart';
import 'package:psychotherapy_chatbot/constants/controllers.dart';
import 'package:psychotherapy_chatbot/controllers/navigation_controller.dart';
import 'package:psychotherapy_chatbot/router/route_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  // INITIALIZING IMPORTANT GET X CONTROLLERS
  Get.put(NavigationController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.grey[50],
          textTheme: const TextTheme(
            bodyText1: TextStyle(
                color: Colors.black, fontSize: 16, fontFamily: 'Facundo'),
            headline1: TextStyle(
              color: Colors.black,
              fontSize: 26,
              fontWeight: FontWeight.bold,
              fontFamily: 'Facundo',
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              onPrimary: Colors.white,
              primary: blue,
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              primary: blue,
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
              style: OutlinedButton.styleFrom(
            primary: blue,
            side: const BorderSide(color: blue),
          )),
          textSelectionTheme: const TextSelectionThemeData(cursorColor: blue),
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.transparent)),
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      defaultTransition: Transition.zoom,
      onGenerateRoute: RouteGenerator.onGeneratedRoutes,
      navigatorKey: navigationController.navigationKey,
    );
  }
}
