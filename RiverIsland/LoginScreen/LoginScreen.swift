//
//  LoginScreen.swift
//  RiverIsland
//
//  Created by Anna Sibirtseva on 31/08/2020.
//  Copyright © 2020 Anna Sibirtseva. All rights reserved.
//

import UIKit

import Foundation

class LoginScreen: UIViewController, UITextFieldDelegate {

    private let emailTextField: UITextField = {
        let email = UITextField()
        email.text = Constants.Strings.email
        email.textColor = .white
        email.clearsOnBeginEditing = true
        email.tintColor = .white
        return email
    }()

    private let passwordTextField: UITextField = {
        let password = UITextField()
        password.attributedPlaceholder = NSAttributedString(string: Constants.Strings.password,
                                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        password.clearsOnBeginEditing = true
        password.isSecureTextEntry = true
        password.textColor = .white
        password.tintColor = .white
        return password
    }()

    private var signInLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Strings.signIn
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .white
        return label
    }()

    private var forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.Button.forgotPassword, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.contentHorizontalAlignment = .right
        button.titleLabel?.textColor = .white
        return button
    }()

    private lazy var forgotPasswordStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [forgotPasswordButton])
        return stackView
    }()

    private var signInButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.Strings.signIn.uppercased(), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.addBorder(color: .white, width: 2)
        button.titleLabel?.textColor = .white
        button.addTarget(self, action: #selector(skipButtonAction), for: .touchUpInside)
        return button
    }()


    private var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.Button.signUp, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.contentHorizontalAlignment = .right
        button.titleLabel?.textColor = .white
        return button
    }()

    private var dontHaveAccountLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Strings.dontHaveAccount
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        return label
    }()

    private lazy var dontHaveAccount: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [UIView(),
                                                       dontHaveAccountLabel,
                                                       signUpButton,
                                                       UIView()])
        stackView.distribution = .equalCentering
        return stackView
    }()


    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [UIView(),
                                                       signInLabel,
                                                       emailTextField,
                                                       passwordTextField,
                                                       forgotPasswordStack,
                                                       UIView(),
                                                       signInButton,
                                                       dontHaveAccount])
        stackView.axis = .vertical
        stackView.spacing = Constants.padding
        return stackView
    }()

    private lazy var backgroundImage: UIView = {
        let background = UIImage(named: "background_image")
        let imageView = UIImageView()
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.image = background
        imageView.alpha = 0.8
        return imageView
    }()

    func assignBackground() {
        view.addSubview(backgroundImage)
        self.view.sendSubviewToBack(backgroundImage)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        assignBackground()
        view.addSubview(stackView)
        setupConstraints()
        animateUIView()
        setNavigationBar()
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

    //TODO: save email and password when entered
    private func setupUI() {
        passwordTextField.delegate = self
        emailTextField.delegate = self
        emailTextField.keyboardType = UIKeyboardType.emailAddress
        emailTextField.addBottomBorder()
        passwordTextField.addBottomBorder()
        signInButton.roundCorners()
    }

    func textFieldShouldReturn(_ scoreText: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        backgroundImage.fadeIn(0.5, alpha: 0.4)
        // Make the navigation bar background clear
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }

    private func animateUIView() {
        UIView.animate(withDuration: 1.3,
                       delay: 0,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 1.0,
                       options: .curveEaseIn,
                       animations: {
                        self.stackView.center = CGPoint(x: 200, y: 0)
                        self.stackView.layoutIfNeeded()
                        },
            completion: nil)
    }

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
        signInButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
        let height = self.view.frame.size.height
        signInLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: height/3).isActive = true
    }

    //TODO: separate email and password textfields
    // Limit Password to 12 characters
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 12
        let currentString: NSString = (passwordTextField.text ?? "") as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }

    // MARK: - Button Actions

    @objc func skipButtonAction(sender: UIButton) {
        let mainVC = ProductsViewController()
        navigationController?.pushViewController(mainVC, animated: true)
    }
}
