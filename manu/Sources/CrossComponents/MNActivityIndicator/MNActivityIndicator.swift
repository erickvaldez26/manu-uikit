//
//  MNActivityIndicator.swift
//  manu
//
//  Created by Erick Valdez on 5/05/25.
//

import UIKit

final class MNActivityIndicator: UIView {
    private let spinner = CAShapeLayer()
    private let rotationAnimationKey = "rotationAnimation"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSpinner()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSpinner()
    }
    
    private func setupSpinner() {
        let radius: CGFloat = 20
        let lineWidth: CGFloat = 4
        
        let circularPath = UIBezierPath(
            arcCenter: .zero,
            radius: radius,
            startAngle: 0,
            endAngle: 2 * .pi,
            clockwise: true
        )
        
        spinner.path = circularPath.cgPath
        spinner.strokeColor = UIColor.accentGray.cgColor
        spinner.lineWidth = lineWidth
        spinner.fillColor = UIColor.clear.cgColor
        spinner.lineCap = .round
        spinner.frame = CGRect(x: .zero, y: .zero, width: radius * 2, height: radius * 2)
        spinner.position = center
        
        layer.addSublayer(spinner)
    }
    
    func startAnimating() {
        spinner.isHidden = false
        
        let rotation = CABasicAnimation(keyPath: "transform.rotation")
        rotation.toValue = 2 * CGFloat.pi
        rotation.duration = 1
        rotation.repeatCount = .infinity
        
        spinner.add(rotation, forKey: rotationAnimationKey)
    }
    
    func stopAnimating() {
        spinner.removeAnimation(forKey: rotationAnimationKey)
        spinner.isHidden = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        spinner.position = CGPoint(x: bounds.midX, y: bounds.midY)
    }
}
