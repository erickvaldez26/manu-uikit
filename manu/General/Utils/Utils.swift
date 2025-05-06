//
//  Utils.swift
//  manu
//
//  Created by Erick Valdez on 26/04/25.
//

import Foundation
import UIKit

struct Utils {
    static func getAppVersion() -> String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
    
    static func setStyleTextButton(text: String) -> NSAttributedString {
        return NSAttributedString(
            string: text,
            attributes: [
                .font: UIFont.montserratBold(14),
                .underlineStyle: NSUnderlineStyle.single.rawValue
            ]
        )
    }
    
    static func isValidEmail(_ email: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: email)
    }
    
    static func isValidPassword(_ password: String) -> Bool {
        return password.count >= 8 && password.count <= 12
    }
}

extension Utils {
    static func notifyShowLoader() {
        NotificationCenter.default.post(
            name: .showGlobalLoader,
            object: nil
        )
    }
    
    static func notifyHideLoader() {
        NotificationCenter.default.post(
            name: .hideGlobalLoader,
            object: nil
        )
    }
    
    static func notifyShowGenericError() {
        NotificationCenter.default.post(
            name: .showGlobalOverlay,
            object: nil,
            userInfo: [
                "message": "Algo no salió como esperábamos. Estamos trabajando para solucionarlo. Por favor, intenta nuevamente en unos momentos.",
                "state": MNOverlayFSView.OverlayState.serverError,
                "primaryTextButton": "Entiendo"
            ]
        )
    }
    
    static func notifyShowNetworkError() {
        NotificationCenter.default.post(
            name: .showGlobalOverlay,
            object: nil,
            userInfo: [
                "message": "Parece que no tienes conexión a internet. Por favor, revisa tu red e inténtalo nuevamente cuando estés conectado.",
                "state": MNOverlayFSView.OverlayState.networkError,
                "primaryTextButton": "Abrir configuración"
            ]
        )
    }
    
    static func notifyHideOverlay() {
        NotificationCenter.default.post(
            name: .hideGlobalOverlay,
            object: nil
        )
    }
}
