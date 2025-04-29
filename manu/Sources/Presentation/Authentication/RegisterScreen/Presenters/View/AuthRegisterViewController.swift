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
        setupUI()
    }
    
    private func setupUI() {
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
        emailTextField.setPlaceholder(Constants.Localized.email.apply())
        emailTextField.textField.keyboardType = .emailAddress
        emailTextField.textField.autocapitalizationType = .none
        emailTextField.textField.autocorrectionType = .no
        passwordTextField.setPlaceholder(Constants.Localized.password.apply())
        passwordTextField.isSecureEntry = true
        passwordTextField.textField.autocapitalizationType = .none
        
        infoView.configure(
            message: "La contraseña debe tener entre 8 y 12 caracteres, incluir al menos un número y una letra mayúscula. Por favor, verifica tu entrada e inténtalo de nuevo.",
            state: .info
        )
        
        privacyPoliticLabel.font = .montserratRegular(10)
        privacyPoliticLabel.text = "\(Constants.Localized.termConditionsPartOne.apply()) \(Constants.Localized.termConditionsPartTwo.apply())"
        
        createAccountButton.setCustomTitle(Constants.Localized.confirm.apply())
        createAccountButton.setState(.disabled)
    }
    
    @objc func tappedBackPressed() {
        coordinator.popupController()
    }

}
