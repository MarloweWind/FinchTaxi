//
//  LoginViewController.swift
//  FINCH TAXI
//
//  Created by Marlowe Wind on 02.02.2022.
//

import UIKit

protocol LoginViewInput: AnyObject {
    func didFailCode(errorModel: ErrorModel)
}

final class LoginViewController: UIViewController {
    
    // MARK: - Types
    
    enum StyleStateType {
        case wrong
        case right
    }
    
    
    // MARK: - Locals
    
    private enum Locals {
        static let loginText = "Войти"
        static let phoneText = "Телефон"
        static let loginButtonText = "Войти"
        static let alertTitle = "Внимание"
        static let emptyPhoneAlertMessage = "Пожалуйста введите ваш номер телефона"
        static let wrongMaskAlertMessage = "Пожалуйста введите номер русского оператора"
        static let phoneMaskText = "+# (XXX) XXX-XX-XX"
        static let didFailCodeText = "Нет подключения к интернету"
    }
    
    
    // MARK: - Properties
    
    var presenter: LoginViewOutput?
    
    private let loginLabel = UILabel()
    private let phoneTextField = UITextField()
    private let loginButton = UIButton(type: .system)
    private let separatorView = UIView()
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawSelf()
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        navigationItem.setHidesBackButton(true, animated: true)
        navigationController?.navigationBar.isHidden = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapSuperView))
        view.addGestureRecognizer(tapGesture)
        
        view.backgroundColor = .white
        
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        loginLabel.text = Locals.loginText
        loginLabel.font = UIFont(name: .bold, size: 40)
        loginLabel.textColor = .black
        
        phoneTextField.translatesAutoresizingMaskIntoConstraints = false
        phoneTextField.attributedPlaceholder = NSAttributedString(
            string: Locals.phoneText,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.finchGrey]
        )
        phoneTextField.font = UIFont(name: .regular, size: 16)
        phoneTextField.textColor = .black
        phoneTextField.keyboardType = .numberPad
        phoneTextField.delegate = self
        
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.backgroundColor = .separatorColor
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.isEnabled = false
        loginButton.setTitle(Locals.loginButtonText, for: .normal)
        loginButton.tintColor = .black
        loginButton.layer.cornerRadius = 21
        loginButton.titleLabel?.font = UIFont(name: .regular, size: 16)
        loginButton.backgroundColor = .buttonColor
        loginButton.addTarget(self,
                              action: #selector(didTapLoginButton),
                              for: .touchUpInside)
        
        view.addSubview(loginLabel)
        view.addSubview(phoneTextField)
        view.addSubview(loginButton)
        view.addSubview(separatorView)
        
        NSLayoutConstraint.activate([
            loginLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            loginLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 140),
            
            phoneTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            phoneTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
            phoneTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            separatorView.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 16),
            separatorView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            separatorView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
            separatorView.heightAnchor.constraint(equalToConstant: 0.5),
            
            loginButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 74),
            loginButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -74),
            loginButton.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 184),
            loginButton.heightAnchor.constraint(equalToConstant: 42)
            ])
    }
    
    
    // MARK: - Private Methods
    
    private func format(with mask: String, phone: String) -> String {
        
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex

        for character in mask where index < numbers.endIndex {
            if character == "X" {
                result.append(numbers[index])
                index = numbers.index(after: index)
            } else if character == "#" {
                result.append("7")
                index = numbers.index(after: index)
            } else {
                result.append(character)
            }
        }
        return result
    }
    
    private func switchStyle(type: StyleStateType) {
        
        switch type {
        case .wrong:
            loginButton.isEnabled = false
            separatorView.backgroundColor = .red
            
        case .right:
            loginButton.isEnabled = true
            separatorView.backgroundColor = .separatorColor
        }
    }
    
    
    // MARK: - Actions
    
    @objc func didTapLoginButton() {
        guard let text = phoneTextField.text
        else {
            return
        }
        presenter?.didTapLoginButton(userPhoneNumber: text)
    }
    
    @objc func didTapSuperView() {
        view.endEditing(true)
    }
    
}


// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        guard let text = textField.text
        else {
            return false
        }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        
        textField.text = format(with: Locals.phoneMaskText, phone: newString)
        
        if textField.text?.count == 18 ||
            textField.text?.isEmpty == true {
            textField.resignFirstResponder()
        }
        
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        guard let text = phoneTextField.text
        else {
            return
        }
        
        if textField.text?.isEmpty == true {
            textField.text = "+7"
        } else {
            textField.text = text
        }
    }
            
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        
        guard let text = textField.text
        else {
            return
        }
        let checkMaskNumber = text.components(separatedBy: "(").last?.components(separatedBy: ")").first
        
        guard text.isEmpty ||
                checkMaskNumber?.isCheckedPhoneOperator == false ||
                text.count < 18
        else {
            switchStyle(type: .right)
            return
        }
        switchStyle(type: .wrong)        
    }
    
}


// MARK: - LoginViewInput
extension LoginViewController: LoginViewInput {
    func didFailCode(errorModel: ErrorModel) {
        presentAlert(title: Locals.alertTitle, message: errorModel.message)
    }
}
