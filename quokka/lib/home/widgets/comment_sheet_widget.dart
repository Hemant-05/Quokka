import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/post_bloc/post_bloc.dart';
import '../models/comment_model.dart';

class CommentSheet extends StatefulWidget {
  final String postId;
  final List<Comment> comments;

  CommentSheet({super.key, required this.postId, required this.comments});

  @override
  State<CommentSheet> createState() => _CommentSheetState();
}

class _CommentSheetState extends State<CommentSheet> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      // ⬇️ Push content above the keyboard
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 0.5,
        maxChildSize: 0.9,
        builder:
            (_, controller) => Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  Expanded(
                    child:
                        widget.comments.isNotEmpty
                            ? ListView.builder(
                              controller: controller,
                              itemCount: widget.comments.length,
                              itemBuilder:
                                  (_, i) => ListTile(
                                    leading: CircleAvatar(),
                                    title: Text(
                                      widget.comments[i].user!['username'],
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    subtitle: Text(
                                      widget.comments[i].content,
                                      style: TextStyle(color: Colors.black45),
                                    ),
                                    trailing: Text(
                                      '${widget.comments[i].createdAt.hour}:${widget.comments[i].createdAt.minute}',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                            )
                            : Center(
                              child: Text(
                                'No comments yet.',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              hintText: 'Add a comment...',

                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.send,color: Colors.lightBlueAccent,),
                          onPressed: () {
                            final content = _controller.text.trim();
                            if (content.isNotEmpty) {
                              context.read<PostBloc>().add(
                                CommentPost(widget.postId, content),
                              );
                              _controller.clear();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      ),
    );
  }
}
