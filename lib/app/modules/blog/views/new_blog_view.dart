import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:flutter/material.dart';

class NewBlogView extends StatefulWidget {
  const NewBlogView({Key? key}) : super(key: key);

  @override
  State<NewBlogView> createState() => _NewBlogViewState();
}

class _NewBlogViewState extends State<NewBlogView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 130,
            width: MediaQuery.of(context).size.width,
            color: AppColors.primary,
          )
        ],
      ),
    );
  }
}
