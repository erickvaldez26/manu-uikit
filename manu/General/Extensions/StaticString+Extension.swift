//
//  StaticString+Extension.swift
//  manu
//
//  Created by Erick Valdez on 26/04/25.
//

extension StaticString {
    func apply() -> String {
        return String(localized: self, defaultValue: "Not found string")
    }
}
