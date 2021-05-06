//
//  AppDelegate.swift
//  SampleSpriteKit
//
//  Created by sakiyamaK on 2021/05/06.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var appPresenter: AppPresenter!

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    appPresenter = AppRouter.assembleModules(window: UIWindow())
    appPresenter.didFinishLaunch()
    return true
  }
}

