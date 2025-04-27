//
//  Utils.swift
//  manu
//
//  Created by Erick Valdez on 26/04/25.
//

import Foundation

struct Utils {
    static func getAppVersion() -> String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
}
