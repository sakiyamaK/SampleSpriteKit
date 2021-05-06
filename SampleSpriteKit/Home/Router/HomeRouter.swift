//
//  HomeRouter.swift
//  SampleSpriteKit
//
//  Created by  on 2021/5/4.
//

import UIKit

protocol HomeWireframe: AnyObject {
  func showSpriteKit01()
}

final class HomeRouter {
  private unowned let viewController: UIViewController

  private init(viewController: UIViewController) {
    self.viewController = viewController
  }

  static func assembleModules() -> UIViewController {
    let view = HomeViewController()
    let interactor = HomeInteractor()
    let router = HomeRouter(viewController: view)
    let presenter = HomePresenter(
      view: view,
      interactor: interactor,
      router: router
    )
    view.inject(presenter: presenter)
    return view
  }
}

extension HomeRouter: HomeWireframe {
  func showSpriteKit01() {
    let vc = SpriteKit01Router.assembleModules()
    viewController.show(next: vc)
  }
}
