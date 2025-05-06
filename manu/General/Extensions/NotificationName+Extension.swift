//
//  NotificationName+Extension.swift
//  manu
//
//  Created by Erick Valdez on 5/05/25.
//

import Foundation

extension Notification.Name {
    static let showGlobalOverlay = Notification.Name("showGlobalOverlay")
    static let hideGlobalOverlay = Notification.Name("hideGlobalOverlay")
    
    static let showGlobalLoader = Notification.Name("showGlobalLoader")
    static let hideGlobalLoader = Notification.Name("hideGlobalLoader")
}
