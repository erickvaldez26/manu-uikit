//
//  AuthLoginViewController.swift
//  manu
//
//  Created by Erick Valdez on 26/04/25.
//

import UIKit
import Combine

class AuthLoginViewController: UIViewController {
    
    private let viewModel: AuthLoginViewModel
    private let coordinator: AuthenticationCoordinatorProtocol
    private var cancellables = Set<AnyCancellable>()

    @IBOutlet weak var appImage: UIImageView!
    @IBOutlet weak var topTagLabel: UILabel!
    @IBOutlet weak var bannerTitleLabel: UILabel!
    @IBOutlet weak var emailTextField: MNInput!
    @IBOutlet weak var passwordTextField: MNInput!
    @IBOutlet weak var enrollFaceIdButton: UIButton!
    @IBOutlet weak var enterButton: MNButton!
    @IBOutlet weak var infoRegisterLabel: UILabel!
    
    init(viewModel: AuthLoginViewModel, coordinator: AuthenticationCoordinatorProtocol) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: String(describing: AuthLoginViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotificationCenter()
        setupUI()
        setupBindings()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupUI() {
        let tapInView = UITapGestureRecognizer(target: self, action: #selector(tappedInController))
        tapInView.cancelsTouchesInView = false
        view.addGestureRecognizer(tapInView)
        
        appImage.layer.cornerRadius = 6
        let appName: [NSAttributedString.Key: Any] = [
            .font: UIFont.montserratBold(16),
            .foregroundColor: UIColor.black
        ]
        let appVersion: [NSAttributedString.Key: Any] = [
            .font: UIFont.montserratRegular(10),
            .foregroundColor: UIColor.black
        ]
        let attributedText = NSMutableAttributedString(string: Constants.Localized.appName.apply(), attributes: appName)
        attributedText.append(NSAttributedString(string: "v\(Utils.getAppVersion())", attributes: appVersion))
        topTagLabel.attributedText = attributedText
        
        bannerTitleLabel.font = .montserratRegular(20)
        bannerTitleLabel.textColor = UIColor.black
        bannerTitleLabel.numberOfLines = .zero
        bannerTitleLabel.textAlignment = .center
        bannerTitleLabel.text = Constants.Localized.titleLoginScreen.apply()
        
        emailTextField.setPlaceholder(Constants.Localized.email.apply())
        emailTextField.delegate = self
        emailTextField.textField.keyboardType = .emailAddress
        emailTextField.textField.addTarget(self, action: #selector(onChangeText), for: .editingChanged)
        passwordTextField.setPlaceholder(Constants.Localized.password.apply())
        passwordTextField.isSecureEntry = true
        passwordTextField.delegate = self
        passwordTextField.textField.keyboardType = .default
        passwordTextField.textField.autocapitalizationType = .none
        passwordTextField.textField.addTarget(self, action: #selector(onChangeText), for: .editingChanged)
        
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: Constants.IconsName.faceId)
        config.contentInsets = .zero
        enrollFaceIdButton.configuration = config
        enrollFaceIdButton.imageView?.contentMode = .scaleAspectFill
        enrollFaceIdButton.imageView?.translatesAutoresizingMaskIntoConstraints = false
        enrollFaceIdButton.tintColor = UIColor(named: "lightGray")
        NSLayoutConstraint.activate([
            enrollFaceIdButton.imageView!.widthAnchor.constraint(equalTo: enrollFaceIdButton.widthAnchor),
            enrollFaceIdButton.imageView!.heightAnchor.constraint(equalTo: enrollFaceIdButton.heightAnchor)
        ])
        
        enterButton.setCustomTitle(Constants.Localized.join.apply())
        enterButton.setState(.disabled)
        
        infoRegisterLabel.font = .montserratRegular(12)
        infoRegisterLabel.textColor = .black
        infoRegisterLabel.isUserInteractionEnabled = true
        infoRegisterLabel.text = "\(Constants.Localized.haveDontRegistered.apply()) \(Constants.Localized.registerHere.apply())"
        let tapRegisterLink = UITapGestureRecognizer(target: self, action: #selector(tappedRegisterLink))
        infoRegisterLabel.addGestureRecognizer(tapRegisterLink)
    }
    
    private func setupBindings() {
        viewModel.$stateButton
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                self?.enterButton.setState(value)
            }
            .store(in: &cancellables)
        
        viewModel.$displayLoginSuccess
            .receive(on: DispatchQueue.main)
            .sink { [weak self] success in
                if success {
                    self?.coordinator.goToTabBarController()
                }
            }
            .store(in: &cancellables)
        
        viewModel.$displayErrorLogin
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .sink { [weak self] error in
                self?.coordinator.presentAlertError(error)
            }
            .store(in: &cancellables)
    }
    
    @IBAction func enterTapped(_ sender: Any) {
        viewModel.initLogin()
    }
    
    @IBAction func enrollFaceIdTapped(_ sender: Any) {}
    
    @objc private func tappedInController() {
        view.endEditing(true)
    }
    
    @objc private func onChangeText() {
        viewModel.validateFields(
            email: emailTextField.text ?? "",
            password: passwordTextField.text ?? ""
        )
    }

    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        let keyboardHeight = keyboardFrame.height
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= keyboardHeight
        }
    }

    @objc private func keyboardWillHide(notification: Notification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @objc private func tappedRegisterLink() {
        coordinator.goToRegister()
    }
    
}

extension AuthLoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == emailTextField.textField && string.contains(" ") {
            return false
        }
        return true
    }
}
