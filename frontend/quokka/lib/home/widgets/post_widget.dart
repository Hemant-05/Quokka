import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/post_bloc/post_bloc.dart';
import '../models/full_post_model.dart';
import 'comment_sheet_widget.dart';

class PostWidget extends StatelessWidget {
  final Post post;
  final String userId;

  const PostWidget({super.key, required this.post, required this.userId});

  @override
  Widget build(BuildContext context) {
    final isLiked = post.likes.any((like) => like.userId == userId);
    print(isLiked);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
              post.author.profileImage ??
                  "https://i.pinimg.com/736x/84/b3/bd/84b3bdee2b4bc649505bcf1224c6328e.jpg",
            ),
          ),
          title: Text(post.author.username),
        ),
        Image.network(post.imageUrl!, fit: BoxFit.cover),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              IconButton(
                icon: Icon(isLiked ? Icons.favorite : Icons.favorite_border),
                onPressed: () {
                  context.read<PostBloc>().add(LikePost(post.id));
                },
              ),
              SizedBox(width: 12),
              IconButton(
                icon: Icon(Icons.comment),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder:
                        (_) => CommentSheet(
                          postId: post.id,
                          comments: post.comments,
                        ),
                  );
                },
              ),
              SizedBox(width: 12),
              Icon(Icons.share),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            '${post.likes.length} likes',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Text('${post.author.username} ${post.content}'),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'View all ${post.comments.length} comments',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
