import 'package:doctor_yab/app/modules/auth_phone/views/add_personal_info_screen.dart';
import 'package:doctor_yab/app/modules/auth_phone/views/auth_phone_view.dart';
import 'package:doctor_yab/app/modules/auth_phone/views/register_guest_user_screen.dart';
import 'package:doctor_yab/app/modules/book/views/confirmation_screen.dart';
import 'package:doctor_yab/app/modules/city_select/city_selection_profile_screen.dart';
import 'package:doctor_yab/app/modules/favourites/blood_donation/bindings/blood_donation_binding.dart';
import 'package:doctor_yab/app/modules/favourites/blood_donation/bindings/blood_donor_binding.dart';
import 'package:doctor_yab/app/modules/favourites/blood_donation/bindings/find_blood_donor_binding.dart';
import 'package:doctor_yab/app/modules/favourites/blood_donation/view/blood_donation_view.dart';
import 'package:doctor_yab/app/modules/favourites/blood_donation/view/blood_donor_view.dart';
import 'package:doctor_yab/app/modules/favourites/blood_donation/view/find_blood_donor_view.dart';
import 'package:doctor_yab/app/modules/favourites/checkup_packages/bindings/checkup_packages_binding.dart';
import 'package:doctor_yab/app/modules/favourites/checkup_packages/views/checkup_packages_view.dart';
import 'package:doctor_yab/app/modules/favourites/disease_treatment/bindings/disease_details_binding.dart';
import 'package:doctor_yab/app/modules/favourites/disease_treatment/bindings/disease_sub_details_binding.dart';
import 'package:doctor_yab/app/modules/favourites/disease_treatment/bindings/disease_treatment_binding.dart';
import 'package:doctor_yab/app/modules/favourites/disease_treatment/view/disease_details_view.dart';
import 'package:doctor_yab/app/modules/favourites/disease_treatment/view/disease_sub_details_view.dart';
import 'package:doctor_yab/app/modules/favourites/disease_treatment/view/disease_treatment_view.dart';
import 'package:doctor_yab/app/modules/favourites/drug_database/bindings/drug_details_binding.dart';
import 'package:doctor_yab/app/modules/favourites/drug_database/bindings/drugs_database_binding.dart';
import 'package:doctor_yab/app/modules/favourites/drug_database/bindings/saved_drugs_binding.dart';
import 'package:doctor_yab/app/modules/favourites/drug_database/view/drug_details_view.dart';
import 'package:doctor_yab/app/modules/favourites/drug_database/view/drugs_database_view.dart';
import 'package:doctor_yab/app/modules/favourites/drug_database/view/saved_drugs_view.dart';
import 'package:doctor_yab/app/modules/favourites/pregnancy_tracker/bindings/pregnancy_tracker_binding.dart';
import 'package:doctor_yab/app/modules/favourites/pregnancy_tracker/views/pregnancy_tracker_view.dart';
import 'package:doctor_yab/app/modules/favourites/treatment_abroad/bindings/treatment_abroad_binding.dart';
import 'package:doctor_yab/app/modules/favourites/treatment_abroad/views/treatment_abroad_view.dart';
import 'package:doctor_yab/app/modules/home/views/blog/comment_blog_screen.dart';
import 'package:doctor_yab/app/modules/home/views/profile/appointment_history_screen.dart';
import 'package:doctor_yab/app/modules/home/views/profile/complaint_screen.dart';
import 'package:doctor_yab/app/modules/home/views/profile/my_doctor_screen.dart';
import 'package:doctor_yab/app/modules/home/views/profile/suggestion_screen.dart';
import 'package:doctor_yab/app/modules/home/views/profile/tab_docs_view.dart';
import 'package:doctor_yab/app/modules/home/views/tab_search_view.dart';
import 'package:doctor_yab/app/modules/review/binding/review_binding.dart';
import 'package:doctor_yab/app/modules/review/view/review_screen.dart';
import 'package:get/get.dart';

import '../modules/APP_STORY/bindings/app_story_binding.dart';
import '../modules/APP_STORY/views/app_story_view.dart';
import '../modules/auth_otp/bindings/auth_otp_binding.dart';
import '../modules/auth_otp/views/auth_otp_view.dart';
import '../modules/auth_phone/bindings/auth_phone_binding.dart';
import '../modules/auth_phone/views/auth_option_view.dart';
import '../modules/blog/bindings/blog_binding.dart';
import '../modules/blog/views/blog_view.dart';
import '../modules/blog_full_page/bindings/blog_full_page_binding.dart';
import '../modules/blog_full_page/views/blog_full_page_view.dart';
import '../modules/blood_donors_results/bindings/blood_donors_results_binding.dart';
import '../modules/blood_donors_results/views/blood_donors_results_view.dart';
import '../modules/book/bindings/book_binding.dart';
import '../modules/book/views/book_view.dart';
import '../modules/chat/bindings/chat_binding.dart';
import '../modules/chat/views/chat_view.dart';
import '../modules/city_select/bindings/city_select_binding.dart';
import '../modules/city_select/views/city_select_view.dart';
import '../modules/doctor/bindings/doctor_binding.dart';
import '../modules/doctor/views/doctor_view.dart';
import '../modules/doctors/bindings/doctors_binding.dart';
import '../modules/doctors/views/doctors_view.dart';
import '../modules/favourites/blood_donation/view/donor_list_screen.dart';
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
      name: _Paths.AUTH_OPTION,
      page: () => AuthView(),
      binding: AuthPhoneBinding(),
    ),
    GetPage(
      name: _Paths.AUTH_PHONE,
      page: () => AuthPhoneView(),
      binding: AuthPhoneBinding(),
    ),
    GetPage(
      name: _Paths.ADD_PERSONAL_INFO,
      page: () => AddPersonalInfoScreen(),
      binding: AuthPhoneBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER_GUEST_USER,
      page: () => RegisterGuestUserScreen(),
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
      name: _Paths.COMPLAINT,
      page: () => ComplaintScreen(),
      binding: ProfileUpdateBinding(),
    ),
    GetPage(
      name: _Paths.SUGGESTION,
      page: () => SuggestionScreen(),
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
      name: _Paths.CITY_SELECT_PROFILE,
      page: () => CitySelectProfileView(),
      binding: CitySelectBinding(),
    ),
    GetPage(
      name: _Paths.REPORT_MEDICAL,
      page: () => TabDocsView(),
      binding: HomeBinding(),
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
      name: _Paths.My_DOCTOR,
      page: () => MyDoctorsView(),
      binding: DoctorsBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_DOCTOR,
      page: () => TabSearchView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.BOOK,
      page: () => BookView(),
      binding: BookBinding(),
    ),
    GetPage(
      name: _Paths.CONFIRMATION,
      page: () => ConfirmationScreen(),
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
      name: _Paths.REVIEW,
      page: () => ReviewScreen(),
      binding: ReviewBinding(),
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
      name: _Paths.DONOR_LIST,
      page: () => const DonorListScreen(),
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
    // GetPage(
    //   name: _Paths.COMMENT_VIEW,
    //   page: () => CommentView(),
    //   binding: HomeBinding(),
    // ),
    GetPage(
      name: _Paths.APP_STORY,
      page: () => const AppStoryView(),
      binding: AppStoryBinding(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => ChatView(),
      binding: ChatBinding(),
      children: [
        GetPage(
          name: _Paths.CHAT,
          page: () => ChatView(),
          binding: ChatBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.NEW_CHAT,
      page: () => const NewChatView(),
      binding: NewChatBinding(),
    ),
    GetPage(
      name: _Paths.DRUGS_DATABASE,
      page: () => DrugsDatabaseView(),
      binding: DrugsDatabaseBinding(),
    ),
    GetPage(
      name: _Paths.SAVED_DRUGS,
      page: () => SavedDrugsView(),
      binding: SavedDrugsBinding(),
    ),
    GetPage(
      name: _Paths.DRUGS_DETAILS,
      page: () => DrugDetailsView(),
      binding: DrugDetailsBinding(),
    ),
    GetPage(
      name: _Paths.BLOOD_DONATION,
      page: () => BloodDonationView(),
      binding: BloodDonationBinding(),
    ),
    GetPage(
      name: _Paths.DISEASE_TREATMENT,
      page: () => DiseaseTreatmentView(),
      binding: DiseaseTreatmentBinding(),
    ),
    GetPage(
      name: _Paths.DISEASE_DETAILS,
      page: () => DiseaseDetailsView(),
      binding: DiseaseDetailsBinding(),
    ),
    GetPage(
      name: _Paths.DISEASE_SUB_DETAILS,
      page: () => DiseaseSubDetailsView(),
      binding: DiseaseSubDetailsBinding(),
    ),
    GetPage(
      name: _Paths.PREGNANCY_TRACKER,
      page: () => PregnancyTrackerView(),
      binding: PregnancyTrackerBinding(),
    ),
    GetPage(
      name: _Paths.CHECKUP_PACKAGES,
      page: () => CheckupPackagesView(),
      binding: CheckupPackagesBinding(),
    ),
    GetPage(
      name: _Paths.TREATMENT_ABROAD,
      page: () => TreatmentAbroadView(),
      binding: TreatmentAbroadBinding(),
    ),
    GetPage(
      name: _Paths.APPOINTMENT_HISTORY,
      page: () => AppointmentHistoryScreen(),
      binding: HomeBinding(),
    ),
  ];
}
