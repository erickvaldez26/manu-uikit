//
//  MNLoader.swift
//  manu
//
//  Created by Erick Valdez on 5/05/25.
//

import UIKit

class MNLoader: UIView {
    @IBOutlet weak var resourceAppImage: UIImageView!
    
    private static var currentLoader: MNLoader?
    
    static func loadFromNib() -> MNLoader {
        let nib = UINib(nibName: "MNLoader", bundle: nil)
        return nib.instantiate(withOwner: nil, options: nil).first as! MNLoader
    }
    
    private func configure() {
        resourceAppImage.layer.cornerRadius = 12
    }
    
    static func show(in view: UIView) {
        currentLoader?.removeFromSuperview()
        
        let overlay = MNLoader.loadFromNib()
        overlay.frame = view.bounds
        overlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        overlay.configure()
        view.addSubview(overlay)
        currentLoader = overlay
    }
    
    static func hideOverlay() {
        currentLoader?.dismissSelf()
        currentLoader = nil
    }
    
    @objc private func dismissSelf() {
        UIView.animate(withDuration: 0.1, animations: {
            self.alpha = 0
        }) { _ in
            self.removeFromSuperview()
        }
    }
}
