//
//  IrishPokerApp.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/11/23.
//
//
//import SwiftUI
//
//@main
//struct RideTheBusApp: App {
//    var body: some Scene {
//        WindowGroup {
//            MainView(settings: SetupViewModel())
//        }
//    }
//}
//
import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct YourApp: App {
  // register app delegate for Firebase setup
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

  var body: some Scene {
    WindowGroup {
        MainView(settings: SetupViewModel())
    }
  }
}
