//
//  SpriteKit01View.swift
//  SampleSpriteKit
//
//  Created by  on 2021/5/6.
//

import UIKit
import SpriteKit
import GameplayKit
import DeclarativeUIKit

protocol SpriteKit01View: AnyObject {
}

final class SpriteKit01ViewController: UIViewController {
    
    private var presenter: SpriteKit01Presentation!
    func inject(presenter: SpriteKit01Presentation) {
        self.presenter = presenter
    }
    
    override func loadView() {
        super.loadView()
        NotificationCenter.default.addInjectionObserver(self, selector: #selector(setupLayout), object: nil)
        setupLayout()
    }    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        presenter.viewDidLoad()
    }
}

@objc private extension SpriteKit01ViewController {
    func setupLayout() {
        
        self.view.backgroundColor = .white
        
        self.declarative {
            UIStackView.vertical {
                GameView()
                    .imperative {
                        let skView = $0 as! SKView
                        skView.showsFPS = true
                        skView.showsNodeCount = true
                        skView.ignoresSiblingOrder = true
                    }
//                UIView.spacer().height(200)
            }
        }
    }
}

extension SpriteKit01ViewController: SpriteKit01View {
}
