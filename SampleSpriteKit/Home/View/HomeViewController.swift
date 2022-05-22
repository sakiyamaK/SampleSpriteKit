//
//  HomeView.swift
//  SampleSpriteKit
//
//  Created by  on 2021/5/4.
//

import UIKit
import DeclarativeUIKit

enum SegueButton: String, CaseIterable {
    case spritekit01
    
    var button: UIButton {
        UIButton(rawValue)
            .titleColor(.systemBlue)
    }
    
    func segue(presenter: HomePresentation) {
        presenter.tap(button: self)
    }
}

protocol HomeView: AnyObject {
}

final class HomeViewController: UIViewController, HomeView {
    
    private var presenter: HomePresentation!
    func inject(presenter: HomePresentation) {
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

final class TestView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .blue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

@objc private extension HomeViewController {
    
    func setupLayout() {

        DLog(view)

        view = TestView()
        view.backgroundColor = .white
        
        DLog(view)
        
        self.declarative {
            UIStackView.vertical {
                UILabel("hoge")
//                SegueButton.allCases.compactMap {
//                    $0.button.add(target: self, for: .touchUpInside) {
//                        #selector(tapButton)
//                    }
//                }
                UIView.spacer()
            }
//            .alignment(.fill)
//            .distribution(.fillEqually)
        }
        
        self.declarative(safeAreas: .init(all: false), reset: false) {
            UIView.spacer().backgroundColor(.black.withAlphaComponent(0.2))
        }
    }
    
    func tapButton(_ sender: UIButton) {
        guard let text = sender.titleLabel?.text else { return }
        SegueButton(rawValue: text)?.segue(presenter: presenter)
    }
}
