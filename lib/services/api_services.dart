import 'dart:convert';

import 'package:flutter_appi_practice_wormhole/models/posts_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static Future<List<PostsModel>?> fetchData() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body.toString());
      final postList = jsonData as List;

      return postList.map((postJson) => PostsModel.fromJson(postJson)).toList();
    } else {
      return null;
    }
  }
}
