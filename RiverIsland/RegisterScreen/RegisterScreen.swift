//
//  LoginScreen.swift
//  RiverIsland
//
//  Created by Anna Sibirtseva on 03/09/2020.
//  Copyright © 2020 Anna Sibirtseva. All rights reserved.
//

import UIKit

import Foundation
import Firebase

class RegisterScreen: UIViewController, UITextFieldDelegate {

    private let emailTextField: UITextField = {
        let email = UITextField()
        email.attributedPlaceholder = NSAttributedString(string: Constants.Strings.email,
                                                         attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        email.textColor = .white
        email.tintColor = .white
        email.font = UIFont.systemFont(ofSize: 14)
        return email
    }()

    private let passwordTextField: UITextField = {
        let password = UITextField()
        password.attributedPlaceholder = NSAttributedString(string: Constants.Strings.password,
                                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        password.isSecureTextEntry = true
        password.textColor = .white
        password.tintColor = .white
        password.font = UIFont.systemFont(ofSize: 14)
        return password
    }()

    private var registerLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Strings.register
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .white
        return label
    }()

    private var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.Strings.register.uppercased(), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.addBorder(color: .white, width: 2)
        button.titleLabel?.textColor = .white
        button.addTarget(self, action: #selector(registerButtonAction), for: .touchUpInside)
        return button
    }()


    private var signInButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.Button.signIn, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.contentHorizontalAlignment = .right
        button.titleLabel?.textColor = .white
        button.addTarget(self, action: #selector(signInButtonAction), for: .touchUpInside)
        return button
    }()

    private var alreadyHaveAccountLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Strings.haveAccount
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        return label
    }()

    private lazy var haveAccountStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [UIView(),
                                                       alreadyHaveAccountLabel,
                                                       signInButton,
                                                       UIView()])
        stackView.distribution = .equalCentering
        return stackView
    }()

    private lazy var registerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [registerLabel,
                                                       emailTextField,
                                                       passwordTextField,
        ])
        stackView.axis = .vertical
        stackView.spacing = Constants.padding
        return stackView
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [UIView(),
                                                       registerStackView,
                                                       UIView(),
                                                       registerButton,
                                                       haveAccountStack])
        stackView.axis = .vertical
        stackView.spacing = Constants.padding
        return stackView
    }()

    private lazy var backgroundImage: UIView = {
        let background = UIImage(named: "man")
        let imageView = UIImageView()
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.image = background
        imageView.alpha = 0.8
        return imageView
    }()

    func assignBackground() {
        view.addSubview(backgroundImage)
        backgroundImage.fillSuperview()
        self.view.sendSubviewToBack(backgroundImage)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        assignBackground()
        view.addSubview(stackView)
        setupConstraints()
        setNavigationBar()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        self.registerStackView.layoutIfNeeded()
        setupUI()
    }

    private func setNavigationBar() {
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.backgroundColor = UIColor.clear
        let rightButton = UIBarButtonItem(
            title: Constants.Button.skip,
            style: .plain,
            target: self,
            action: #selector(skipButtonAction)
        )
        rightButton.tintColor = .white
        navigationItem.rightBarButtonItem = rightButton
    }

    private func setupUI() {
        emailTextField.keyboardType = UIKeyboardType.emailAddress
        emailTextField.addBottomBorder()
        passwordTextField.addBottomBorder()
        registerButton.layer.cornerRadius = 28
    }

    // MARK:  TextField

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
            passwordTextField.text?.removeAll()
        default:
            passwordTextField.resignFirstResponder()
        }
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case passwordTextField:
            passwordTextField.text?.removeAll()
        default:
            return
        }
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return false
    }

    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    //MARK: Animations

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        backgroundImage.fadeIn(0.5, alpha: 0.4)
        // Make the navigation bar background clear
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        backgroundImage.fadeOut(0.2)
    }

    // MARK: Constraints

    private func setupStackViewConstraints() {
        stackView.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.padding).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.padding).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.padding).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.padding).isActive = true
    }

    private func setupConstraints() {
        view.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        setupStackViewConstraints()
        emailTextField.heightAnchor.constraint(equalToConstant: 42).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 42).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
        let height = self.view.frame.size.height
        registerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: height/3).isActive = true
    }

    // MARK: - Button Actions

    @objc func skipButtonAction(sender: UIButton) {
        let mainVC = ProductsViewController()
        navigationController?.pushViewController(mainVC, animated: true)
    }

    @objc func registerButtonAction(sender: UIButton) {

        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in

                if let err = error {
                    self.presentAlert(title: err.localizedDescription, message: "")
                } else {
                    let mainVC = ProductsViewController()
                    self.navigationController?.pushViewController(mainVC, animated: true)
                }
            }
        }
    }

    @objc func signInButtonAction(sender: UIButton) {
        navigationController?.popViewController(animated: true)
        UIView.transition(with: self.navigationController!.view, duration: 0.5, options: UIView.AnimationOptions.transitionFlipFromRight, animations: nil, completion: nil)
    }
}
