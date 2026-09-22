import 'package:flutter/material.dart';
import 'package:flutter_appi_practice_wormhole/services/api_services.dart';

class PostDetails extends StatelessWidget {
  final String postId;
  final String userId;
  final String? title;
  final String? body;
  const new({
    super.key,
    required this.postId,
    required this.userId,
    this.title,
    this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(postId)),
      body: FutureBuilder(
        future: ApiServices.getSingleUser(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error'));
          } else {
            final user = snapshot.data;
            if (user == null) {
              return Center(child: Text('User not found'));
            }

            return Column(
              crossAxisAlignment: .start,
              children: [
                Image.network(
                  'https://static.vecteezy.com/system/resources/thumbnails/054/876/032/small/mirror-image-snow-capped-mountain-peaks-reflected-in-pristine-lake-free-photo.jpg',
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.broken_image_outlined),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text(
                        title ?? '',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(body ?? ''),
                      SizedBox(height: 20),
                      ListTile(
                        leading: CircleAvatar(),
                        title: Text(user.name ?? 'Unknown user'),
                        subtitle: Column(
                          crossAxisAlignment: .start,
                          children: [
                            Text(user.email ?? 'No email'),
                            Text(user.address!.city.toString()),
                            Text(user.address!.geo!.lng.toString()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
