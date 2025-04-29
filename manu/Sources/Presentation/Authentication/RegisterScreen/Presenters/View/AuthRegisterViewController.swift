//
//  AuthRegisterViewController.swift
//  manu
//
//  Created by Erick Valdez on 28/04/25.
//

import UIKit

class AuthRegisterViewController: UIViewController {
    
    private let coordinator: AuthenticationCoordinatorProtocol
    
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
    
    init(coordinator: AuthenticationCoordinatorProtocol) {
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
        usernameTextField.textField.addDoneButton(target: self, action: #selector(doneTapped))
        emailTextField.setPlaceholder(Constants.Localized.email.apply())
        emailTextField.textField.keyboardType = .emailAddress
        emailTextField.textField.autocapitalizationType = .none
        emailTextField.textField.autocorrectionType = .no
        emailTextField.textField.addDoneButton(target: self, action: #selector(doneTapped))
        passwordTextField.setPlaceholder(Constants.Localized.password.apply())
        passwordTextField.isSecureEntry = true
        passwordTextField.textField.autocapitalizationType = .none
        passwordTextField.textField.addDoneButton(target: self, action: #selector(doneTapped))
        
        infoView.configure(
            message: "La contraseña debe tener entre 8 y 12 caracteres, incluir al menos un número y una letra mayúscula.",
            state: .info
        )
        
        privacyPoliticLabel.font = .montserratRegular(10)
        privacyPoliticLabel.textColor = .black
        privacyPoliticLabel.text = "\(Constants.Localized.termConditionsPartOne.apply()) \(Constants.Localized.termConditionsPartTwo.apply())"
        
        createAccountButton.setCustomTitle(Constants.Localized.confirm.apply())
        createAccountButton.setState(.disabled)
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
