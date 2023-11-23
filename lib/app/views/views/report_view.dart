import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/components/doctor_list_tile_item.dart';
import 'package:doctor_yab/app/components/spacialAppBar.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/data/models/doctors_model.dart';
import 'package:doctor_yab/app/services/DioService.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:doctor_yab/app/extentions/widget_exts.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:doctor_yab/app/data/models/reports.dart';

// import 'package:path_provider_ex/path_provider_ex.dart';
import 'package:permission_handler/permission_handler.dart';

class ReportView extends StatelessWidget {
  final Report report;
  const ReportView(
    this.report,
  );
  @override
  Widget build(BuildContext context) {
    print(report.toJson());
    return Scaffold(
      appBar: AppAppBar.specialAppBar("report".tr),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (report.doctor.length > 0)
              // DoctorListTileItem(report?.doctor[0] ?? Doctor()),
              //
              SizedBox(height: 20),
            // _buildSection(
            //   "patient_info".tr,
            //   [
            //     {"pat_id".tr: '${report.patientId}'},
            //     {"pat_name".tr: '${report.name}'},
            //     {"pat_phone".tr: '${report.phone}'},
            //     // {"pat_age".tr: '${report.age}'},
            //   ],
            // ),
            // _buildSection(
            //   "patient_info".tr,
            //   [
            //     // {"pat_id".tr: '${report.patientId}'},
            //     // {"pat_name".tr: '${report.name}'},
            //     // {"pat_phone".tr: '${report.phone}'},
            //     // {"pat_age".tr: '${report.age}'},
            //   ],
            // ),
            Text(
              "title".tr + ": " + report.title ?? "",
              style: AppTextTheme.b(20),
              textAlign: TextAlign.center,
            ),
            Divider(),
            SizedBox(height: 15),
            Text(
              "decription".tr + ": " + report.description ?? "",
              style: AppTextTheme.r(14),
            ),

            if (report.documents.length > 0) _buildAttachments(report),
            Row(
              children: [],
            )
          ],
        ).paddingHorizontal(20),
      ),
    );
  }

  Widget _buildAttachments(Report report) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30),
        Text(
          "attachments".tr,
          style: AppTextTheme.b(20),
          textAlign: TextAlign.center,
        ),
        Divider(),
        SizedBox(height: 15),
      ]..addAll(() {
          return report.documents.map<Widget>((e) {
            return _buildAttachmentRow(e).paddingOnly(bottom: 20);
          }).toList();
        }()),
    );
  }

  Widget _buildAttachmentRow(String document) {
    var isDownloading = false.obs;
    var downloadProgress = 0.0.obs;
    var hasErrorOccredWhileDownloading = false.obs;
    var isFileDownloaded = false.obs;
    var filePath = "";
    //
    //
    if (GetPlatform.isIOS) {
      getApplicationDocumentsDirectory().then((value) {
        var _filePath = "${value.path}/DoctorYab/$document";
        File(_filePath).exists().then((value) {
          if (value) {
            isDownloading(true);
            isFileDownloaded(true);

            filePath = _filePath;
          }
        });
      });
    } else
      getExternalStorageDirectory().then((value) {
        var _filePath = "${value.path}/DoctorYab$document";
        print("file_path " + _filePath);
        File(_filePath).exists().then((value) {
          if (value) {
            isDownloading(true);
            isFileDownloaded(true);

            filePath = _filePath;
          }
        });
        // return null;
      }).catchError((e, s) {
        FirebaseCrashlytics.instance.recordError(e, s);
      });

    _resetAll() {
      isDownloading(false);
      downloadProgress(0.0);
      hasErrorOccredWhileDownloading(false);
      isFileDownloaded(false);
    }

    debugPrint("sdfsdf");
    log((TextPainter(
            text: TextSpan(
              text: "text dfdsdf werwer",
            ),
            maxLines: 1,
            textScaleFactor: MediaQuery.of(Get.context).textScaleFactor,
            textDirection: TextDirection.ltr)
          ..layout())
        .size
        .toString());
    return Row(
      children: [
        Image.asset(
          "assets/png/file.png",
          height: 50,
          width: 50,
        ),
        SizedBox(width: 20),
        Expanded(
          child: () {
            return LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                var size = (TextPainter(
                        text: TextSpan(
                          text: document.split("/").last ?? "",
                        ),
                        maxLines: 1,
                        textScaleFactor:
                            MediaQuery.of(Get.context).textScaleFactor,
                        textDirection: TextDirection.ltr)
                      ..layout())
                    .size;
                var _text = Text(
                  size.width > constraints.maxWidth
                      ? () {
                          //Ya roh qudqudas :-()
                          var startSubstr = constraints.maxWidth /
                              (size.width /
                                  (document.split("/").last ?? "").length);
                          return "..." +
                              (document.split("/").last ?? "").substring(
                                  (document.split("/").last ?? "").length -
                                      startSubstr.toInt() +
                                      3);
                        }()
                      : (document.split("/").last ?? ""),
                  // overflow: TextOverflow.clip,
                  // softWrap: false,
                  // maxLines: 1,
                  textDirection: TextDirection.ltr,
                );
                return _text;
              },
            );
          }(),
        ),
        SizedBox(width: 20),
        Obx(
          () {
            _actionDownload() async {
              _download() {
                isDownloading(true);
                _downloadFile(document, onProgress: (d) {
                  downloadProgress(d / 100);
                }, filePath: (str) {
                  filePath = str;
                }).then((value) {
                  isFileDownloaded(true);
                }).catchError((e, s) {
                  hasErrorOccredWhileDownloading(true);
                  downloadProgress(0.0);
                  throw e;
                });
              }

              if (await Permission.storage.isGranted) {
                _download();
              } else {
                var st = await Permission.storage.request().isGranted;
                if (!st)
                  ScaffoldMessenger.of(Get.context).showSnackBar(
                      SnackBar(content: Text("no storage permission granted")));
                else
                  _download();
              }
            }

            return !isDownloading()
                ? IconButton(
                    icon: Icon(SimpleLineIcons.cloud_download),
                    onPressed: () => _actionDownload())
                : hasErrorOccredWhileDownloading()
                    ? OutlinedButton.icon(
                        onPressed: () {
                          _resetAll();
                          _actionDownload();
                        },
                        icon: Icon(
                          AntDesign.reload1,
                          size: 15,
                        ),
                        label: Text("retry".tr))
                    : isFileDownloaded()
                        ? OutlinedButton(
                            onPressed: () {
                              OpenFilex.open(filePath);
                            },
                            child: Text("open".tr))
                        : IconButton(
                            icon: Stack(
                              alignment: Alignment.center,
                              children: [
                                CircularProgressIndicator(
                                  value: downloadProgress(),
                                ),
                                Icon(
                                  Icons.close,
                                  size: 15,
                                ),
                              ],
                            ),
                            onPressed: () {},
                          );
          },
        ),
        // Spacer(),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [],
        )
      ],
    );
  }

  Future<void> _downloadFile(
    String file, {
    @required void filePath(String str),
    void onProgress(double d),
  }) async {
    Dio _dio = AppDioService.getDioInstance();
    _dio.options..receiveTimeout = 50000;

    String storagePath;

    if (GetPlatform.isIOS) {
      var _storageInfo = await getApplicationDocumentsDirectory();
      storagePath = _storageInfo.path;
    } else {
      var _storageInfo = await getExternalStorageDirectory();
      storagePath = _storageInfo.path;
    }

    log(storagePath);
    var _filePath = "$storagePath/DoctorYab/$file";
    if (filePath != null) filePath(_filePath);
    await _dio.download(
      ApiConsts.hostUrl + file,
      _filePath,
      onReceiveProgress: (received, total) {
        if (total != -1) {
          print((received / total * 100).toStringAsFixed(0) + "%");
          if (onProgress != null) onProgress(received / total * 100);
        }
      },
    );
  }
}
