import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../components/background.dart';
import '../../../theme/AppColors.dart';
import '../../../utils/app_text_styles.dart';
import '../controllers/new_chat_controller.dart';

class NewChatView extends GetView<NewChatController> {
  const NewChatView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primarySwatch: AppColors.primarySwatch,
        scaffoldBackgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: AppColors.white),
        appBarTheme: AppBarTheme(
            elevation: 0,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            titleTextStyle: AppTextStyle.boldPrimary20,
            iconTheme: IconThemeData(
              color: AppColors.white,
            ),
            actionsIconTheme: IconThemeData(
              color: AppColors.primary,
            )),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.primary,
            padding: EdgeInsets.symmetric(
              vertical: 15,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
      ),
      child: Background(
        isSecond: true,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
          child: Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: AppColors.primary),
              title: Text('ask_question'.tr),
              centerTitle: true,
              actions: [
                // IconButton(
                //     onPressed: () {}, icon: Icon(Icons.notifications_outlined))
              ],
            ),
            body: SingleChildScrollView(
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                SizedBox(height: 40),
                TextFormField(
                  controller: controller.teTitle,
                  onChanged: (s) => controller.validateInput(s),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 14.0),
                    filled: true,
                    suffixIcon: Icon(
                      Icons.edit,
                      size: 20,
                      color: AppColors.primary,
                    ),
                    hintText: 'title...'.tr,
                    hintStyle:
                        AppTextStyle.mediumGrey12.copyWith(color: Colors.grey),
                    fillColor: AppColors.white,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TextField(
                  controller: controller.teMessage,
                  onChanged: (s) => controller.validateInput(s),
                  minLines: 12,
                  maxLines:
                      null, // Set the number of lines to null for multiple lines
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 14.0),
                    filled: true,
                    hintText: 'your_question...'.tr,
                    hintStyle:
                        AppTextStyle.mediumGrey12.copyWith(color: Colors.grey),
                    fillColor: AppColors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 10.0,
                ),
                Obx(() => InkWell(
                      onTap: controller.inputValidated()
                          ? controller.sending()
                              ? null
                              : () {
                                  controller.sendMessage();
                                }
                          : null,
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 42.0,
                            decoration: BoxDecoration(
                              color: controller.inputValidated()
                                  ? AppColors.primary
                                  : AppColors.black,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (controller.sending())
                                    SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.white,

                                          // strokeWidth: ,
                                        ).paddingAll(0),
                                      ),
                                    ).paddingAll(4),
                                  if (!controller.sending())
                                    Text(
                                      'ask_question'.tr,
                                      style: controller.inputValidated()
                                          ? AppTextStyle.boldWhite14
                                          : AppTextStyle.boldGrey14,
                                    ),
                                ]),
                          ),
                        ],
                      ),
                    )),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80.0),
                  child: Divider(
                    height: 2,
                    color: AppColors.primary,
                  ),
                ),

                ///height for bottomBar
                const SizedBox(
                  height: 16,
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
