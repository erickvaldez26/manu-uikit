//
//  MNCheckBox.swift
//  manu
//
//  Created by Erick Valdez on 28/04/25.
//

import UIKit

final class MNCheckBox: UIView {
    public var onToggle: ((Bool) -> Void)?
    public var isChecked: Bool = false {
        didSet {
            updateAppearance()
        }
    }
    
    private let boxView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderColor = UIColor.accentLightGray.cgColor
        view.layer.borderWidth = 1.4
        view.layer.cornerRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    private let checkmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark.square.fill")
        imageView.contentMode = .scaleToFill
        imageView.tintColor = .black
        imageView.isHidden = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        addSubview(boxView)
        boxView.addSubview(checkmarkImageView)
        
        NSLayoutConstraint.activate([
            boxView.topAnchor.constraint(equalTo: topAnchor),
            boxView.bottomAnchor.constraint(equalTo: bottomAnchor),
            boxView.leadingAnchor.constraint(equalTo: leadingAnchor),
            boxView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            checkmarkImageView.centerXAnchor.constraint(equalTo: boxView.centerXAnchor),
            checkmarkImageView.centerYAnchor.constraint(equalTo: boxView.centerYAnchor),
            checkmarkImageView.widthAnchor.constraint(equalToConstant: self.frame.width + 3),
            checkmarkImageView.heightAnchor.constraint(equalToConstant: self.frame.height + 3)
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleCheck))
        addGestureRecognizer(tapGesture)
        
        updateAppearance()
    }
    
    @objc private func toggleCheck() {
        isChecked.toggle()
        onToggle?(isChecked)
    }
    
    private func updateAppearance() {
        if isChecked {
            checkmarkImageView.isHidden = false
        } else {
            checkmarkImageView.isHidden = true
        }
    }
}
