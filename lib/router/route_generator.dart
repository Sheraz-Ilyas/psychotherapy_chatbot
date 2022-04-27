// STATIC ROUTES NAME
import 'package:flutter/material.dart';
import 'package:psychotherapy_chatbot/views/chat/sos.dart';
import 'package:psychotherapy_chatbot/views/community/new_post.dart';
import 'package:psychotherapy_chatbot/models/article.dart';
import 'package:psychotherapy_chatbot/root.dart';
import 'package:psychotherapy_chatbot/views/authentication/body.dart';
import 'package:psychotherapy_chatbot/views/bottom_navigation/body.dart';
import 'package:psychotherapy_chatbot/views/bottom_navigation/chat_view.dart';
import 'package:psychotherapy_chatbot/views/bottom_navigation/explore_view.dart';
import 'package:psychotherapy_chatbot/views/explore/article_details.dart';
import 'package:psychotherapy_chatbot/views/explore/brain_training_list.dart';
import 'package:psychotherapy_chatbot/views/explore/medidation_timer.dart';
import 'package:psychotherapy_chatbot/views/explore/sleep_sounds.dart';
import 'package:psychotherapy_chatbot/views/landing_view.dart';
import 'package:psychotherapy_chatbot/views/track/journal_form_view.dart';

const String root = '/';
const String landingPage = '/landingPage';
const String authBody = '/auth-body';
const String navBody = '/nav-body';
const String explore = '/explore';
const String chatui = '/chat-ui';
const String articleDetails = '/article-details';
const String brainTrainingList = '/brain-training-list';
const String meditationTimer = '/meditation-timer';
const String sleepSounds = '/sleep-sounds';
const String addJournal = '/add-journal';
const String newPost = '/new-post';
const String sos = '/sos';

// ignore: todo
// TODO : ROUTES GENERATOR CLASS THAT CONTROLS THE FLOW OF NAVIGATION/ROUTING

class RouteGenerator {
  // FUNCTION THAT HANDLES ROUTING
  static Route<dynamic> onGeneratedRoutes(RouteSettings settings) {
    late dynamic args;
    if (settings.arguments != null) {
      args = settings.arguments as Map;
    }
    switch (settings.name) {
      case root:
        return _getPageRoute(const Root());

      case landingPage:
        return _getPageRoute(const LandingView());

      case authBody:
        return _getPageRoute(const AuthBody());

      case navBody:
        return _getPageRoute(const NavBody());

      case explore:
        return _getPageRoute(ExploreView());
      case chatui:
        return _getPageRoute(const ChatView());

      case articleDetails:
        return _getPageRoute(ArticleDetails(
          article: args['article'] as Article,
        ));

      case brainTrainingList:
        return _getPageRoute(const BrainTrainingList());

      case meditationTimer:
        return _getPageRoute(const MeditationTimer());

      case sleepSounds:
        return _getPageRoute(const SleepSounds());

      case addJournal:
        return _getPageRoute(
            JournalFormView(journal: args['editJournal'] as dynamic));

      case newPost:
        return _getPageRoute(NewPost());

      case sos:
        return _getPageRoute(const SOS());

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
