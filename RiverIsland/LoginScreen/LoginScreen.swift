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
        email.layer.borderWidth = Constants.one
        email.layer.borderColor = Constants.Colors.white.cgColor
        return email
    }()

    private let passwordTextField: UITextField = {
        let password = UITextField()
        password.attributedPlaceholder = NSAttributedString(string: Constants.Strings.password,
                                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        password.clearsOnBeginEditing = true
        password.isSecureTextEntry = true
        password.textColor = .white
        password.layer.borderWidth = Constants.one
        password.layer.borderColor = Constants.Colors.white.cgColor
        return password
    }()

    private var signInLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Strings.signIn
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .white
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
                                                       signInLabel,
                                                       emailTextField,
                                                       passwordTextField])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = Constants.padding
        return stackView
    }()

    private lazy var backgroundImage: UIView = {
        let background = UIImage(named: "background_image")
        let imageView = UIImageView()
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.image = background
        imageView.alpha = 0.4
        return imageView
    }()

    func assignBackground() {
        view.addSubview(backgroundImage)
        self.view.sendSubviewToBack(backgroundImage)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        assignBackground()
        view.backgroundColor = .black
        view.addSubview(stackView)
        setupConstraints()
        passwordTextField.delegate = self
        animateUIView()
        
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.backgroundColor = UIColor.clear
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: Constants.Button.skip,
            style: .plain,
            target: self,
            action: #selector(skipButtonAction)
        )
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Make the navigation bar background clear
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }

    private func animateUIView() {
        UIView.animate(withDuration: 1.0,
                       delay: 0.0,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 1.0,
                       options: .curveEaseIn,
                       animations: { [weak self] in
                        guard let self = self else {
                            return
                        }
                        self.view.layoutIfNeeded()
            }, completion: nil)
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
    }

    // Limits Password to 6 characters
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 6
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }

    // MARK: - Button Actions

    @objc func skipButtonAction(sender: UIButton) {
        let mainVC = MainViewController()
        navigationController?.pushViewController(mainVC, animated: true)
    }
}
