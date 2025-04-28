//
//  MNAlertError.swift
//  manu
//
//  Created by Erick Valdez on 27/04/25.
//

import UIKit

protocol MNAlertErrorProtocol {
    func showFullScreenError(message: String)
    func showAlertError(title: String, message: String, actionMessage: String)
}

final class MNAlertError: MNAlertErrorProtocol {
    private let viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func showFullScreenError(message: String) {
        let errorFullView = MNAlertErrorFullView()
        viewController.view.addSubview(errorFullView)
    }
    
    func showAlertError(title: String, message: String, actionMessage: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionMessage, style: .default))
        viewController.present(alert, animated: true)
    }
}
