//
//  MNButton.swift
//  manu
//
//  Created by Erick Valdez on 26/04/25.
//

import UIKit

final class MNButton: UIButton {
    enum State {
        case loading
        case enabled
        case disabled
    }
    
    private var currentState: State = .enabled
    private var title: String?
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        layer.cornerRadius = 10.0
        titleLabel?.font = UIFont.montserratRegular(12)
        
        activityIndicator.color = .white
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        updateStyle()
    }
    
    func setState(_ state: State) {
        self.currentState = state
        updateStyle()
    }
    
    func setCustomTitle(_ title: String) {
        self.title = title
        setTitle(title, for: .normal)
    }
    
    private func updateStyle() {
        switch currentState {
        case .loading:
            isEnabled = false
            self.title = title(for: .normal)
            setTitle("", for: .normal)
            activityIndicator.startAnimating()
            backgroundColor = .accentLightGray
            setTitleColor(.white, for: .normal)
        case .enabled:
            isEnabled = true
            activityIndicator.stopAnimating()
            setTitle(self.title, for: .normal)
            backgroundColor = .accentLightGray
            setTitleColor(.white, for: .normal)
        case .disabled:
            isEnabled = false
            activityIndicator.stopAnimating()
            setTitle(self.title, for: .normal)
            backgroundColor = .onSurface
            setTitleColor(.white, for: .normal)
        }
    }
}
