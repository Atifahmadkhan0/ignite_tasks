import 'dart:async';

import 'package:dio/dio.dart';
import 'package:dummy_api_app/controller/state/posts_provider.dart';
import 'package:dummy_api_app/view/posts/posts_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class PostListScreen extends ConsumerStatefulWidget {
  const PostListScreen({super.key});

  @override
  ConsumerState<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends ConsumerState<PostListScreen> {
  List posts = [];

  void fetchPosts() async {
    try {
      var response =
          await Dio().get('https://jsonplaceholder.typicode.com/posts');
      setState(() {
        posts = response.data;
        print(posts);
      });
    } catch (e) {
      print('Error $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final postsW = ref.watch(postsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Post List Screen'),
      ),
      body: Column(
        children: [
          postsW.when(
            data: (data) => Expanded(
                child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PostDetailScreen(
                                        postData: data[index],
                                      )));
                        },
                        child: Card(
                          child: Column(
                            children: [
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('${data[index].title}'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    })),
            error: (error, stackTrace) => Text("Something went wrong$error!"),
            loading: () => Center(
              child: Column(
                children: [
                  Center(child: CircularProgressIndicator()),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
