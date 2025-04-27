//
//  UIFont+Custom.swift
//  manu
//
//  Created by Erick Valdez on 26/04/25.
//

import Foundation
import UIKit

extension UIFont {
    static func montserratLight(_ size: CGFloat = 12) -> UIFont {
        return UIFont(name: "MontserratAlternates-Light", size: size) ?? UIFont.systemFont(ofSize: size, weight: .light)
    }
    
    static func montserratRegular(_ size: CGFloat = 12) -> UIFont {
        return UIFont(name: "MontserratAlternates-Regular", size: size) ?? UIFont.systemFont(ofSize: size, weight: .regular)
    }
    
    static func montserratMedium(_ size: CGFloat = 12) -> UIFont {
        return UIFont(name: "MontserratAlternates-Medium", size: size) ?? UIFont.systemFont(ofSize: size, weight: .medium)
    }
    
    static func montserratBold(_ size: CGFloat = 12) -> UIFont {
        return UIFont(name: "MontserratAlternates-Bold", size: size) ?? UIFont.systemFont(ofSize: size, weight: .bold)
    }
}
