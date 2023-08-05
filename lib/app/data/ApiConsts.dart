import 'package:doctor_yab/app/data/static.dart';

class ApiConsts {
  static const defaultHttpCacheAge = Duration(seconds: 1);
  static const debugModeOnRelease = false;
  static const String mapsApiKey = "AIzaSyAVUbtrhKdhW0g9imSAwXKNS4paUuZ9zLs";
  static const String apiKey =
      "zwsexdcrfvtgbhnjmk123321321312312313123123123123123lkmjnhbgvfcdxesxdrcftvgybhnujimkorewuirueioruieworuewoiruewoirqwff";

  static const int maxImageSizeLimit = 5000; //in KB after cropped

  static const String localHostUrl = "https://testserver.doctoryab.app/";
  // static const String liveHostUrl = "https://alt.daktaryabapi.xyz";
  static final String liveHostUrl = AppStatics.envVars.apiURL;
  static String hostUrl = liveHostUrl;
  static const String apiVersion = "v3";

  static final socketServerURL = "$hostUrl";

  static String get baseUrl => "$hostUrl/api/$apiVersion";
  static const String authPath = "/user";
  static const String updateImagePath = "/user/img";
  static const String cityPath = "/city";
  static const String categoriesByCityPath = "/category";
  static const String doctorsPath = "/doctor/doctors";
  static const String doctorTimeTablePath = "/schedule";
  static const String doctorBookPath = "/patient";
  static const String searchPath = "/doctor/search";
  static const String doctorsCategories = "/category";
  static const String historyPath = "/patient/history";
  static const String myDoctorsPath = "/patient/myDoctors";
  static const String checkIfNumberExistsPath = "$authPath/phone";
  static const String doctorReportsPath = "/patientReport/patientReports";
  static const String labReportsPath = '/laboratory/patientReports';
  static const String hospitalPath = '/hospital';
  static const String rateDoctor = '/patient/rate';
  static const String hospitalByCity = '/hospital/all';
  static const drugStoreByCity = "/pharmacy";
  static const labsByCity = "/lab";
  static const adsPath = "/ads";
  static const storiesPath = "/stories";
  static const hospitalCheckups = "/hospital/HcheckUp";
  static const drugStoreCheckups = "/pharmacy/checkUp";
  static const hospitalReviews = "/feedback/HFeedback";
  static const doctorsFullData = "/doctor/Userdoctor";
  //
  static const updateAndRegisterBloodDonor = "/bloodDonors/profile";
}
