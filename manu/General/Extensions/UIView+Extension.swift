//
//  UIView+Extension.swift
//  manu
//
//  Created by Erick Valdez on 29/04/25.
//

import UIKit

extension UIView {
    func hideWithAnimation(duration: TimeInterval = 0.1, completion: (() -> Void)? = nil) {
        guard !isHidden else { completion?(); return }
        
        UIView.animate(withDuration: duration, animations: {
            self.transform = CGAffineTransform(translationX: 0, y: -self.bounds.height)
            self.alpha = 0
        }, completion: { _ in
            self.isHidden = true
            self.transform = .identity
            completion?()
        })
    }
    
    func showWithAnimation(duration: TimeInterval = 0.1, completion: (() -> Void)? = nil) {
        guard isHidden else { completion?(); return }
        
        self.transform = CGAffineTransform(translationX: 0, y: -self.bounds.height)
        self.alpha = 0
        self.isHidden = false
        
        UIView.animate(withDuration: duration, animations: {
            self.transform = .identity
            self.alpha = 1
        }, completion: { _ in
            completion?()
        })
    }
}
