import 'dart:convert';

import 'package:flutter_appi_practice_wormhole/models/posts_model.dart';
import 'package:flutter_appi_practice_wormhole/models/users_model.dart';
import 'package:flutter_appi_practice_wormhole/utils/config.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static Future<List<PostsModel>?> fetchData() async {
    final response = await http.get(Uri.parse(AppConfig.postsUrl));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body.toString());
      final postList = jsonData as List;

      return postList.map((postJson) => PostsModel.fromJson(postJson)).toList();
    } else {
      return null;
    }
  }

  static Future<UsersModel?> getSingleUser(String id) async {
    final response = await http.get(Uri.parse('${AppConfig.usersUrl}/$id'));

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      return UsersModel.fromJson(decoded);
    } else {
      print('Error is ${response.body}');
      return null;
    }
  }
}
