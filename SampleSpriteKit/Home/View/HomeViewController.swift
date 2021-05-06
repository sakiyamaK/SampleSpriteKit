//
//  HomeView.swift
//  SampleSpriteKit
//
//  Created by  on 2021/5/4.
//

import UIKit

enum SegueButton: String, CaseIterable {
  case spritekit01

  var button: UIButton {
    let button = UIButton()
    button.setTitle(rawValue, for: .normal)
    button.setTitleColor(.systemBlue, for: .normal)
    return button
  }

  func segue(presenter: HomePresentation) {
    presenter.tap(button: self)
  }
}

protocol HomeView: AnyObject {
}

final class HomeViewController: UIViewController {

  private var presenter: HomePresentation!
  func inject(presenter: HomePresentation) {
    self.presenter = presenter
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .white
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.distribution = .fillEqually
    view.addSubview(stackView)

    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    view.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
    view.bottomAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true

    SegueButton.allCases.map { $0.button }.forEach { button in
      button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
      stackView.addArrangedSubview(button)
    }
    presenter.viewDidLoad()
  }
}

extension HomeViewController: HomeView {
}

@objc private extension HomeViewController {
  func tapButton(_ sender: UIButton) {
    guard let text = sender.titleLabel?.text else { return }
    SegueButton(rawValue: text)?.segue(presenter: presenter)
  }
}
