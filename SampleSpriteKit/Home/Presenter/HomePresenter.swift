//
//  HomePresentation.swift
//  SampleSpriteKit
//
//  Created by  on 2021/5/4.
//

import Foundation

protocol HomePresentation: AnyObject {
  func viewDidLoad()
  func tap(button: SegueButton)
}

final class HomePresenter {
  private weak var view: HomeView?
  private let router: HomeWireframe
  private let interactor: HomeUsecase

  init(
    view: HomeView,
    interactor: HomeUsecase,
    router: HomeWireframe
  ) {
    self.view = view
    self.interactor = interactor
    self.router = router
  }
}

extension HomePresenter: HomePresentation {
  func viewDidLoad() {
  }

  func tap(button: SegueButton) {
    switch button {
    case .spritekit01:
      router.showSpriteKit01()
    }
  }
}
