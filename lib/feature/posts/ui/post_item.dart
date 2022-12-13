import 'package:client_it_product/feature/posts/domain/entity/post/post_entity.dart';
import 'package:client_it_product/feature/posts/ui/detail_post_screen.dart';
import 'package:flutter/material.dart';

class PostItem extends StatelessWidget {
  const PostItem({Key? key, required this.postEntity}) : super(key: key);

  final PostEntity postEntity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => DetailPostScreen(id: postEntity.id.toString())
        ));
      },
      child: Card(
        color: Colors.white,
        child: Column(
          children: [
            Text(postEntity.name),
            Text(postEntity.preContent ?? ""),
            Text("author: ${postEntity.author?.id ?? ""}")
          ],
        ),
      ),
    );
  }
}
