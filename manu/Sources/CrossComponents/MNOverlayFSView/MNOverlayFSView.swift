//
//  MNOverlayFSView.swift
//  manu
//
//  Created by Erick Valdez on 5/05/25.
//

import UIKit

class MNOverlayFSView: UIView {
    enum OverlayState {
        case networkError
        case serverError
    }
    
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var primaryButton: MNButton!
    @IBOutlet weak var secondaryLabelButton: UILabel!
    
    private static var currentOverlay: MNOverlayFSView?
    
    static func loadFromNib() -> MNOverlayFSView {
        let nib = UINib(nibName: "MNOverlayFSView", bundle: nil)
        return nib.instantiate(withOwner: nil, options: nil).first as! MNOverlayFSView
    }
    
    private func configure(
        state: OverlayState,
        message: String,
        primaryTextButton: String?,
        secondaryTextButton: String?
    ) {
        switch state {
        case .networkError:
            bannerImage.image = UIImage(named: "img_error_network")
        case .serverError:
            bannerImage.image = UIImage(named: "img_error_server")
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
    
    static func show(
        in view: UIView,
        state: OverlayState = .networkError,
        message: String,
        primaryTextButton: String? = nil,
        secondaryTextButton: String? = nil
    ) {
        currentOverlay?.removeFromSuperview()
        
        let overlay = MNOverlayFSView.loadFromNib()
        overlay.frame = view.bounds
        overlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        overlay.configure(
            state: state,
            message: message,
            primaryTextButton: primaryTextButton,
            secondaryTextButton: secondaryTextButton
        )
        view.addSubview(overlay)
        currentOverlay = overlay
    }
    
    static func hideOverlay() {
        currentOverlay?.dismissSelf()
        currentOverlay = nil
    }
    
    @objc private func dismissSelf() {
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0
        }) { _ in
            self.removeFromSuperview()
        }
    }
}
