//
//  MonthlyPaymentCell.swift
//  manu
//
//  Created by Erick Valdez on 1/05/25.
//

import UIKit

class MonthlyPaymentCell: UITableViewCell {
    
    static let identifier = "MonthlyPaymentCell"

    @IBOutlet weak var cellContentView: UIView!
    @IBOutlet weak var backgroundContentImage: UIView!
    @IBOutlet weak var contentImage: UIImageView!
    @IBOutlet weak var serviceNameLabel: UILabel!
    @IBOutlet weak var typeServiceLabel: UILabel!
    @IBOutlet weak var amountToPayLabel: UILabel!
    @IBOutlet weak var dateForPaymentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
        self.selectionStyle = .none
        self.backgroundColor = .clear
        
        cellContentView.layer.cornerRadius = 16
        cellContentView.backgroundColor = .white
        
        backgroundContentImage.layer.cornerRadius = 14
        backgroundContentImage.backgroundColor = .primary
        contentImage.image = UIImage(systemName: "globe")
        contentImage.tintColor = .black
        
        serviceNameLabel.font = .montserratRegular()
        serviceNameLabel.textColor = . black
        serviceNameLabel.text = "Win"
        
        typeServiceLabel.font = .montserratRegular(10)
        typeServiceLabel.textColor = .black
        typeServiceLabel.text = "Internet"
        
        amountToPayLabel.font = .montserratRegular(14)
        amountToPayLabel.textColor = .accentRed
        amountToPayLabel.text = "S/ 99.0"
        
        dateForPaymentLabel.font = .montserratRegular(10)
        dateForPaymentLabel.textColor = .black
        dateForPaymentLabel.text = "28 c/m"
    }
    
    public func configuration(
        imageName: String,
        title: String,
        subtitle: String,
        amount: Double,
        paymentDay: String
    ) {
        contentImage.image = UIImage(systemName: imageName)
        serviceNameLabel.text = title
        typeServiceLabel.text = subtitle
        amountToPayLabel.text = "S/ \(amount)"
        dateForPaymentLabel.text = "\(paymentDay) c/m"
    }
}
