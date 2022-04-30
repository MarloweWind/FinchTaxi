//
//  ConfirmeCodeViewController.swift
//  FINCH TAXI
//
//  Created by Marlowe Wind on 03.02.2022.
//

import UIKit

protocol ConfirmeCodeViewInput: AnyObject {
    func updateTimer(seconds: Int, isHiddenTimer: Bool)
    func didFailConfirmCode(errorModel: ErrorModel)
}

final class ConfirmeCodeViewController: UIViewController {
    
    // MARK: - Types
    
    enum StyleStateType {
        case wrong
        case right
    }
    
    
    // MARK: - Locals
    
    private enum Locals {
        static let enterCodeText = "Введите код"
        static let codeText = "Код из СМС"
        static let resendCodeText = "Отправить еще раз"
        static let anotherNumberText = "Другой номер"
        static let readyButtonText = "Готово"
        static let alertTitle = "Внимание"
        static let wrongCodeAlertMessage = "Вы ввели неверный код"
    }
    
    
    // MARK: - Properties
    
    var presenter: ConfirmeCodeViewOutput?
    
    private let enterCodeLabel = UILabel()
    private let infoLabel = UILabel()
    private let codeTextField = UITextField()
    private let separatorView = UIView()
    private let timerLabel = UITextField()
    private let resendCodeButton = UIButton(type: .system)
    private let anotherNumberButton = UIButton(type: .system)
    private let readyButton = UIButton(type: .system)
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawSelf()
        presenter?.viewIsReady()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter?.viewWillDisappear()
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        guard let userPhoneNumber = presenter?.getUserPhone
        else {
            return
        }
        
        navigationItem.setHidesBackButton(true, animated: true)
        navigationController?.navigationBar.isHidden = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapSuperView))
        view.addGestureRecognizer(tapGesture)
        
        view.backgroundColor = .white
        
        enterCodeLabel.translatesAutoresizingMaskIntoConstraints = false
        enterCodeLabel.text = Locals.enterCodeText
        enterCodeLabel.font = UIFont(name: .bold, size: 40)
        enterCodeLabel.textColor = .black
        
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.font = UIFont(name: .regular, size: 16)
        infoLabel.textColor = .finchGrey
        infoLabel.textAlignment = .left
        infoLabel.adjustsFontSizeToFitWidth = true
        infoLabel.numberOfLines = 3
        infoLabel.text = "Мы отправили СМС с кодом на номер \(userPhoneNumber). Пожалуйста, введите его в поле ниже"
        
        codeTextField.translatesAutoresizingMaskIntoConstraints = false
        codeTextField.attributedPlaceholder = NSAttributedString(
            string: Locals.codeText,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.finchGrey]
        )
        codeTextField.font = UIFont(name: .regular, size: 16)
        codeTextField.textColor = .black
        codeTextField.keyboardType = .numberPad
        codeTextField.addTarget(self,
                                action: #selector(textFieldDidChange),
                                for: .editingChanged)
        codeTextField.delegate = self
        
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.backgroundColor = .separatorColor
        
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.textColor = .black
        timerLabel.font = UIFont(name: .regular, size: 14)
        
        resendCodeButton.translatesAutoresizingMaskIntoConstraints = false
        resendCodeButton.setTitle(Locals.resendCodeText, for: .normal)
        resendCodeButton.tintColor = .black
        resendCodeButton.titleLabel?.font = UIFont(name: .regular, size: 14)
        resendCodeButton.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        resendCodeButton.isEnabled = false
        resendCodeButton.addTarget(self,
                                   action: #selector(didTapResendButton),
                                   for: .touchUpInside)
        
        anotherNumberButton.translatesAutoresizingMaskIntoConstraints = false
        anotherNumberButton.setTitle(Locals.anotherNumberText, for: .normal)
        anotherNumberButton.tintColor = .finchGrey
        anotherNumberButton.titleLabel?.font = UIFont(name: .regular, size: 16)
        anotherNumberButton.addTarget(self,
                                      action: #selector(didTapAnotherNumberButton),
                                      for: .touchUpInside)
        
        readyButton.translatesAutoresizingMaskIntoConstraints = false
        readyButton.setTitle(Locals.readyButtonText, for: .normal)
        readyButton.tintColor = .black
        readyButton.layer.cornerRadius = 21
        readyButton.backgroundColor = .buttonColor
        readyButton.titleLabel?.font = UIFont(name: .regular, size: 16)
        readyButton.addTarget(self,
                               action: #selector(didTapReadyButton),
                               for: .touchUpInside)
        readyButton.isEnabled = false
        
        view.addSubview(enterCodeLabel)
        view.addSubview(infoLabel)
        view.addSubview(codeTextField)
        view.addSubview(separatorView)
        view.addSubview(timerLabel)
        view.addSubview(resendCodeButton)
        view.addSubview(anotherNumberButton)
        view.addSubview(readyButton)
        
        NSLayoutConstraint.activate([
            enterCodeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            enterCodeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 140),
            
            infoLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            infoLabel.topAnchor.constraint(equalTo: enterCodeLabel.topAnchor, constant: 70),
            infoLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
            
            codeTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            codeTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
            codeTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            separatorView.topAnchor.constraint(equalTo: codeTextField.bottomAnchor, constant: 16),
            separatorView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            separatorView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
            separatorView.heightAnchor.constraint(equalToConstant: 0.5),
            
            timerLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            timerLabel.topAnchor.constraint(equalTo: codeTextField.bottomAnchor, constant: 38),
            
            resendCodeButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
            resendCodeButton.topAnchor.constraint(equalTo: codeTextField.bottomAnchor, constant: 32),
            
            anotherNumberButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            anotherNumberButton.topAnchor.constraint(equalTo: codeTextField.bottomAnchor, constant: 126),
            
            readyButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 74),
            readyButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -74),
            readyButton.topAnchor.constraint(equalTo: codeTextField.bottomAnchor, constant: 184),
            readyButton.heightAnchor.constraint(equalToConstant: 42)
            ])
    }
    
    
    // MARK: - Private Methods
    
    private func switchStyle(type: StyleStateType) {
        switch type {
        case .wrong:
            readyButton.isEnabled = false
            separatorView.backgroundColor = .red
            
        case .right:
            readyButton.isEnabled = true
            separatorView.backgroundColor = .separatorColor
        }
    }
    
    
    // MARK: - Actions
    
    @objc func didTapReadyButton() {
        guard let text = codeTextField.text
        else {
            return
        }
        presenter?.didTapReadyButton(code: text)
    }
    
    @objc func didTapResendButton() {
        presenter?.setTimer()
    }
    
    @objc func didTapAnotherNumberButton() {
        presenter?.didTapAnotherNumberButton()
    }
    
    @objc func didTapSuperView() {
        view.endEditing(true)
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
            if textField == codeTextField {
                if textField.text?.count == 4 {
                    textField.resignFirstResponder()
                }
            }
        }
    
}


// MARK: - UITextFieldDelegate
extension ConfirmeCodeViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        guard let text = textField.text
        else {
            return
        }
        
        guard text.isEmpty ||
                text.count < 4
        else {
            switchStyle(type: .right)
            return
        }
        switchStyle(type: .wrong)
    }
    
}


// MARK: - ConfirmeCodeViewInput
extension ConfirmeCodeViewController: ConfirmeCodeViewInput {
    
    func updateTimer(seconds: Int, isHiddenTimer: Bool) {
        timerLabel.isHidden = isHiddenTimer
        timerLabel.text = String(seconds)
        resendCodeButton.isEnabled = isHiddenTimer
    }
    
    func didFailConfirmCode(errorModel: ErrorModel) {
        presentAlert(title: Locals.alertTitle, message: errorModel.message)
    }
    
}
