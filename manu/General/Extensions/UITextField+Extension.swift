//
//  UITextField+Extension.swift
//  manu
//
//  Created by Erick Valdez on 29/04/25.
//

import UIKit

extension UITextField {
    func addDoneButton(title: String = "Listo", target: Any?, action: Selector) {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: title, style: .done, target: target, action: action)
        
        toolbar.items = [flexible, doneButton]
        self.inputAccessoryView = toolbar
    }
}
