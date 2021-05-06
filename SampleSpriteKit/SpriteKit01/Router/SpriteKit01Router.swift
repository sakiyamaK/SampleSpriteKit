//
//  SpriteKit01Router.swift
//  SampleSpriteKit
//
//  Created by  on 2021/5/6.
//

import UIKit

protocol SpriteKit01Wireframe: AnyObject {
}

final class SpriteKit01Router {
  private unowned let viewController: UIViewController

  private init(viewController: UIViewController) {
    self.viewController = viewController
  }

  static func assembleModules() -> UIViewController {
    let view = UIStoryboard.loadSpriteKit01()
    let interactor = SpriteKit01Interactor()
    let router = SpriteKit01Router(viewController: view)
    let presenter = SpriteKit01Presenter(
      view: view,
      interactor: interactor,
      router: router
    )
    view.inject(presenter: presenter)
    return view
  }
}

extension SpriteKit01Router: SpriteKit01Wireframe {
}

extension UIStoryboard {
  static func loadSpriteKit01() -> SpriteKit01ViewController {
    UIStoryboard(name: "SpriteKit01", bundle: nil).instantiateInitialViewController() as! SpriteKit01ViewController 
  }
}