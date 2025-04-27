//
//  UILabel+Extension.swift
//  manu
//
//  Created by Erick Valdez on 26/04/25.
//

import UIKit

extension UILabel {
    convenience init(fontSize: CGFloat = 12) {
        self.init(frame: .zero)
        self.font = .montserratRegular()
    }
}
