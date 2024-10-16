import 'package:dio/dio.dart';
import 'package:dummy_api_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PostDetailScreen extends StatefulWidget {
  const PostDetailScreen({super.key, required this.postData});
  final PostModel postData;
  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Title : ${widget.postData.title!}"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Title : ${widget.postData.title!}"),
          Text("Body : ${widget.postData.body!}"),
          Text("userId : ${widget.postData.userId!}"),
          Text("id : ${widget.postData.id!}"),
        ],
      ),
    );
  }
}
