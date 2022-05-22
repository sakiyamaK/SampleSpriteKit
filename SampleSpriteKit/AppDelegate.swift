//
//  AppDelegate.swift
//  SampleSpriteKit
//
//  Created by sakiyamaK on 2021/05/06.
//

import UIKit

//MARK: - hot reload tool
extension Notification.Name {
    static let injection = Notification.Name("INJECTION_BUNDLE_NOTIFICATION")
}

extension NotificationCenter {
    func addInjectionObserver(_ observer: Any, selector: Selector, object: Any?) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: .injection, object: object)
    }
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var appPresenter: AppPresenter!

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
#if DEBUG
        Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle")?.load()
#endif

    appPresenter = AppRouter.assembleModules(window: UIWindow())
    appPresenter.didFinishLaunch()
    return true
  }
}

