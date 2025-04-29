//
//  MNInfoTextView.swift
//  manu
//
//  Created by Erick Valdez on 28/04/25.
//

import UIKit

final class MNInfoTextView: UIView {
    enum State {
        case info
        case warning
        case error
    }
    
    private let iconImageView = UIImageView()
    private let messageLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        layer.cornerRadius = 8
        clipsToBounds = true
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.image = UIImage(systemName: "info.circle")
        iconImageView.tintColor = UIColor.accentLightGray
        addSubview(iconImageView)
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.numberOfLines = 0
        addSubview(messageLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            iconImageView.heightAnchor.constraint(equalToConstant: 20),
            
            messageLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12),
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    func configure(message: String, state: State, customImage: UIImage? = nil) {
        messageLabel.text = message
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1

        let attributedString = NSAttributedString(
            string: message,
            attributes: [
                .paragraphStyle: paragraphStyle
            ]
        )
        messageLabel.attributedText = attributedString
        
        if let customImage = customImage {
            iconImageView.image = customImage
        } else {
            // Si no se pasa imagen, asignar una por defecto según estado
            switch state {
            case .info:
                iconImageView.image = UIImage(systemName: "info.circle")
            case .warning:
                iconImageView.image = UIImage(systemName: "exclamationmark.triangle.fill")
            case .error:
                iconImageView.image = UIImage(systemName: "xmark.octagon.fill")
            }
        }
        
        switch state {
        case .info:
            backgroundColor = UIColor.info
            messageLabel.font = UIFont.montserratLight()
            iconImageView.tintColor = .black
            messageLabel.textColor = .black
        case .warning:
            backgroundColor = UIColor.warning
            messageLabel.font = UIFont.montserratLight()
            iconImageView.tintColor = .black
            messageLabel.textColor = .black
        case .error:
            backgroundColor = UIColor.error
            messageLabel.font = UIFont.montserratRegular()
            iconImageView.tintColor = .white
            messageLabel.textColor = .white
        }
    }
}
