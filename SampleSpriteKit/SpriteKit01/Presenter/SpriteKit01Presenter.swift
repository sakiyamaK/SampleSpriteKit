//
//  SpriteKit01Presentation.swift
//  SampleSpriteKit
//
//  Created by  on 2021/5/6.
//

import Foundation

protocol SpriteKit01Presentation: AnyObject {
  func viewDidLoad()
}

final class SpriteKit01Presenter {
  private weak var view: SpriteKit01View?
  private let router: SpriteKit01Wireframe
  private let interactor: SpriteKit01Usecase

  init(
    view: SpriteKit01View,
    interactor: SpriteKit01Usecase,
    router: SpriteKit01Wireframe
  ) {
    self.view = view
    self.interactor = interactor
    self.router = router
  }
}

extension SpriteKit01Presenter: SpriteKit01Presentation {
  func viewDidLoad() {
  }
}