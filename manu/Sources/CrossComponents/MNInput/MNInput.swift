//
//  MNInput.swift
//  manu
//
//  Created by Erick Valdez on 26/04/25.
//

import UIKit

class MNInput: UIView {
    private let textField = UITextField()
    private let borderColorNormal = UIColor(named: "onSurface")?.cgColor
    private let borderColorFocused = UIColor(named: "accentLightGray")?.cgColor
    private let fixedHeight: CGFloat = 45
    private let fixedWidth: CGFloat = 200
    
    public var delegate: UITextFieldDelegate? {
        get { return textField.delegate }
        set { textField.delegate = newValue }
    }
    
    public var text: String? {
        return textField.text
    }
    
    public var isSecureEntry: Bool = false {
        didSet {
            textField.isSecureTextEntry = isSecureEntry
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        backgroundColor = UIColor(named: "primaryColor")
        layer.borderColor = borderColorNormal
        layer.borderWidth = 0.9
        layer.cornerRadius = 10.0
        clipsToBounds = true
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .none
        textField.tintColor = UIColor(named: "accentLightGray")
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 12)
        textField.addTarget(self, action: #selector(editingDidBegin), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
        
        addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            heightAnchor.constraint(equalToConstant: fixedHeight),
            widthAnchor.constraint(greaterThanOrEqualToConstant: fixedWidth)
        ])
    }
    
    public func setPlaceholder(_ placeholder: String) {
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .foregroundColor: UIColor(named: "onSurface"),
                .font: UIFont.systemFont(ofSize: 12)
            ]
        )
    }
    
    @objc private func editingDidBegin() {
        layer.borderColor = borderColorFocused
    }
    
    @objc private func editingDidEnd() {
        layer.borderColor = borderColorNormal
    }
}
