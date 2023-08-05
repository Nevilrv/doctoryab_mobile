import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/modules/splash_screen/bindings/splash_screen_binding.dart';
import 'package:doctor_yab/app/services/PushNotificationService.dart';
import 'package:doctor_yab/app/theme/AppTheme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/routes/app_pages.dart';
import 'app/services/LocalizationServices.dart';
import 'app/utils/utils.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message ");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseAuth.instance.authStateChanges().listen((user) {
    print(
        'Current user id: ${user?.uid}, ${FirebaseAuth.instance.currentUser.uid}');
  });
//  await GetStorage.init();
  // Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  // Hive.init(directory.path);
  await Hive.initFlutter();
  await Utils.initApp();

  if (!ApiConsts.debugModeOnRelease) {
    // Get.put(await Hive.openBox("settings"), tag: "hive_sttings");
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    final pushNotificationService = PushNotificationService();
    pushNotificationService.initialise();

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }
  runApp(
    Phoenix(
      child: GetMaterialApp(
        defaultTransition: Transition.cupertino,
        locale: LocalizationService().locale,
        fallbackLocale: LocalizationService.fallbackLocale,
        translations: LocalizationService(),
        title: "DoctorYab",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        debugShowCheckedModeBanner: false,
        initialBinding: SplashScreenBinding(),
        theme: AppTheme.light(),
        builder: Utils.initBuilder,
        navigatorKey: Get.find(),
        onReady: () {},
      ),
    ),
  );
  Utils.configEasyLoading();
}
