import 'package:get/get.dart';

import '../modules/APP_STORY/bindings/app_story_binding.dart';
import '../modules/APP_STORY/views/app_story_view.dart';
import '../modules/auth_otp/bindings/auth_otp_binding.dart';
import '../modules/auth_otp/views/auth_otp_view.dart';
import '../modules/auth_phone/bindings/auth_phone_binding.dart';
import '../modules/auth_phone/views/auth_phone_view.dart';
import '../modules/blog/bindings/blog_binding.dart';
import '../modules/blog/views/blog_view.dart';
import '../modules/blog_full_page/bindings/blog_full_page_binding.dart';
import '../modules/blog_full_page/views/blog_full_page_view.dart';
import '../modules/blood_donor/bindings/blood_donor_binding.dart';
import '../modules/blood_donor/views/blood_donor_view.dart';
import '../modules/blood_donors_results/bindings/blood_donors_results_binding.dart';
import '../modules/blood_donors_results/views/blood_donors_results_view.dart';
import '../modules/book/bindings/book_binding.dart';
import '../modules/book/views/book_view.dart';
import '../modules/chat/bindings/chat_binding.dart';
import '../modules/chat/bindings/chat_binding.dart';
import '../modules/chat/views/chat_view.dart';
import '../modules/chat/views/chat_view.dart';
import '../modules/city_select/bindings/city_select_binding.dart';
import '../modules/city_select/views/city_select_view.dart';
import '../modules/doctor/bindings/doctor_binding.dart';
import '../modules/doctor/views/doctor_view.dart';
import '../modules/doctors/bindings/doctors_binding.dart';
import '../modules/doctors/views/doctors_view.dart';
import '../modules/find_blood_donor/bindings/find_blood_donor_binding.dart';
import '../modules/find_blood_donor/views/find_blood_donor_view.dart';
import '../modules/history_details/bindings/history_details_binding.dart';
import '../modules/history_details/views/history_details_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/hospital_new/bindings/hospital_new_binding.dart';
import '../modules/hospital_new/tab_main/bindings/tab_main_binding.dart';
import '../modules/hospital_new/tab_main/views/tab_main_view.dart';
import '../modules/hospital_new/views/hospital_new_view.dart';
import '../modules/intro/bindings/intro_binding.dart';
import '../modules/intro/views/intro_view.dart';
import '../modules/lang_select/bindings/lang_select_binding.dart';
import '../modules/lang_select/views/lang_select_view.dart';
import '../modules/location_picker/bindings/location_picker_binding.dart';
import '../modules/location_picker/views/location_picker_view.dart';
import '../modules/login_verify/bindings/login_verify_binding.dart';
import '../modules/login_verify/views/login_verify_view.dart';
import '../modules/new_chat/bindings/new_chat_binding.dart';
import '../modules/new_chat/views/new_chat_view.dart';
import '../modules/patient_info/bindings/patient_info_binding.dart';
import '../modules/patient_info/views/patient_info_view.dart';
import '../modules/profile_update/bindings/profile_update_binding.dart';
import '../modules/profile_update/views/profile_update_view.dart';
import '../modules/rate/bindings/rate_binding.dart';
import '../modules/rate/views/rate_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),

      // settings: RouteSettings(),
      children: [
        // GetPage(
        //   name: _Paths.TAB_HOME_OTHERS,
        //   page: () => TabHomeOthersView(),
        //   binding: TabHomeOthersBinding(),
        // ),
      ],
    ),
    GetPage(
      name: _Paths.INTRO,
      page: () => IntroView(),
      binding: IntroBinding(),
    ),
    GetPage(
      name: _Paths.LANG_SELECT,
      page: () => LangSelectView(),
      binding: LangSelectBinding(),
    ),
    GetPage(
      name: _Paths.AUTH_PHONE,
      page: () => AuthPhoneView(),
      binding: AuthPhoneBinding(),
    ),
    GetPage(
      name: _Paths.AUTH_OTP,
      page: () => AuthOtpView(),
      binding: AuthOtpBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_UPDATE,
      page: () => ProfileUpdateView(),
      binding: ProfileUpdateBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN_VERIFY,
      page: () => LoginVerifyView(),
      binding: LoginVerifyBinding(),
    ),
    GetPage(
      name: _Paths.CITY_SELECT,
      page: () => CitySelectView(),
      binding: CitySelectBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.DOCTORS,
      page: () => DoctorsView(),
      binding: DoctorsBinding(),
    ),
    GetPage(
      name: _Paths.BOOK,
      page: () => BookView(),
      binding: BookBinding(),
    ),
    GetPage(
      name: _Paths.PATIENT_INFO,
      page: () => PatientInfoView(),
      binding: PatientInfoBinding(),
    ),
    GetPage(
      name: _Paths.DOCTOR,
      page: () => DoctorView(),
      binding: DoctorBinding(),
    ),
    GetPage(
      name: _Paths.HISTORY_DETAILS,
      page: () => HistoryDetailsView(),
      binding: HistoryDetailsBinding(),
    ),
    GetPage(
      name: _Paths.RATE,
      page: () => RateView(),
      binding: RateBinding(),
    ),
    GetPage(
      name: _Paths.HOSPITAL_NEW,
      page: () => HospitalNewView(),
      binding: HospitalNewBinding(),
      children: [
        GetPage(
          name: _Paths.TAB_MAIN,
          page: () => TabMainView(),
          binding: TabMainBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.BLOOD_DONOR,
      page: () => BloodDonorView(),
      binding: BloodDonorBinding(),
    ),
    GetPage(
      name: _Paths.LOCATION_PICKER,
      page: () => const LocationPickerView(),
      binding: LocationPickerBinding(),
    ),
    GetPage(
      name: _Paths.FIND_BLOOD_DONOR,
      page: () => const FindBloodDonorView(),
      binding: FindBloodDonorBinding(),
    ),
    GetPage(
      name: _Paths.BLOOD_DONORS_RESULTS,
      page: () => const BloodDonorsResultsView(),
      binding: BloodDonorsResultsBinding(),
    ),
    GetPage(
      name: _Paths.BLOG,
      page: () => const BlogView(),
      binding: BlogBinding(),
    ),
    GetPage(
      name: _Paths.BLOG_FULL_PAGE,
      page: () => BlogFullPageView(),
      binding: BlogFullPageBinding(),
    ),
    GetPage(
      name: _Paths.APP_STORY,
      page: () => const AppStoryView(),
      binding: AppStoryBinding(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => const ChatView(),
      binding: ChatBinding(),
      children: [
        GetPage(
          name: _Paths.CHAT,
          page: () => const ChatView(),
          binding: ChatBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.NEW_CHAT,
      page: () => const NewChatView(),
      binding: NewChatBinding(),
    ),
  ];
}