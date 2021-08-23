//
//  UIView.swift
//  PokeInfo
//
//  Created by Bryan Andres Gomez Hernandez on 8/22/21.
//

import Foundation
import UIKit

extension UIView {
  func dropShadow(scale: Bool = true) {
    self.layer.cornerRadius = 50
    self.clipsToBounds = true
    self.layer.shadowOffset = .zero
    self.layer.shadowColor = UIColor.black.cgColor
    self.layer.borderColor = UIColor.white.cgColor
    self.layer.shadowRadius = 10
    self.layer.borderWidth = 5.0
  }
    
    func animateButtons() {
        UIView.animate(withDuration: 0.6,
            animations: {
                self.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.6) {
                    self.transform = CGAffineTransform.identity
                }
            })
    }
    func fadeTransition(_ duration:CFTimeInterval) {
            let animation = CATransition()
            animation.timingFunction = CAMediaTimingFunction(name:
                CAMediaTimingFunctionName.easeInEaseOut)
            animation.type = CATransitionType.fade
            animation.duration = duration
            layer.add(animation, forKey: CATransitionType.fade.rawValue)
        }
    
}
