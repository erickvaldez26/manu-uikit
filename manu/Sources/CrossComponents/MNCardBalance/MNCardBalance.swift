//
//  MNCardBalance.swift
//  manu
//
//  Created by Erick Valdez on 30/04/25.
//

import UIKit

final class MNCardBalance: UIView {
    public private(set) var isObfuscated = true
    public var amountValue: String = "" {
        didSet {
            updateAmountLabel()
        }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Balance total"
        label.font = UIFont.montserratRegular(11)
        label.textColor = .white
        return label
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.montserratBold(24)
        label.textColor = .white
        return label
    }()
    
    private let eyeButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 18, weight: .medium)
        button.setImage(UIImage(systemName: "eye", withConfiguration: config), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = UIColor.accentGreen
        layer.cornerRadius = 16
        clipsToBounds = true
        
        addSubview(titleLabel)
        addSubview(amountLabel)
        addSubview(eyeButton)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        eyeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            amountLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            amountLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            amountLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant:  -12),
            
            eyeButton.centerYAnchor.constraint(equalTo: amountLabel.centerYAnchor),
            eyeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            eyeButton.widthAnchor.constraint(equalToConstant: 24),
            eyeButton.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        eyeButton.addTarget(self, action: #selector(toggleObfuscation), for: .touchUpInside)
    }
    
    public func setAmount(_ value: String) {
        self.amountValue = value
    }
    
    @objc public func toggleObfuscation() {
        isObfuscated.toggle()
        updateAmountLabel()
        updateIcon()
    }
    
    private func updateAmountLabel() {
        amountLabel.text = isObfuscated ? String(repeating: "*", count: max(6, amountValue.count)) : amountValue
    }
    
    private func updateIcon() {
        let config = UIImage.SymbolConfiguration(pointSize: 18, weight: .medium)
        let iconName = isObfuscated ? "eye" : "eye.slash"
        eyeButton.setImage(UIImage(systemName: iconName, withConfiguration: config), for: .normal)
    }
}
