import 'package:doctor_yab/app/data/models/chat_list_api_model.dart';
import 'package:flutter/material.dart';

import '../controllers/settings_controller.dart';
import '../theme/AppColors.dart';
import '../utils/app_text_styles.dart';

class MessageTile extends StatelessWidget {
  const MessageTile({
    Key key,
    @required this.chat,
    this.onTap,
  }) : super(key: key);
  final ChatListApiModel chat;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: AppColors.white),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(500),
                child: Container(
                  height: 52.0,
                  width: 52.0,
                  decoration: BoxDecoration(
                    // shape: BoxShape.circle,
                    color: AppColors.primary,
                  ),
                  alignment: Alignment.center,
                  child:
                      // chat.latestMessage.sender.photo != null
                      //     ? CachedNetworkImage(
                      //         height: double.infinity,
                      //         width: double.infinity,
                      //         imageUrl: chat.latestMessage.sender.photo,
                      //         fit: BoxFit.cover,
                      //       )
                      //     :
                      Icon(Icons.message_outlined),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chat.chatName != null ? chat.chatName : "N/A",
                    style: AppTextStyle.regularBlack12,
                  ),
                  chat.latestMessage == null
                      ? SizedBox()
                      : chat.latestMessage.content != null && chat.latestMessage.content.isNotEmpty
                          ? Text(
                              () {
                                var str =
                                    "${chat.latestMessage.sender != null && chat.latestMessage.sender.patientId == SettingsController.savedUserProfile.patientID ? 'You: ' : ""}"
                                    "${chat.latestMessage.content}";
                                if (str.length > 25) str = str.substring(0, 25) + " ...";
                                return "$str";
                              }()

                              // ${chat.messages.first.image != null && chat.messages.first.image.isNotEmpty ? "📸 Image" : chat.messages.first.message}
                              // ",
                              ,
                              style: AppTextStyle.regularGrey12,
                              overflow: TextOverflow.ellipsis,
                            )
                          : SizedBox()
                  // if (chat.latestMessage.content != null && chat.latestMessage.content.isNotEmpty)
                  //   Text(
                  //     () {
                  //       var str =
                  //           "${chat.latestMessage.sender != null && chat.latestMessage.sender.patientId == SettingsController.savedUserProfile.patientID ? 'You: ' : ""}"
                  //           "${chat.latestMessage.content}";
                  //       if (str.length > 25) str = str.substring(0, 25) + " ...";
                  //       return "$str";
                  //     }()
                  //
                  //     // ${chat.messages.first.image != null && chat.messages.first.image.isNotEmpty ? "📸 Image" : chat.messages.first.message}
                  //     // ",
                  //     ,
                  //     style: AppTextStyle.regularGrey12,
                  //     overflow: TextOverflow.ellipsis,
                  //   ),
                ],
              )
            ],
          ),
          // if (chat.messages != null &&
          //     chat.messages.isNotEmpty &&
          //     chat.messages.first.messageStatus != null) ...[
          //   chat.messages.first.messageStatus.toString() ==
          //           MessageStatus.seen.toString()
          //       ? Image.asset(
          //           'assets/png/doubleTick.png',
          //           color: AppColors.secondary,
          //           height: 24,
          //           width: 24,
          //         )
          //       : chat.messages.first.messageStatus.toString() ==
          //               MessageStatus.delivered.toString()
          //           ? Image.asset(
          //               'assets/png/doubleTick.png',
          //               height: 24,
          //               width: 24,
          //             )
          //           : Image.asset(
          //               'assets/png/singleTick.png',
          //               height: 20,
          //               width: 20,
          //             )
          // ]
        ]),
      ),
    );
  }
}
