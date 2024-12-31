import 'dart:convert';
import 'package:api_app/model/post.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PostController extends GetxController {
  var posts = <Post>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchPosts();
    super.onInit();
  }

  Future<void> fetchPosts() async {
    try {
      isLoading(true);
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body) as List;
        posts.value = jsonResponse.map((post) => Post.fromJson(post)).toList();
      } else {
        throw Exception('Failed to load posts');
      }
    } finally {
      isLoading(false);
    }
  }
}
