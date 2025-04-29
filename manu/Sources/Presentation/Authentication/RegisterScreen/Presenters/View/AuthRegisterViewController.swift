//
//  AuthRegisterViewController.swift
//  manu
//
//  Created by Erick Valdez on 28/04/25.
//

import UIKit
import Combine

class AuthRegisterViewController: UIViewController {
    
    private let viewModel: AuthRegisterViewModel
    private let coordinator: AuthenticationCoordinatorProtocol
    private var cancellables = Set<AnyCancellable>()
    
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var titleScreenLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var usernameTextField: MNInput!
    @IBOutlet weak var emailTextField: MNInput!
    @IBOutlet weak var passwordTextField: MNInput!
    @IBOutlet weak var infoView: MNInfoTextView!
    @IBOutlet weak var checkButton: MNCheckBox!
    @IBOutlet weak var privacyPoliticLabel: UILabel!
    @IBOutlet weak var createAccountButton: MNButton!
    
    init(viewModel: AuthRegisterViewModel, coordinator: AuthenticationCoordinatorProtocol) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: String(describing: AuthRegisterViewController.self), bundle: nil)
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
        
        backImageView.tintColor = UIColor.black
        backImageView.isUserInteractionEnabled = true
        let tapBack = UITapGestureRecognizer(target: self, action: #selector(tappedBackPressed))
        backImageView.addGestureRecognizer(tapBack)
        titleScreenLabel.font = .montserratRegular(18)
        titleScreenLabel.textColor = .black
        titleScreenLabel.text = Constants.Localized.register.apply()
        
        subTitleLabel.font = .montserratRegular()
        subTitleLabel.textColor = .black
        subTitleLabel.numberOfLines = .zero
        subTitleLabel.text = Constants.Localized.descriptionRegisterScreen.apply()
        
        usernameTextField.setPlaceholder(Constants.Localized.name.apply())
        usernameTextField.textField.autocorrectionType = .no
        usernameTextField.delegate = self
        usernameTextField.textField.addDoneButton(target: self, action: #selector(doneTapped))
        usernameTextField.textField.addTarget(self, action: #selector(onChangeText), for: .editingChanged)
        emailTextField.setPlaceholder(Constants.Localized.email.apply())
        emailTextField.textField.keyboardType = .emailAddress
        emailTextField.textField.autocapitalizationType = .none
        emailTextField.textField.autocorrectionType = .no
        emailTextField.delegate = self
        emailTextField.textField.addDoneButton(target: self, action: #selector(doneTapped))
        emailTextField.textField.addTarget(self, action: #selector(onChangeText), for: .editingChanged)
        passwordTextField.setPlaceholder(Constants.Localized.password.apply())
        passwordTextField.isSecureEntry = true
        passwordTextField.textField.autocapitalizationType = .none
        passwordTextField.textField.addDoneButton(target: self, action: #selector(doneTapped))
        passwordTextField.textField.addTarget(self, action: #selector(onChangeText), for: .editingChanged)
        
        infoView.configure(
            message: "La contraseña debe tener entre 8 y 12 caracteres, incluir al menos un número y una letra mayúscula.",
            state: .info
        )
        
        checkButton.onToggle = { [weak self] isChecked in
            self?.viewModel.isCheckedTermConditions = isChecked
            self?.onChangeText()
        }
        
        privacyPoliticLabel.font = .montserratRegular(10)
        privacyPoliticLabel.textColor = .black
        privacyPoliticLabel.text = "\(Constants.Localized.termConditionsPartOne.apply()) \(Constants.Localized.termConditionsPartTwo.apply())"
        
        createAccountButton.setCustomTitle(Constants.Localized.confirm.apply())
        createAccountButton.setState(.disabled)
    }
    
    private func setupBindings() {
        viewModel.$stateButton
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                self?.createAccountButton.setState(value)
            }
            .store(in: &cancellables)
        
        viewModel.$displayRegisterSuccess
            .receive(on: DispatchQueue.main)
            .sink { success in
                if success {
                    print("APP -> El registro es correcto")
                }
            }
            .store(in: &cancellables)
        
        viewModel.$displayErrorRegister
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .sink { [weak self] error in
                self?.coordinator.presentAlertError(error)
            }
            .store(in: &cancellables)
    }
    
    @IBAction func registerTapped(_ sender: Any) {
        viewModel.initRegister()
    }
    
    @objc private func onChangeText() {
        viewModel.validateFields(
            name: usernameTextField.text ?? "",
            email: emailTextField.text ?? "",
            password: passwordTextField.text ?? ""
        )
    }
    
    @objc func tappedBackPressed() {
        coordinator.popupController()
    }
  
    @objc private func tappedInController() {
        view.endEditing(true)
    }
    
    @objc private func doneTapped() {
        view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        subTitleLabel.hideWithAnimation()
    }

    @objc private func keyboardWillHide(notification: Notification) {
        subTitleLabel.showWithAnimation()
    }

}

extension AuthRegisterViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == emailTextField.textField && string.contains(" ") {
            return false
        }
        return true
    }
}
