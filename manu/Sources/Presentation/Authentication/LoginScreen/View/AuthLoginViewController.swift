//
//  AuthLoginViewController.swift
//  manu
//
//  Created by Erick Valdez on 26/04/25.
//

import UIKit

class AuthLoginViewController: UIViewController {

    @IBOutlet weak var appImage: UIImageView!
    @IBOutlet weak var topTagLabel: UILabel!
    @IBOutlet weak var bannerTitleLabel: UILabel!
    @IBOutlet weak var emailTextField: MNInput!
    @IBOutlet weak var passwordTextField: MNInput!
    @IBOutlet weak var enrollFaceIdButton: UIButton!
    @IBOutlet weak var enterButton: MNButton!
    @IBOutlet weak var infoRegisterLabel: UILabel!
    
    init() {
        super.init(nibName: String(describing: AuthLoginViewController.self), bundle: nil)
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
        passwordTextField.setPlaceholder(Constants.Localized.password.apply())
        passwordTextField.isSecureEntry = true
        
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
        infoRegisterLabel.text = "\(Constants.Localized.haveDontRegistered.apply()) \(Constants.Localized.registerHere.apply())"
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
    
}
