import 'package:flutter/material.dart';
import 'package:flutter_appi_practice_wormhole/services/api_services.dart';
import 'package:flutter_appi_practice_wormhole/views/post_details/post_details.dart';

//import 'package:flutter_appi_practice_wormhole/models/posts_model.dart';

class HomePage extends StatefulWidget {
  const new({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List<PostsModel> posts = [];

  // @override
  // void initState() {
  //   super.initState();
  //   fetchData();
  // }

  // fetchData() async {
  //   final data = await ApiServices.fetchData();

  //   print(data!.length);
  //   setState(() {
  //     posts = data;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: FutureBuilder(
        future: ApiServices.fetchData(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error'));
          } else {
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PostDetails(
                            postId: snapshot.data![index].id.toString(),
                            userId: snapshot.data![index].userId.toString(),
                            title: snapshot.data![index].title.toString(),
                            body: snapshot.data![index].body.toString(),
                          ),
                        ),
                      );
                    },
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
                      snapshot.data![index].title,
                      style: TextStyle(fontSize: 20),
                    ),
                    subtitle: Text(
                      snapshot.data![index].body,
                      style: TextStyle(fontSize: 15),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
