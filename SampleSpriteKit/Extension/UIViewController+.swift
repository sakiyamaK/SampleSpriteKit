//
//  UIViewController;.swift
//  SampleiOSArchitecture
//
//  Created by sakiyamaK on 2021/02/24.
//

import UIKit

extension UIViewController {
  func show(next: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
    DispatchQueue.main.async {
      if let nav = self.navigationController {
        UIView.animate(withDuration: 0) {
          nav.pushViewController(next, animated: animated)
        } completion: { _ in
          completion?()
        }
      } else {
        self.present(next, animated: animated, completion: completion)
      }
    }
  }
}
