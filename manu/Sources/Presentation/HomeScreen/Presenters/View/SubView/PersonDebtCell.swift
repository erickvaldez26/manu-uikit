//
//  PersonDebtCell.swift
//  manu
//
//  Created by Erick Valdez on 1/05/25.
//

import UIKit

class PersonDebtCell: UICollectionViewCell {
    
    static let identifier = "PersonDebtCell"

    @IBOutlet weak var avatarContent: UIView!
    @IBOutlet weak var avatarNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        avatarContent.layer.cornerRadius = 14
        avatarContent.backgroundColor = .accentGreen
        
        avatarNameLabel.font = .montserratRegular(16)
        avatarNameLabel.textColor = .black
        avatarNameLabel.text = "JC"
        
        nameLabel.font = .montserratRegular()
        nameLabel.textColor = .black
        nameLabel.text = "Jessica"
    }
    
    public func configuration(_ name: String) {
        avatarNameLabel.text = Utils.getInitials(from: name)
        nameLabel.text = name
    }
}
