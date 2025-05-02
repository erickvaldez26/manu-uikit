//
//  HomeViewController.swift
//  manu
//
//  Created by Erick Valdez on 29/04/25.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var helloLabel: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var notificationContentView: UIView!
    @IBOutlet weak var notificationImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var cardBalanceView: UIView!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var amountBalanceLabel: UILabel!
    @IBOutlet weak var obfuscationImage: UIImageView!
    @IBOutlet weak var receiveContentView: UIView!
    @IBOutlet weak var receiveImage: UIImageView!
    @IBOutlet weak var receiveLabel: UILabel!
    @IBOutlet weak var transferContentView: UIView!
    @IBOutlet weak var transferImage: UIImageView!
    @IBOutlet weak var transferLabel: UILabel!
    @IBOutlet weak var whoYouOweLabel: UILabel!
    @IBOutlet weak var addDebContentView: UIView!
    @IBOutlet weak var addDebImage: UIImageView!
    @IBOutlet weak var allDebsTable: UICollectionView!
    @IBOutlet weak var payMonthLabel: UILabel!
    @IBOutlet weak var amountTotalPayMonthLabel: UILabel!
    @IBOutlet weak var monthlyPaymentsTable: UITableView!
    
    private let items = Array(1...10).map { "Item \($0)" }
    
    init () {
        super.init(nibName: String(describing: HomeViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        helloLabel.font = UIFont.montserratRegular(20)
        helloLabel.textColor = .accentGray
        helloLabel.text = "Hola Erick"
        welcomeLabel.font = UIFont.montserratRegular()
        welcomeLabel.textColor = .accentGray
        welcomeLabel.text = "Bienvenido otra vez"
        
        notificationContentView.backgroundColor = .white
        notificationContentView.layer.cornerRadius = 20
        notificationImage.image = UIImage(systemName: "bell")
        notificationImage.tintColor = .accentGray
        
        profileImage.layer.cornerRadius = 20
        profileImage.image = UIImage(named: "resource_app_icon")
        
        cardBalanceView.layer.cornerRadius = 18
        cardBalanceView.backgroundColor = .accentGreen
        balanceLabel.font = .montserratRegular()
        balanceLabel.textColor = .white
        balanceLabel.text = "Balance total"
        amountBalanceLabel.font = .montserratBold(22)
        amountBalanceLabel.textColor = .white
        amountBalanceLabel.text = "S/ 1,256.87"
        obfuscationImage.image = UIImage(systemName: "eye.fill")
        obfuscationImage.tintColor = .white
        
        receiveContentView.backgroundColor = .black
        receiveContentView.layer.cornerRadius = 20
        receiveImage.image = UIImage(systemName: "arrow.uturn.down")
        receiveImage.tintColor = .white
        receiveLabel.font = UIFont.montserratRegular()
        receiveLabel.textColor = .white
        receiveLabel.text = "Recivir"
        
        transferContentView.backgroundColor = .black
        transferContentView.layer.cornerRadius = 20
        transferImage.image = UIImage(systemName: "arrow.uturn.up")
        transferImage.tintColor = .white
        transferLabel.font = UIFont.montserratRegular()
        transferLabel.textColor = .white
        transferLabel.text = "Transferir"
        
        whoYouOweLabel.font = UIFont.montserratRegular(14)
        whoYouOweLabel.textColor = .black
        whoYouOweLabel.text = "A quien le debes?"
        addDebContentView.layer.cornerRadius = 14
        addDebContentView.backgroundColor = .white
        addDebImage.image = UIImage(systemName: "plus")
        addDebImage.tintColor = .black
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        allDebsTable.collectionViewLayout = layout
        allDebsTable.register(UINib(nibName: PersonDebtCell.identifier, bundle: nil), forCellWithReuseIdentifier: PersonDebtCell.identifier)
        allDebsTable.showsHorizontalScrollIndicator = false
        allDebsTable.backgroundColor = .clear
        allDebsTable.delegate = self
        allDebsTable.dataSource = self
        
        payMonthLabel.font = UIFont.montserratRegular(14)
        payMonthLabel.textColor = .black
        payMonthLabel.text = "Pago mensuales"
        amountTotalPayMonthLabel.font = UIFont.montserratRegular(14)
        amountTotalPayMonthLabel.textColor = .black
        amountTotalPayMonthLabel.text = "S/ 1,876.80"
        
        monthlyPaymentsTable.register(UINib(nibName: MonthlyPaymentCell.identifier, bundle: nil), forCellReuseIdentifier: MonthlyPaymentCell.identifier)
        monthlyPaymentsTable.backgroundColor = .clear
        monthlyPaymentsTable.contentInset.bottom = 90
        monthlyPaymentsTable.separatorStyle = .none
        monthlyPaymentsTable.showsVerticalScrollIndicator = false
        monthlyPaymentsTable.delegate = self
        monthlyPaymentsTable.dataSource = self
    }

}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PersonDebtCell.self), for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 68, height: 100)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MonthlyPaymentCell.self), for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
}
