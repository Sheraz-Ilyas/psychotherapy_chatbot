import 'package:get/get.dart';
import 'package:psychotherapy_chatbot/models/community_post.dart';

class CommunityController extends GetxController {
  List<CommunityPost> communityPosts = <CommunityPost>[].obs;
  List<dynamic> helpfulPosts = <dynamic>[].obs;
  List<dynamic> readPosts = <dynamic>[].obs;
}
