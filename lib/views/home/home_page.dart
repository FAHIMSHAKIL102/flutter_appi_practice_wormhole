import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_appi_practice_wormhole/models/posts_model.dart';
import 'package:flutter_appi_practice_wormhole/services/api_services.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const new({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PostsModel> posts = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    final data = await ApiServices.fetchData();

    print(data!.length);
    setState(() {
      posts = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: Column(
        mainAxisAlignment: .center,
        crossAxisAlignment: .center,
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    contentPadding: EdgeInsets.all(5),
                    leading: Image.network(
                      'https://static.vecteezy.com/system/resources/thumbnails/054/876/032/small/mirror-image-snow-capped-mountain-peaks-reflected-in-pristine-lake-free-photo.jpg',
                      height: 70,
                      width: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Icon(Icons.broken_image_outlined),
                    ),
                    title: Text(
                      posts[index].title,
                      style: TextStyle(fontSize: 20),
                    ),
                    subtitle: Text(
                      posts[index].body,
                      style: TextStyle(fontSize: 15),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
