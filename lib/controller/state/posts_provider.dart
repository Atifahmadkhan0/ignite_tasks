import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dummy_api_app/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postsProvider = FutureProvider<List<PostModel>>((ref) async {
  var response = await Dio().get('https://jsonplaceholder.typicode.com/posts');

  List<dynamic> post = response.data;

  List<PostModel> postList = post.map((e) => PostModel.fromJson(e)).toList();

  return postList;
});
