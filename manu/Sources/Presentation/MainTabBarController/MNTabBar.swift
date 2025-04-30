//
//  MNTabBar.swift
//  manu
//
//  Created by Erick Valdez on 29/04/25.
//

import UIKit

final class MNTabBar: UIView {
    var onTabSelected: ((Int) -> Void)?
    
    private let stackView: UIStackView = UIStackView()
    private var buttons: [UIButton] = []
    private var selectedIndex: Int = 0
    
    private let icons = ["creditcard.and.123", "cart.badge.questionmark"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .black
        layer.cornerRadius = 62 / 2
        layer.masksToBounds = true
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 12
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            stackView.heightAnchor.constraint(equalToConstant: 52),
            stackView.widthAnchor.constraint(equalToConstant: 120)
        ])
        
        for (index, iconName) in icons.enumerated() {
            let button = UIButton(type: .system)
            button.tag = index
            button.layer.cornerRadius = 52 / 2
            button.clipsToBounds = true
            button.tintColor = .white
            let configuration = UIImage.SymbolConfiguration(pointSize: 12, weight: .regular)
            let image = UIImage(systemName: iconName, withConfiguration: configuration)
            button.setImage(image, for: .normal)
            button.addTarget(self, action: #selector(tabTapped(_:)), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                button.heightAnchor.constraint(equalToConstant: 52)
            ])
            
            buttons.append(button)
            stackView.addArrangedSubview(button)
        }
        
        updateUI()
    }
    
    @objc private func tabTapped(_ sender: UIButton) {
        selectedIndex = sender.tag
        updateUI()
        onTabSelected?(selectedIndex)
    }
    
    private func updateUI() {
        for (index, button) in buttons.enumerated() {
            if index == selectedIndex {
                button.backgroundColor = .accentGreen
                button.tintColor = .black
            } else {
                button.backgroundColor = .accentLightGray
                button.tintColor = .white
            }
        }
    }
}
