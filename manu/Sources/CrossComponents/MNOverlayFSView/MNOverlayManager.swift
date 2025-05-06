//
//  MNOverlayManager.swift
//  manu
//
//  Created by Erick Valdez on 5/05/25.
//

import UIKit

final class MNOverlayManager {
    static let shared = MNOverlayManager()
    
    private weak var window: UIWindow?
    
    private init() {}
    
    func configure(with window: UIWindow) {
        self.window = window
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(showOverlay(_:)),
            name: .showGlobalOverlay,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(hideOverlay),
            name: .hideGlobalOverlay,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(showLoader),
            name: .showGlobalLoader,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(hideLoader),
            name: .hideGlobalLoader,
            object: nil
        )
    }
    
    @objc private func showOverlay(_ notification: Notification) {
        DispatchQueue.main.async {
            guard let message = notification.userInfo?["message"] as? String,
                  let window = self.window else { return }
            let state = (notification.userInfo?["state"] as? MNOverlayFSView.OverlayState) ?? .serverError
            let primaryTextButton = notification.userInfo?["primaryTextButton"] as? String
            let secondaryTextButton = notification.userInfo?["secondaryTextButton"] as? String
            MNOverlayFSView.show(
                in: window,
                state: state,
                message: message,
                primaryTextButton: primaryTextButton,
                secondaryTextButton: secondaryTextButton
            )
        }
    }
    
    @objc private func hideOverlay() {
        DispatchQueue.main.async {
            MNOverlayFSView.hideOverlay()
        }
    }
    
    @objc private func showLoader(_ notification: Notification) {
        DispatchQueue.main.async {
            guard let window = self.window else { return }
            MNLoader.show(in: window)
        }
    }
    
    @objc private func hideLoader() {
        DispatchQueue.main.async {
            MNLoader.hideOverlay()
        }
    }
}
