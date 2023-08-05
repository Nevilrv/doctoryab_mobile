import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/blog_controller.dart';

class BlogView extends GetView<BlogController> {
  const BlogView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BlogView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'BlogView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
