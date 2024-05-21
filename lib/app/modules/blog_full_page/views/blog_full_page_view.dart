import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:get/get.dart';

import '../../../components/spacialAppBar.dart';
import '../controllers/blog_full_page_controller.dart';

class BlogFullPageView extends GetView<BlogFullPageController> {
  BlogFullPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar.specialAppBar(
        controller.post?.blogTitleEnglish ?? "blog".tr,
        showLeading: false,
      ),
      body: SingleChildScrollView(
        child: Html(
          // customRender: (node, children) {
          //   return node.Container();
          // },

          data: controller.post?.descEnglish ?? "",
          //TODO fix this for english posts
          style: {
            'html': Style(textAlign: TextAlign.right),
          },
          // customTextAlign: (elem) => TextAlign.right,
        ).paddingAll(16),
      ),
    );
  }
}
