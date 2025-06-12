//
//  HomeViewController.swift
//  manu
//
//  Created by Erick Valdez on 29/04/25.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    
    private let viewModel: HomeViewModel
    private let coordinator: HomeTabCoordinatorProtocol
    private var cancellables = Set<AnyCancellable>()

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
    @IBOutlet weak var leadsContentView: UIView!
    @IBOutlet weak var whoYouOweLabel: UILabel!
    @IBOutlet weak var addDebContentView: UIView!
    @IBOutlet weak var addDebImage: UIImageView!
    @IBOutlet weak var allDebsTable: UICollectionView!
    @IBOutlet weak var addMonthlyPaymentChip: MNChip!
    @IBOutlet weak var titleMonthlyPaymentLabel: UILabel!
    @IBOutlet weak var amountTotalPayMonthLabel: UILabel!
    @IBOutlet weak var monthlyPaymentsTable: UITableView!
    @IBOutlet weak var contentEmptyMontlyPaymentView: UIView!
    @IBOutlet weak var emptyDescriptionLabel: UILabel!
    @IBOutlet weak var createMonthlyPaymentLabelButton: UILabel!
    
    init (viewModel: HomeViewModel, coordinator: HomeTabCoordinatorProtocol) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: String(describing: HomeViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Utils.notifyShowLoader()
        setupUI()
        setupBinding()
    }
    
    func setupUI() {
        helloLabel.font = UIFont.montserratRegular(20)
        helloLabel.textColor = .accentGray
        welcomeLabel.font = UIFont.montserratRegular()
        welcomeLabel.textColor = .accentGray
        welcomeLabel.text = "Bienvenido otra vez"
        
        notificationContentView.backgroundColor = .white
        notificationContentView.layer.cornerRadius = 20
        notificationImage.image = UIImage(systemName: "bell")
        notificationImage.tintColor = .accentGray
        
        profileImage.layer.cornerRadius = 20
        profileImage.image = UIImage(named: "resource_app_icon")
        profileImage.isUserInteractionEnabled = true
        let tapImageProfile = UITapGestureRecognizer(target: self, action: #selector(tapImageProfile))
        profileImage.addGestureRecognizer(tapImageProfile)
        
        cardBalanceView.layer.cornerRadius = 18
        cardBalanceView.backgroundColor = .accentGreen
        balanceLabel.font = .montserratRegular()
        balanceLabel.textColor = .white
        balanceLabel.text = "Balance total"
        amountBalanceLabel.font = .montserratBold(22)
        amountBalanceLabel.textColor = .white
        obfuscationImage.image = UIImage(systemName: "eye.fill")
        obfuscationImage.tintColor = .white
        obfuscationImage.isUserInteractionEnabled = true
        let gestureObfuscation = UITapGestureRecognizer(target: self, action: #selector(toggleObfuscation))
        obfuscationImage.addGestureRecognizer(gestureObfuscation)
        
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
        transferLabel.text = "Entregar"
        
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
        
        addMonthlyPaymentChip.title = "Crear pago mensual"
        titleMonthlyPaymentLabel.font = .montserratRegular(14)
        titleMonthlyPaymentLabel.textColor = .black
        titleMonthlyPaymentLabel.text = "Pagos mensuales"
        amountTotalPayMonthLabel.font = UIFont.montserratRegular(14)
        amountTotalPayMonthLabel.textColor = .black
        
        monthlyPaymentsTable.register(UINib(nibName: MonthlyPaymentCell.identifier, bundle: nil), forCellReuseIdentifier: MonthlyPaymentCell.identifier)
        monthlyPaymentsTable.backgroundColor = .clear
        monthlyPaymentsTable.contentInset.bottom = 90
        monthlyPaymentsTable.separatorStyle = .none
        monthlyPaymentsTable.showsVerticalScrollIndicator = false
        monthlyPaymentsTable.delegate = self
        monthlyPaymentsTable.dataSource = self
        
        contentEmptyMontlyPaymentView.backgroundColor = .clear
        emptyDescriptionLabel.font = .montserratLight(13)
        emptyDescriptionLabel.textColor = .accentLightGray
        emptyDescriptionLabel.text = "Lleva el control de tus gastos mensuales\n agregando tus pagos frecuentes\n aquí."
        emptyDescriptionLabel.numberOfLines = .zero
        
        
        createMonthlyPaymentLabelButton.attributedText = Utils.setStyleTextButton(text: "Agregar mi primer pago")
        createMonthlyPaymentLabelButton.textColor = .black
        createMonthlyPaymentLabelButton.isUserInteractionEnabled = true
        let tapCreateMonthlyPayTextButton = UITapGestureRecognizer(target: self, action: #selector(tapCreateMonthlyPaymentLabelButton))
        createMonthlyPaymentLabelButton.addGestureRecognizer(tapCreateMonthlyPayTextButton)
    }
    
    private func setupBinding() {
        viewModel.$displayUserInfo
            .receive(on: DispatchQueue.main)
            .compactMap({ $0 })
            .sink { [weak self] value in
                self?.updateUserInfo(name: value.name)
            }
            .store(in: &cancellables)
        
        viewModel.$displayObfuscationBalance
            .receive(on: DispatchQueue.main)
            .compactMap({ $0 })
            .sink { [weak self] value in
                self?.updateObfuscation(isObfuscate: value)
            }
            .store(in: &cancellables)
        
        viewModel.$displayLoans
            .receive(on: DispatchQueue.main)
            .compactMap({ $0 })
            .sink { [weak self] success in
                self?.refreshStateLoansCollection()
            }
            .store(in: &cancellables)
        
        viewModel.$displayMonthlyPayments
            .receive(on: DispatchQueue.main)
            .compactMap({ $0 })
            .sink { [weak self] success in
                self?.refreshStateMonthlyPaymentTable()
            }
            .store(in: &cancellables)
        
        viewModel.$displayErrorMonthlyPayments
            .receive(on: DispatchQueue.main)
            .compactMap({ $0 })
            .sink { error in
//                Utils.notifyShowGenericError()
            }
            .store(in: &cancellables)
    }
    
    private func updateUserInfo(name: String) {
        helloLabel.text = "Hola \(name)"
    }
    
    private func updateObfuscation(isObfuscate: Bool) {
        amountBalanceLabel.text = isObfuscate ? "********" : Utils.formatToCurrency(viewModel.displayUserInfo?.totalBalance ?? 0.00)
        obfuscationImage.image = UIImage(systemName: isObfuscate ? "eye.fill" : "eye.slash.fill")
    }
    
    private func refreshStateLoansCollection() {
        let sizeList = viewModel.displayLoans?.count ?? 0
        if sizeList > .zero {
            leadsContentView.isHidden = false
            allDebsTable.reloadData()
        } else {
            leadsContentView.isHidden = true
        }
    }
    
    private func refreshStateMonthlyPaymentTable() {
        let sizeList = viewModel.displayMonthlyPayments?.count ?? 0
        if sizeList > .zero {
            addMonthlyPaymentChip.isHidden = false
            titleMonthlyPaymentLabel.isHidden = true
            contentEmptyMontlyPaymentView.isHidden = true
            monthlyPaymentsTable.isHidden = false
            monthlyPaymentsTable.reloadData()
            amountTotalPayMonthLabel.isHidden = false
            amountTotalPayMonthLabel.text = "S/ \(viewModel.calculateTotalMonthlyPayment())"
        } else {
            addMonthlyPaymentChip.isHidden = true
            titleMonthlyPaymentLabel.isHidden = false
            monthlyPaymentsTable.isHidden = true
            contentEmptyMontlyPaymentView.isHidden = false
            amountTotalPayMonthLabel.isHidden = true
        }
    }
    
    @objc private func tapImageProfile() {
        viewModel.signOut()
    }

    @objc private func toggleObfuscation() {
        viewModel.toggleObfuscationBalance()
    }
    
    @objc private func tapCreateMonthlyPaymentLabelButton() {
        print("APP -> Ir a pantalla crear pago mensual")
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.displayLoans?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PersonDebtCell.self), for: indexPath) as? PersonDebtCell else {
            return UICollectionViewCell()
        }
        let data = viewModel.displayLoans?[indexPath.row]
        cell.configuration(data?.personName ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 68, height: 100)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.displayMonthlyPayments?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MonthlyPaymentCell.self), for: indexPath) as? MonthlyPaymentCell else {
            return UITableViewCell()
        }
        let data = viewModel.displayMonthlyPayments?[indexPath.row]
        cell.configuration(
            imageName: data?.imageRef ?? "",
            title: data?.nameService ?? "",
            subtitle: data?.typeService ?? "",
            amount: data?.amount ?? .zero,
            paymentDay: data?.paymentDate ?? ""
        )
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
}
