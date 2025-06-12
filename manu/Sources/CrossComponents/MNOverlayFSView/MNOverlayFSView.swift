//
//  MNOverlayFSView.swift
//  manu
//
//  Created by Erick Valdez on 5/05/25.
//

import UIKit

class MNOverlayFSView: UIView {
    
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var primaryButton: MNButton!
    @IBOutlet weak var secondaryLabelButton: UILabel!
    
    func configure(
        state: AppError,
        message: String,
        primaryTextButton: String?,
        secondaryTextButton: String?
    ) {
        switch state {
        case .noInternet:
            bannerImage.image = UIImage(named: "img_error_network")
        case .generic:
            bannerImage.image = UIImage(named: "img_error_server")
        case .noAuthenticated:
            break
        }
        bannerImage.contentMode = .scaleAspectFill
        messageLabel.font = .montserratRegular(14)
        messageLabel.textColor = .black
        messageLabel.text = message
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = .zero
        
        if let text = primaryTextButton {
            primaryButton.isHidden = false
            primaryButton.setCustomTitle(text)
            primaryButton.setState(.enabled)
        } else { primaryButton.isHidden = true }
        
        if let text = secondaryTextButton {
            secondaryLabelButton.isHidden = false
            let styleTextButton = Utils.setStyleTextButton(text: text)
            secondaryLabelButton.textColor = .accentGray
            secondaryLabelButton.attributedText = styleTextButton
        } else { secondaryLabelButton.isHidden = true }
    }
    
}
