import 'package:document_manager/models/post.dart';

class PostUtil {
  static List<Post> searchPostFromImageText(
    List<Post> posts,
    String searchWord,
  ) {
    List<Post> matchedPosts = [];
    for (Post post in posts) {
      for (final imageText in post.imageTexts) {
        if (imageText.contains(searchWord)) {
          matchedPosts.add(post);
          break;
        }
      }
    }
    return matchedPosts;
  }
}
