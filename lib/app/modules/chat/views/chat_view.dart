import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/extentions/widget_exts.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:audioplayers/audioplayers.dart' as ap;
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import '../../../components/background.dart';
import '../../../theme/AppColors.dart';
import '../../../utils/app_text_styles.dart';
import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Background(
      isSecond: true,
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: PreferredSize(
            preferredSize: Size(double.infinity, 119),
            child: Container(
              height: 119,
              padding: EdgeInsets.symmetric(
                  vertical: 10.0, horizontal: Get.width * 0.05),
              color: AppColors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: AppColors.primary,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(() => Text(
                                controller.chatArg()?.chatName ?? "N/A",
                                style: AppTextStyle.boldPrimary16,
                              )),
                          const SizedBox(
                            width: 8.0,
                          ),
                          // Container(
                          //   height: 24,
                          //   padding: EdgeInsets.all(4.0),
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(5),
                          //     color:
                          //         controller.chat.value.status == Status.offline
                          //             ? AppColors.red.withOpacity(0.5)
                          //             : AppColors.green.withOpacity(0.5),
                          //   ),
                          //   alignment: Alignment.center,
                          //   child: Text(
                          //     controller.chat.value.status
                          //         .toString()
                          //         .toUpperCase(),
                          //     style: AppTextStyle.mediumPrimary12.copyWith(
                          //       color: controller.chat.value.status ==
                          //               Status.offline
                          //           ? AppColors.red
                          //           : AppColors.green,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      // controller.chat?.value?.senderImage != null
                      //     ? Container(
                      //         width: 52,
                      //         height: 52,
                      //         decoration: BoxDecoration(
                      //             shape: BoxShape.circle,
                      //             color: AppColors.primary,
                      //             image: DecorationImage(
                      //                 fit: BoxFit.cover,
                      //                 image: CachedNetworkImageProvider(
                      //                     controller.chat.value.senderImage))),
                      //       )
                      //     :
                      Container(width: 52, height: 52),
                    ],
                  ),
                ],
              ),
            ),
          ),
          body: Obx(() {
            return Column(
              children: [
                //this helps to show the loading of next page
                if (controller.nextPageLoading()) SizedBox(height: 0),
                Expanded(
                  child: controller.isLoading()
                      ? Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        )
                      : ListView.separated(
                          reverse: true,
                          controller: controller.scrollC,
                          padding: EdgeInsets.only(
                              top: 40.0,
                              left: Get.width * 0.03,
                              right: Get.width * 0.03),
                          itemBuilder: (context, index) {
                            // var msg = controller.chat.value?.messages[index];
                            var msg = controller.chat[index];
                            log("msg--------------> ${msg}");

                            return Column(
                              children: [
                                if (controller.nextPageLoading() &&
                                    index ==
                                        (controller?.chat?.length ?? 0) - 1)
                                  Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.primary,
                                    ),
                                  ).paddingExceptTop(8),
                                // if (controller.nextPageLoading() && )
                                //   Center(
                                //     child: CircularProgressIndicator(),
                                //   ).paddingAll(8),
                                // Placeholder(),
                                Row(
                                  mainAxisAlignment: msg.isUsersMessage
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 268,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 6.0, horizontal: 14.0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        color: msg.isUsersMessage
                                            ? AppColors.primary
                                            : AppColors.white,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SingleChildScrollView(
                                            physics: PageScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: [
                                                // if (msg.image != null)
                                                //   ...msg.image
                                                //       .map((e) => Stack(
                                                //             alignment:
                                                //                 Alignment.bottomRight,
                                                //             children: [
                                                //               Image.memory(
                                                //                 base64Decode(e),
                                                //                 width: (268 -
                                                //                         (Get.width *
                                                //                             0.07))
                                                //                     .toDouble(),
                                                //                 height: 250,
                                                //                 fit: BoxFit.cover,
                                                //               ),
                                                //               Container(
                                                //                 padding:
                                                //                     const EdgeInsets
                                                //                         .all(10.0),
                                                //                 margin: const EdgeInsets
                                                //                     .all(5.0),
                                                //                 decoration: BoxDecoration(
                                                //                     borderRadius:
                                                //                         BorderRadius
                                                //                             .circular(
                                                //                                 5),
                                                //                     color: AppColors
                                                //                         .primary
                                                //                         .withOpacity(
                                                //                             0.5)),
                                                //                 child: Text(
                                                //                   "${msg.image.indexOf(e) + 1}/${msg.image.length}",
                                                //                   style: AppTextStyle
                                                //                       .boldWhite12,
                                                //                 ),
                                                //               )
                                                //             ],
                                                //           ))
                                                //       .toList(),
                                              ],
                                            ),
                                          ),
                                          if (msg.sender?.name != null)
                                            Text(
                                              msg.sender?.name ?? "",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300,
                                                color: msg.isUsersMessage
                                                    ? AppColors.white
                                                    : AppColors.black,
                                              ),
                                            ).paddingOnly(bottom: 8),
                                          msg.images.isEmpty
                                              ? SizedBox()
                                              : msg.images[0]
                                                      .toString()
                                                      .isPDFFileName
                                                  ? GestureDetector(
                                                      onTap: () {
                                                        openFile(
                                                            "${ApiConsts.hostUrl}${msg.images[0]}");
                                                      },
                                                      child: Center(
                                                        child: Icon(
                                                          Icons.picture_as_pdf,
                                                          size: 60,
                                                        ),
                                                      ),
                                                    )
                                                  : msg.images[0]
                                                              .toString()
                                                              .split("/")
                                                              .last
                                                              .split('.')
                                                              .last ==
                                                          "wav"
                                                      ? GetBuilder<
                                                          ChatController>(
                                                          builder:
                                                              (controller) {
                                                            return controller
                                                                        .selectedIndex ==
                                                                    index
                                                                ? Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            if (controller.audioPlayer1.state ==
                                                                                ap.PlayerState.playing) {
                                                                              controller.isPause1 = true;
                                                                              controller.update();

                                                                              // stop2();
                                                                              controller.audioPlayer1.pause();
                                                                            } else if (controller.audioPlayer1.state == ap.PlayerState.paused || controller.audioPlayer1.state == ap.PlayerState.stopped) {
                                                                              controller
                                                                                  .play1(
                                                                                path: "${ApiConsts.hostUrl}${msg.images[0]}",
                                                                              )
                                                                                  .then((value) {
                                                                                controller.isPause1 = false;
                                                                                controller.update();
                                                                                controller.timers1 = Timer.periodic(Duration(milliseconds: controller.duration1.inMilliseconds.round() ~/ controller.voiceTrackRowSize), (timer) {
                                                                                  log('{timer.tick}${timer.tick}');

                                                                                  if (controller.isPause1 == true) {
                                                                                    // current2 = current2 + 0;
                                                                                    controller.current1 = controller.current1 + 0;
                                                                                    // current2 = -1;
                                                                                    timer.cancel();
                                                                                  } else {
                                                                                    controller.current1++;
                                                                                  }
                                                                                  controller.update();
                                                                                  log('current ${controller.current1}');

                                                                                  if (controller.current1 == controller.voiceTrackRowSize) {
                                                                                    timer.cancel();

                                                                                    controller.isPause1 = false;
                                                                                    controller.update();
                                                                                    controller.current1 = -1;
                                                                                    controller.update();
                                                                                  }
                                                                                });
                                                                              });
                                                                            }
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                Get.height * 0.05,
                                                                            width:
                                                                                Get.height * 0.05,
                                                                            decoration:
                                                                                BoxDecoration(border: Border.all(color: AppColors.primary, width: 2), shape: BoxShape.circle),
                                                                            child:
                                                                                Icon(controller.audioPlayer1.state == ap.PlayerState.playing ? Icons.pause : Icons.play_arrow, color: AppColors.primary),
                                                                          ),
                                                                        ),
                                                                        ...List.generate(
                                                                            controller.hi.length,
                                                                            (index1) {
                                                                          return Row(
                                                                            children: [
                                                                              SizedBox(
                                                                                width: Get.width * 0.003,
                                                                              ),
                                                                              AnimatedContainer(
                                                                                duration: Duration(milliseconds: 500),
                                                                                height: controller.hi[index1].toDouble(),
                                                                                width: Get.width * 0.007,
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(10),
                                                                                  color: index1 > controller.current1 ? Colors.grey : AppColors.primary,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          );
                                                                        }),
                                                                      ])
                                                                : Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () async {
                                                                            controller.selectedIndex =
                                                                                index;
                                                                            controller.current1 =
                                                                                -1;
                                                                            controller.voiceTrackRowSize =
                                                                                controller.hi.length;
                                                                            controller.audioPlayer1.pause();
                                                                            controller.audioPlayer1.stop();

                                                                            controller.isPause1 =
                                                                                false;
                                                                            controller.update();
                                                                            if (controller.audioPlayer1.state ==
                                                                                ap.PlayerState.playing) {
                                                                              controller.isPause1 = true;
                                                                              controller.update();

                                                                              // stop2();
                                                                              controller.audioPlayer1.pause();
                                                                            } else if (controller.audioPlayer1.state == ap.PlayerState.paused || controller.audioPlayer1.state == ap.PlayerState.stopped) {
                                                                              controller
                                                                                  .play1(
                                                                                path: "${ApiConsts.hostUrl}${msg.images[0]}",
                                                                              )
                                                                                  .then((value) {
                                                                                controller.isPause1 = false;
                                                                                controller.update();
                                                                                controller.timers1 = Timer.periodic(Duration(milliseconds: controller.duration1.inMilliseconds.round() ~/ controller.voiceTrackRowSize), (timer) {
                                                                                  log('{timer.tick}${timer.tick}');

                                                                                  if (controller.isPause1 == true) {
                                                                                    // current2 = current2 + 0;
                                                                                    controller.current1 = controller.current1 + 0;
                                                                                    // current2 = -1;
                                                                                    timer.cancel();
                                                                                  } else {
                                                                                    controller.current1++;
                                                                                  }
                                                                                  controller.update();
                                                                                  log('current ${controller.current1}');

                                                                                  if (controller.current1 == controller.voiceTrackRowSize) {
                                                                                    timer.cancel();

                                                                                    controller.isPause1 = false;
                                                                                    controller.update();
                                                                                    controller.current1 = -1;
                                                                                    controller.update();
                                                                                  }
                                                                                });
                                                                              });
                                                                            }
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                Get.height * 0.05,
                                                                            width:
                                                                                Get.height * 0.05,
                                                                            decoration:
                                                                                BoxDecoration(border: Border.all(color: AppColors.primary, width: 2), shape: BoxShape.circle),
                                                                            child:
                                                                                Icon(Icons.play_arrow, color: AppColors.primary),
                                                                          ),
                                                                        ),
                                                                        ...List.generate(
                                                                            controller.hi.length,
                                                                            (index1) {
                                                                          return Row(
                                                                            children: [
                                                                              SizedBox(
                                                                                width: Get.width * 0.003,
                                                                              ),
                                                                              AnimatedContainer(
                                                                                duration: Duration(milliseconds: 500),
                                                                                height: controller.hi[index1].toDouble(),
                                                                                width: Get.width * 0.007,
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(10),
                                                                                  color: Colors.grey,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          );
                                                                        }),
                                                                      ]);
                                                          },
                                                        )
                                                      : GestureDetector(
                                                          onTap: () {
                                                            openFile(
                                                                "${ApiConsts.hostUrl}${msg.images[0]}");
                                                          },
                                                          child: Center(
                                                            child:
                                                                Image.network(
                                                              "${ApiConsts.hostUrl}${msg.images[0]}",
                                                              height:
                                                                  Get.height *
                                                                      0.2,
                                                              width:
                                                                  Get.height *
                                                                      0.2,
                                                            ),
                                                          ),
                                                        ),
                                          msg.content == ""
                                              ? SizedBox()
                                              : Text(
                                                  msg.content,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w300,
                                                    color: msg.isUsersMessage
                                                        ? AppColors.white
                                                        : AppColors.black,
                                                  ),
                                                ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                DateFormat(
                                                        'dd/MM/yyyy - hh:mm a ')
                                                    .format(DateTime.now()),
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w300,
                                                  color: msg.isUsersMessage
                                                      ? AppColors.white
                                                      : AppColors.black,
                                                ),
                                              ),
                                              //   if (msg.messageStatus != null &&
                                              //       msg.isUsers) ...[
                                              //     const SizedBox(
                                              //       width: 10.0,
                                              //     ),
                                              //     Container(
                                              //       height: 16,
                                              //       width: 16,
                                              //       child: msg.messageStatus.toString() ==
                                              //               MessageStatus.seen.toString()
                                              //           ? Image.asset(
                                              //               'assets/png/doubleTick.png',
                                              //               color: AppColors.secondary,
                                              //               height: 16,
                                              //               width: 16,
                                              //             )
                                              //           : msg.messageStatus.toString() ==
                                              //                   MessageStatus.delivered
                                              //                       .toString()
                                              //               ? Image.asset(
                                              //                   'assets/png/doubleTick.png',
                                              //                   height: 16,
                                              //                   width: 16,
                                              //                   color: AppColors.white,
                                              //                 )
                                              //               : Image.asset(
                                              //                   'assets/png/singleTick.png',
                                              //                   height: 20,
                                              //                   width: 20,
                                              //                   color: AppColors.white,
                                              //                 ),
                                              //     )
                                              //   ]
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (context, i) => const SizedBox(
                                height: 22,
                              ),
                          itemCount: controller.chat.length
                          //  controller.chat.value.messages.length,

                          ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.03, vertical: 18.0),
                  child: SizedBox(
                    height: controller.attachmentString.value != ""
                        ? controller.attachmentString.value == "voice"
                            ? 110
                            : 170
                        : controller.tapAttachment.value == true
                            ? 110
                            : 65,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        controller.attachmentString.value == "image"
                            ? controller.image.isNotEmpty
                                ? Expanded(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          ...controller.image
                                              .map((element) => Stack(
                                                    children: [
                                                      Container(
                                                        width: Get.width * 0.2,
                                                        margin: const EdgeInsets
                                                                .only(
                                                            bottom: 10,
                                                            right: 10),
                                                        height: 100,
                                                        decoration:
                                                            BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: FileImage(
                                                              File(
                                                                  element.path),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          controller
                                                              .tapAttachment
                                                              .value = false;

                                                          controller
                                                              .attachmentString
                                                              .value = "";
                                                          controller.image
                                                              .remove(element);
                                                        },
                                                        child: Icon(
                                                          Icons.cancel,
                                                          color: AppColors.red,
                                                          size: 16,
                                                        ),
                                                      ),
                                                    ],
                                                  ))
                                              .toList(),
                                        ],
                                      ),
                                    ),
                                  )
                                : SizedBox()
                            : controller.attachmentString.value == "pdf"
                                ? controller.pdfFile.value == ""
                                    ? SizedBox()
                                    : Stack(
                                        children: [
                                          Container(
                                            width: Get.width * 0.2,
                                            margin: const EdgeInsets.only(
                                                bottom: 10, right: 10),
                                            height: 100,
                                            color: AppColors.grey,
                                            child: Center(
                                                child:
                                                    Icon(Icons.picture_as_pdf)),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              controller.tapAttachment.value =
                                                  false;
                                              controller.pdfFile.value = '';
                                              controller
                                                  .attachmentString.value = "";
                                            },
                                            child: Icon(
                                              Icons.cancel,
                                              color: AppColors.red,
                                              size: 16,
                                            ),
                                          ),
                                        ],
                                      )
                                : controller.attachmentString.value == "voice"
                                    ? Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              controller.playRecord.value ==
                                                      true
                                                  ? GestureDetector(
                                                      onTap: () {
                                                        controller
                                                            .stopRecording();
                                                        controller.update();
                                                      },
                                                      child: Container(
                                                        height: 45,
                                                        width: 45,
                                                        decoration:
                                                            BoxDecoration(
                                                                color: AppColors
                                                                    .primary,
                                                                shape: BoxShape
                                                                    .circle),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Icon(
                                                              Icons.stop,
                                                              color: AppColors
                                                                  .white),
                                                        ),
                                                      ),
                                                    )
                                                  : GestureDetector(
                                                      onTap: () {
                                                        controller
                                                            .startRecording();
                                                      },
                                                      child: Container(
                                                        height: 45,
                                                        width: 45,
                                                        decoration:
                                                            BoxDecoration(
                                                                color: AppColors
                                                                    .primary,
                                                                shape: BoxShape
                                                                    .circle),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Icon(Icons.mic,
                                                              color: AppColors
                                                                  .white),
                                                        ),
                                                      ),
                                                    ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              controller.playRecord.value ==
                                                      true
                                                  ? Container(
                                                      child: Center(
                                                        child: Text(
                                                          "Recording.......",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color:
                                                                  Colors.red),
                                                        ),
                                                      ),
                                                    )
                                                  : SizedBox(),
                                              Spacer(),
                                              controller.playRecord.value ==
                                                      true
                                                  ? SizedBox()
                                                  : GestureDetector(
                                                      onTap: () {
                                                        controller.playAudio
                                                                .value =
                                                            !controller
                                                                .playAudio
                                                                .value;

                                                        if (controller
                                                            .playAudio.value)
                                                          controller.playFunc();
                                                        if (!controller
                                                            .playAudio.value)
                                                          controller
                                                              .stopPlayFunc();
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        3),
                                                            color: AppColors
                                                                .primary),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      10,
                                                                  vertical: 5),
                                                          child: controller
                                                                  .playAudio
                                                                  .value
                                                              ? Text(
                                                                  "Stop Audio",
                                                                  style: AppTextStyle
                                                                      .boldWhite15,
                                                                )
                                                              : Text(
                                                                  "Play Audio",
                                                                  style: AppTextStyle
                                                                      .boldWhite15),
                                                        ),
                                                      ),
                                                    )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          )
                                        ],
                                      )
                                    : SizedBox(),
                        if (controller.tapAttachment.value == true)
                          Column(
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      controller.attachmentString.value =
                                          "voice";
                                      controller.tapAttachment.value = false;

                                      controller.startRecording();
                                    },
                                    child: Container(
                                      height: 45,
                                      width: 45,
                                      decoration: BoxDecoration(
                                          color: AppColors.primary,
                                          shape: BoxShape.circle),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(Icons.mic,
                                            color: AppColors.white),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      controller.attachmentString.value = "pdf";
                                      controller.tapAttachment.value = false;
                                      controller.pickPdf();
                                    },
                                    child: Container(
                                      height: 45,
                                      width: 45,
                                      decoration: BoxDecoration(
                                          color: AppColors.primary,
                                          shape: BoxShape.circle),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(Icons.picture_as_pdf,
                                            color: AppColors.white),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      log("tap----");
                                      controller.attachmentString.value =
                                          "image";
                                      controller.tapAttachment.value = false;
                                      controller.pickImage();
                                    },
                                    child: Container(
                                      height: 45,
                                      width: 45,
                                      decoration: BoxDecoration(
                                          color: AppColors.primary,
                                          shape: BoxShape.circle),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(Icons.photo,
                                            color: AppColors.white),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      log("tap----");
                                      controller.attachmentString.value =
                                          "image";
                                      controller.tapAttachment.value = false;
                                      controller.pickCameraImage();
                                    },
                                    child: Container(
                                      height: 45,
                                      width: 45,
                                      decoration: BoxDecoration(
                                          color: AppColors.primary,
                                          shape: BoxShape.circle),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(Icons.camera_alt_outlined,
                                            color: AppColors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        Row(
                          children: [
                            Expanded(
                                child: Container(
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                shadows: [
                                  BoxShadow(
                                    color: AppColors.grey.withOpacity(0.5),
                                    spreadRadius: 0.1,
                                    blurRadius: 5,
                                    offset: Offset(2, 6),
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                // onTap: controller.scrollToEnd,
                                controller: controller.messageC,
                                decoration: InputDecoration(
                                    prefixIcon: GestureDetector(
                                      onTap: () {
                                        controller.tapAttachment.value =
                                            !controller.tapAttachment.value;
                                        controller.pdfFile.value = '';
                                        controller.attachmentString.value = "";
                                      },
                                      child: IntrinsicWidth(
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: SvgPicture.asset(
                                            AppImages.attachment,
                                            color: AppColors.black,
                                            height: 23,
                                            width: 23,
                                          ),
                                        ),
                                      ),
                                    ),
                                    // suffixIcon: GestureDetector(
                                    //   child: Icon(
                                    //     Icons.emoji_emotions_outlined,
                                    //     color: AppColors.black,
                                    //     size: 18,
                                    //   ),
                                    // ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 14.0),
                                    hintText: 'Message',
                                    hintStyle: AppTextStyle.regularGrey16,
                                    filled: true,
                                    fillColor: AppColors.white,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(6))),
                              ),
                            )),
                            const SizedBox(
                              width: 20.0,
                            ),
                            GestureDetector(
                              onTap: (controller.isLoading.value ||
                                      controller.sendingMessage())
                                  ? null
                                  : () {
                                      if (controller.messageC.text.isNotEmpty ||
                                          controller.image.isNotEmpty ||
                                          controller.pathToAudio != null ||
                                          controller.pdfFile.value != "") {
                                        controller.messageToSend =
                                            controller.messageC.text;
                                        controller.messageC.clear();
                                        controller.sendMessage();
                                      }
                                    },
                              child: Container(
                                height: 45,
                                width: 45,
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                alignment: Alignment.center,
                                child: (controller.isLoading.value ||
                                        controller.sendingMessage())
                                    ? const CircularProgressIndicator(
                                        color: AppColors.white,
                                      )
                                    : Icon(
                                        Icons.send,
                                        color: AppColors.white,
                                      ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          })),
    );
  }

  Future<void> openFile(String fileUrl) async {
    String filePath = await downloadFile(fileUrl);

    final result = await OpenFilex.open(filePath);
    log("result.type--------------> ${result.type}");

    log("result.message--------------> ${result.message}");
  }

  Future<String> downloadFile(String fileUrl) async {
    Dio dio = Dio();
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String filePath =
          '${appDocDir.path}/${fileUrl.split('/').last}'; // Change the file extension based on the file type

      await dio.download(fileUrl, filePath);
      return filePath; // Return the local file path after download
    } catch (e) {
      print('Error downloading file: $e');
      return null;
    }
  }
}
