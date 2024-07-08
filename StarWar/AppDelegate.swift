//
//  AppDelegate.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 08.07.24.
//

import GoogleMobileAds

class AppDelegate: UIResponder, UIApplicationDelegate {

  func application(_ application: UIApplication,
      didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    GADMobileAds.sharedInstance().start(completionHandler: nil)

    return true
  }
}
