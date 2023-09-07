// import UIKit
// import Flutter

// @UIApplicationMain
// @objc class AppDelegate: FlutterAppDelegate {
//   override func application(
//     _ application: UIApplication,
//     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//   ) -> Bool {
//     GeneratedPluginRegistrant.register(with: self)
//     return super.application(application, didFinishLaunchingWithOptions: launchOptions)
//   }
// }
import UIKit
import Flutter
import GoogleMaps  // Add this import

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

   let apiKey = ProcessInfo.processInfo.environment["GOOGLE_MAP_API_KEY"] ?? ""
    // TODO: Add your Google Maps API key
    GMSServices.provideAPIKey("AIzaSyCennfkYkFOpojaLBMUdwEp09w1n7mvZdQ")

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
