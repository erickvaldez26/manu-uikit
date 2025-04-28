//
//  MNAlertBuilder.swift
//  manu
//
//  Created by Erick Valdez on 27/04/25.
//

import UIKit

enum ErrorType {
    case fullScreen
    case alert
}

protocol MNAlertBuilderProtocol {
    func buildError(type: ErrorType, title: String, message: String, actionMessage: String, viewController: UIViewController)
}

final class MNAlertBuilder: MNAlertBuilderProtocol {
    func buildError(
        type: ErrorType,
        title: String,
        message: String,
        actionMessage: String,
        viewController: UIViewController
    ) {
        let handler = MNAlertError(viewController: viewController)
        
        switch type {
        case .fullScreen:
            handler.showFullScreenError(message: message)
        case .alert:
            handler.showAlertError(
                title: title,
                message: message,
                actionMessage: actionMessage
            )
        }
    }
}
