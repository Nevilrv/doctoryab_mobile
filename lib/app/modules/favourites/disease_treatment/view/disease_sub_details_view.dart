import 'dart:async';
import 'dart:developer';

import 'package:doctor_yab/app/components/spacialAppBar.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/modules/favourites/disease_treatment/controller/disease_treatment_controller.dart';
import 'package:doctor_yab/app/modules/home/views/home_view.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppFonts.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart' as ap;

import '../../../../controllers/settings_controller.dart';

class DiseaseSubDetailsView extends StatefulWidget {
  DiseaseSubDetailsView({Key? key}) : super(key: key);

  @override
  State<DiseaseSubDetailsView> createState() => _DiseaseSubDetailsViewState();
}

class _DiseaseSubDetailsViewState extends State<DiseaseSubDetailsView> {
  List<int> hi = [
    20,
    30,
    15,
    25,
    35,
    20,
    30,
    15,
    25,
    35,
    20,
    30,
    15,
    25,
    35,
    20,
    30,
    15,
    25,
    35,
    20,
    30,
    15,
    25,
    35,
    20,
    30,
    15,
    25,
    35,
    20,
    30,
    15,
  ];

  final _audioPlayer1 = ap.AudioPlayer();
  final _audioPlayer2 = ap.AudioPlayer();

  StreamSubscription<void>? _playerStateChangedSubscription1;
  StreamSubscription<Duration>? _durationChangedSubscription1;
  StreamSubscription<Duration>? _positionChangedSubscription1;
  StreamSubscription<void>? _playerStateChangedSubscription2;
  StreamSubscription<Duration>? _durationChangedSubscription2;
  StreamSubscription<Duration>? _positionChangedSubscription2;
  Duration? _position1;
  Duration? _duration1;
  int current1 = -1;
  Duration? _position2;
  Duration? _duration2;
  int current2 = -1;

  int? voiceTrackRowSize;
  @override
  void initState() {
    voiceTrackRowSize = hi.length;

    _playerStateChangedSubscription1 =
        _audioPlayer1.onPlayerComplete.listen((state) async {
      await stop1();
      setState(() {});
    });
    _playerStateChangedSubscription2 =
        _audioPlayer2.onPlayerComplete.listen((state) async {
      await stop2();
      setState(() {});
    });

    _positionChangedSubscription1 = _audioPlayer1.onPositionChanged.listen(
      (position) => setState(() {
        _position1 = position;
      }),
    );
    _positionChangedSubscription2 = _audioPlayer2.onPositionChanged.listen(
      (position) => setState(() {
        _position2 = position;
      }),
    );

    _durationChangedSubscription1 = _audioPlayer1.onDurationChanged.listen(
      (duration) => setState(() {
        _duration1 = duration;

        log('_duration1_duration1>> ${_duration2!.inSeconds}');
      }),
    );
    _durationChangedSubscription2 = _audioPlayer2.onDurationChanged.listen(
      (duration) => setState(() {
        _duration2 = duration;

        log('_duration1_duration1>> ${_duration2!.inSeconds}');
      }),
    );

    super.initState();
  }

  Future<void> play1({String? path}) {
    if (path == '') {
    } else {
      print('audioPath--${path}');
      return _audioPlayer1.play(
        ap.UrlSource(path!),
      );
    }
    return _audioPlayer1.stop();
  }

  Future<void> play2({String? path}) {
    if (path == '') {
    } else {
      print('audioPath--${path}');
      return _audioPlayer2.play(
        ap.UrlSource(path!),
      );
    }
    return _audioPlayer2.stop();
  }

  Future<void> pause1() => _audioPlayer1.pause();
  Future<void> pause2() => _audioPlayer2.pause();

  Future<void> stop1() async {
    _audioPlayer1.stop();
  }

  Future<void> stop2() async {
    _audioPlayer2.stop();
  }

  int pauseVal = 0;

  bool isPause1 = false;
  bool isPause2 = false;

  Timer? timers1;
  Timer? timers2;

  @override
  void dispose() {
    _playerStateChangedSubscription1!.cancel();

    _positionChangedSubscription1!.cancel();

    _durationChangedSubscription1!.cancel();

    _audioPlayer1.dispose();

    if (timers1!.isActive) {
      timers1?.cancel();
    }
    _playerStateChangedSubscription2!.cancel();

    _positionChangedSubscription2!.cancel();

    _durationChangedSubscription2!.cancel();

    _audioPlayer2.dispose();

    if (timers2!.isActive) {
      timers2!.cancel();
    }

    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return GetBuilder<DiseaseTreatmentController>(
      builder: (controller) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.lightGrey,
              elevation: 0,
              leading: GestureDetector(
                  onTap: () {
                    _audioPlayer1.pause();
                    _audioPlayer2.pause();
                    Get.back();
                  },
                  child: RotatedBox(
                    quarterTurns:
                        SettingsController.appLanguge == "English" ? 0 : 2,
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppColors.primary,
                    ),
                  )),
              title: Container(
                child: Text(
                  SettingsController.appLanguge == "English"
                      ? controller.selectedDieases?.title ?? ''
                      : SettingsController.appLanguge == "فارسی"
                          ? controller.selectedDieases?.dariTitle ?? ''
                          : controller.selectedDieases?.pashtoTitle ?? '',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  // textWidthBasis: TextWidthBasis.longestLine,
                  style: AppTextStyle.boldPrimary16.copyWith(),
                ),
              ),
              centerTitle: true,
              // actions: [
              //   Padding(
              //     padding: const EdgeInsets.only(right: 20, left: 10),
              //     child: GestureDetector(
              //       onTap: () {
              //         Get.toNamed(Routes.NOTIFICATION);
              //       },
              //       child: SvgPicture.asset(
              //         AppImages.blackBell,
              //         height: 24,
              //         width: 24,
              //       ),
              //     ),
              //   ),
              // ],
            ),
            backgroundColor: AppColors.lightGrey,
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
              child: BottomBarView(isHomeScreen: false),
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.white,
                      ),
                      child: Column(
                        children: [
                          Text(
                            "${"listen_whole_page".tr}",
                            style: AppTextStyle.boldPrimary11,
                          ),
                          SizedBox(height: 5),
                          controller.selectedDieases?.audio == null
                              ? SizedBox()
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                      GestureDetector(
                                        onTap: () {
                                          if (_audioPlayer2.state ==
                                              ap.PlayerState.playing) {
                                            setState(() {
                                              isPause2 = true;
                                            });

                                            // stop2();
                                            _audioPlayer2.pause();
                                          }
                                          if (_audioPlayer1.state ==
                                              ap.PlayerState.playing) {
                                            setState(() {
                                              isPause1 = true;
                                            });

                                            // stop2();
                                            _audioPlayer1.pause();
                                          } else if (_audioPlayer1.state ==
                                                  ap.PlayerState.paused ||
                                              _audioPlayer1.state ==
                                                  ap.PlayerState.stopped) {
                                            log('_audioPlayer1.state ==ap.PlayerState.playing11 ');
                                            // setState(() {

                                            play1(
                                              path:
                                                  "${ApiConsts.hostUrl}${SettingsController.appLanguge == "English" ? controller.selectedDieases?.audio : SettingsController.appLanguge == "فارسی" ? controller.selectedDieases?.audioDari : controller.selectedDieases?.audioPashto}",
                                            ).then((value) {
                                              setState(() {
                                                isPause1 = false;
                                              });
                                              timers1 = Timer.periodic(
                                                  Duration(
                                                      milliseconds: _duration1!
                                                              .inMilliseconds
                                                              .round() ~/
                                                          int.parse(
                                                              voiceTrackRowSize
                                                                  .toString())),
                                                  (timer) {
                                                print(
                                                    '{timer.tick}${timer.tick}');

                                                setState(() {
                                                  if (isPause1 == true) {
                                                    // current2 = current2 + 0;
                                                    current1 = current1 + 0;
                                                    // current2 = -1;
                                                    timer.cancel();
                                                  } else {
                                                    current1++;
                                                  }

                                                  log('current $current1');
                                                });

                                                if (current1 ==
                                                    voiceTrackRowSize) {
                                                  timer.cancel();

                                                  setState(() {
                                                    isPause1 = false;
                                                  });
                                                  current1 = -1;
                                                }
                                              });
                                            });
                                          }
                                        },
                                        child: Container(
                                          height: Get.height * 0.05,
                                          width: Get.height * 0.05,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: AppColors.primary,
                                                  width: 2),
                                              shape: BoxShape.circle),
                                          child: Icon(
                                              _audioPlayer1.state ==
                                                      ap.PlayerState.playing
                                                  ? Icons.pause
                                                  : Icons.play_arrow,
                                              color: AppColors.primary),
                                        ),
                                      ),
                                      ...List.generate(hi.length, (index1) {
                                        return Row(
                                          children: [
                                            SizedBox(
                                              width: Get.width * 0.003,
                                            ),
                                            AnimatedContainer(
                                              duration:
                                                  Duration(milliseconds: 500),
                                              height: hi[index1].toDouble(),
                                              width: Get.width * 0.007,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: index1 > current1
                                                    ? Colors.grey
                                                    : AppColors.primary,
                                              ),
                                            ),
                                          ],
                                        );
                                      }),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: Get.width * 0.003),
                                        child: Text(
                                          _duration1 == null
                                              ? ""
                                              : _position1
                                                  .toString()
                                                  .split('.')
                                                  .first,
                                          style: AppTextStyle.boldPrimary14,
                                        ),
                                      ),
                                    ]),
                          // Text(
                          //   "Listen Whole Pashto Audio",
                          //   style: AppTextStyle.boldPrimary11,
                          // ),
                          // Text(
                          //   "${"listen_whole_page".tr} (${"what_is".tr} ${controller.selectedDieases.category} ?)",
                          //   style: AppTextStyle.boldPrimary11,
                          // ),
                          // controller.selectedDieases.audioPashto == null
                          //     ? SizedBox()
                          //     : Row(
                          //         mainAxisAlignment:
                          //             MainAxisAlignment.spaceBetween,
                          //         children: [
                          //             GestureDetector(
                          //               onTap: () {
                          //                 if (_audioPlayer1.state ==
                          //                     ap.PlayerState.playing) {
                          //                   setState(() {
                          //                     isPause1 = true;
                          //                   });
                          //
                          //                   // stop2();
                          //                   _audioPlayer1.pause();
                          //                 }
                          //                 if (_audioPlayer2.state ==
                          //                     ap.PlayerState.playing) {
                          //                   setState(() {
                          //                     isPause2 = true;
                          //                   });
                          //
                          //                   // stop2();
                          //                   _audioPlayer2.pause();
                          //                 } else if (_audioPlayer2.state ==
                          //                         ap.PlayerState.paused ||
                          //                     _audioPlayer2.state ==
                          //                         ap.PlayerState.stopped) {
                          //                   log('_audioPlayer1.state ==ap.PlayerState.playing11 ');
                          //                   // setState(() {
                          //
                          //                   play2(
                          //                     path:
                          //                         "${ApiConsts.hostUrl}${controller.selectedDieases.audioPashto}",
                          //                   ).then((value) {
                          //                     setState(() {
                          //                       isPause2 = false;
                          //                     });
                          //                     timers2 = Timer.periodic(
                          //                         Duration(
                          //                             milliseconds: _duration2
                          //                                     .inMilliseconds
                          //                                     .round() ~/
                          //                                 voiceTrackRowSize),
                          //                         (timer) {
                          //                       print(
                          //                           '{timer.tick}${timer.tick}');
                          //
                          //                       setState(() {
                          //                         if (isPause2 == true) {
                          //                           // current2 = current2 + 0;
                          //                           current2 = current2 + 0;
                          //                           // current2 = -1;
                          //                           timers2.cancel();
                          //                         } else {
                          //                           current2++;
                          //                         }
                          //
                          //                         log('current ${current2}');
                          //                       });
                          //
                          //                       if (current2 ==
                          //                           voiceTrackRowSize) {
                          //                         timer.cancel();
                          //
                          //                         setState(() {
                          //                           isPause2 = false;
                          //                         });
                          //                         current2 = -1;
                          //                       }
                          //                     });
                          //                   });
                          //                 }
                          //               },
                          //               child: Container(
                          //                 height: Get.height * 0.05,
                          //                 width: Get.height * 0.05,
                          //                 decoration: BoxDecoration(
                          //                     border: Border.all(
                          //                         color: AppColors.primary,
                          //                         width: 2),
                          //                     shape: BoxShape.circle),
                          //                 child: Icon(
                          //                     _audioPlayer2.state ==
                          //                             ap.PlayerState.playing
                          //                         ? Icons.pause
                          //                         : Icons.play_arrow,
                          //                     color: AppColors.primary),
                          //               ),
                          //             ),
                          //             ...List.generate(hi.length, (index1) {
                          //               return Row(
                          //                 children: [
                          //                   SizedBox(
                          //                     width: Get.width * 0.003,
                          //                   ),
                          //                   AnimatedContainer(
                          //                     duration:
                          //                         Duration(milliseconds: 500),
                          //                     height: hi[index1].toDouble(),
                          //                     width: Get.width * 0.007,
                          //                     decoration: BoxDecoration(
                          //                       borderRadius:
                          //                           BorderRadius.circular(10),
                          //                       color: index1 > current2
                          //                           ? Colors.grey
                          //                           : AppColors.primary,
                          //                     ),
                          //                   ),
                          //                 ],
                          //               );
                          //             }),
                          //             Padding(
                          //               padding: EdgeInsets.only(
                          //                   left: Get.width * 0.003),
                          //               child: Text(
                          //                 _duration2 == null
                          //                     ? ""
                          //                     : _position2
                          //                         .toString()
                          //                         .split('.')
                          //                         .first,
                          //                 style: AppTextStyle.boldPrimary14,
                          //               ),
                          //             ),
                          //           ]),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                SettingsController.appLanguge == "English"
                                    ? controller.selectedDieases?.title ?? ''
                                    : SettingsController.appLanguge == "فارسی"
                                        ? controller
                                                .selectedDieases?.dariTitle ??
                                            ''
                                        : controller
                                                .selectedDieases?.pashtoTitle ??
                                            '',
                                style: AppTextStyle.boldPrimary15,
                              ),
                            ),
                            Html(
                              data: SettingsController.appLanguge == "English"
                                  ? controller.selectedDieases?.desc ?? ""
                                  : SettingsController.appLanguge == "فارسی"
                                      ? controller.selectedDieases?.dariDesc ??
                                          ""
                                      : controller
                                              .selectedDieases?.pashtoDesc ??
                                          "",
                              style: {
                                'html': Style(
                                    textAlign: SettingsController.appLanguge ==
                                            "English"
                                        ? TextAlign.left
                                        : TextAlign.right,
                                    color: AppColors.primary,
                                    fontWeight: AppFontWeight.MEDIUM,
                                    fontSize: FontSize(12),
                                    fontFamily: AppFonts.acuminSemiCond),
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
