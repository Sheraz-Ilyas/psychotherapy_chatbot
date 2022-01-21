// STATIC ROUTES NAME
import 'package:flutter/material.dart';
import 'package:psychotherapy_chatbot/views/authentication/body.dart';
import 'package:psychotherapy_chatbot/views/bottom_navigation/body.dart';
import 'package:psychotherapy_chatbot/views/bottom_navigation/chat_view.dart';
import 'package:psychotherapy_chatbot/views/bottom_navigation/explore_view.dart';
import 'package:psychotherapy_chatbot/views/landing_view.dart';

const String initialRoute = '/';
const String authBody = '/auth-body';
const String navBody = '/nav-body';
const String explore = '/explore';
const String chatui = '/chat-ui';

// ignore: todo
// TODO : ROUTES GENERATOR CLASS THAT CONTROLS THE FLOW OF NAVIGATION/ROUTING

class RouteGenerator {
  // FUNCTION THAT HANDLES ROUTING
  static Route<dynamic> onGeneratedRoutes(RouteSettings settings) {
    switch (settings.name) {
      case initialRoute:
        return _getPageRoute(const LandingView());
      case authBody:
        return _getPageRoute(const AuthBody());

      case navBody:
        return _getPageRoute(const NavBody());

      case explore:
        return _getPageRoute(ExploreView());
      case chatui:
        return _getPageRoute(const ChatView());

      default:
        return _errorRoute();
    }
  }

  // FUNCTION THAT HANDLES NAVIGATION
  static PageRoute _getPageRoute(Widget child) {
    return MaterialPageRoute(builder: (ctx) => child);
  }

  // 404 PAGE
  static PageRoute _errorRoute() {
    return MaterialPageRoute(builder: (ctx) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('404'),
        ),
        body: const Center(
          child: Text('ERROR 404: Not Found'),
        ),
      );
    });
  }
}

class IdScreen {}
