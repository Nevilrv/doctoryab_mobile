import UIKit
import Flutter
import GoogleMaps
import Firebase

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
  FirebaseApp.configure()
  GMSServices.provideAPIKey("AIzaSy AVUbtrhKdhW0g9imSAwXKNS4paUuZ9zLs")

   if #available(iOS 10.0, *) {
     UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
   }
  GeneratedPluginRegistrant.register(with: self)
   return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
