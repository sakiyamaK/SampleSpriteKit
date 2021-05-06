//
//  SpriteKit01View.swift
//  SampleSpriteKit
//
//  Created by  on 2021/5/6.
//

import UIKit
import SpriteKit
import GameplayKit

protocol SpriteKit01View: AnyObject {
}

final class SpriteKit01ViewController: UIViewController {

  private var presenter: SpriteKit01Presentation!
  func inject(presenter: SpriteKit01Presentation) {
    self.presenter = presenter
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    let scene = GameScene(size: view.bounds.size)
    let skView = view as! SKView
    skView.showsFPS = true
    skView.showsNodeCount = true
    skView.ignoresSiblingOrder = true
    scene.scaleMode = .resizeFill
    skView.presentScene(scene)

    presenter.viewDidLoad()
  }
}

extension SpriteKit01ViewController: SpriteKit01View {
}
