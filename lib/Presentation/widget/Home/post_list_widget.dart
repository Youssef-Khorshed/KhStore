import 'package:flutter/material.dart';
import 'package:store/Domain/Entities/products.dart';

class PostListWidget extends StatelessWidget {
  final List<Product> posts;
  const PostListWidget({
    Key? key,
    required this.posts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Text(posts[index].id.toString()),
          title: Text(
            posts[index].title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            posts[index].description,
            style: TextStyle(fontSize: 16),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (_) => PostDetailPage(post: posts[index]),
            //   ),
            // );
          },
        );
      },
      separatorBuilder: (context, index) => Divider(thickness: 1),
    );
  }
}
