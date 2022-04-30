//
//  UserDataViewController.swift
//  FINCH TAXI
//
//  Created by Marlowe Wind on 14.02.2022.
//

import UIKit

protocol UserDataViewInput: AnyObject {
    func didFailToUpdateProfile(errorModel: ErrorModel)
}

class UserDataViewController: UIViewController {
    
    // MARK: - Locals

    private enum Locals {
        static let infoText = "Ваши данные"
        static let namePlaceholderText = "Имя"
        static let surnamePlaceholderText = "Фамилия"
        static let confirmText = "Подтвердить"
        static let changePhotoText = "Выберите фото"
        static let readyText = "Готово"
        static let backtext = "Назад"
        static let alertTitle = "Внимание"
        static let emptyNameTextFIeldText = "Введите ваши данные"
    }
    
    
    // MARK: - Properties
    
    var presenter: UserDataViewOutput?
    var imagePicker: ImagePicker?
    weak var delegate: UserDataDelegate?
    
    private let infoLabel = UILabel()
    private let userPhotoImage = UIImageView()
    private let changePhotoButton = UIButton(type: .system)
    private let nameTextField = UITextField()
    private let surnameTextField = UITextField()
    private let separatorView = UIView()
    private let confirmButton = UIButton(type: .system)
    private let backButtonItem = UIBarButtonItem()
    
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        drawSelf()
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        view.backgroundColor = .white
        
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.view.backgroundColor = .clear
        navigationController?.navigationBar.isTranslucent = true
        
        backButtonItem.title = Locals.backtext
        backButtonItem.tintColor = .black
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButtonItem
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapSuperView))
        view.addGestureRecognizer(tapGesture)
        
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(
            x: 0, y: 0,
            width: UIScreen.main.bounds.width,
            height: 40))
        doneToolbar.barStyle = .default
        let flexSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(
            title: Locals.readyText,
            style: .done,
            target: self,
            action: #selector(self.doneButtonAction))
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        nameTextField.inputAccessoryView = doneToolbar
        surnameTextField.inputAccessoryView = doneToolbar
        
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.text = Locals.infoText
        infoLabel.font = UIFont(name: .bold, size: 40)
        infoLabel.textColor = .black
        infoLabel.adjustsFontSizeToFitWidth = true
        
        userPhotoImage.translatesAutoresizingMaskIntoConstraints = false
        userPhotoImage.backgroundColor = .separatorColor
        userPhotoImage.layer.cornerRadius = 30
        userPhotoImage.clipsToBounds = true
        userPhotoImage.image = presenter?.getUserPhoto()
        
        changePhotoButton.translatesAutoresizingMaskIntoConstraints = false
        changePhotoButton.setTitle(Locals.changePhotoText, for: .normal)
        changePhotoButton.tintColor = .black
        changePhotoButton.layer.cornerRadius = 21
        changePhotoButton.titleLabel?.font = UIFont(name: .regular, size: 16)
        changePhotoButton.backgroundColor = .buttonColor
        changePhotoButton.addTarget(self,
                              action: #selector(didTapchangePhotoButton),
                              for: .touchUpInside)
        
        setupUserNameTextField(nameTextField, placeHolder: Locals.namePlaceholderText)
        
        setupUserNameTextField(surnameTextField, placeHolder: Locals.surnamePlaceholderText)
        
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.backgroundColor = .separatorColor
        
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.setTitle(Locals.confirmText, for: .normal)
        confirmButton.tintColor = .black
        confirmButton.layer.cornerRadius = 21
        confirmButton.titleLabel?.font = UIFont(name: .regular, size: 16)
        confirmButton.backgroundColor = .buttonColor
        confirmButton.addTarget(self,
                              action: #selector(didTapConfirmButton),
                              for: .touchUpInside)
        
        view.addSubview(infoLabel)
        view.addSubview(userPhotoImage)
        view.addSubview(changePhotoButton)
        view.addSubview(nameTextField)
        view.addSubview(surnameTextField)
        view.addSubview(separatorView)
        view.addSubview(confirmButton)
        
        NSLayoutConstraint.activate([
            infoLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            infoLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            infoLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
            
            userPhotoImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            userPhotoImage.bottomAnchor.constraint(equalTo: nameTextField.topAnchor, constant: -16),
            userPhotoImage.heightAnchor.constraint(equalToConstant: 60),
            userPhotoImage.widthAnchor.constraint(equalToConstant: 60),
            
            changePhotoButton.leftAnchor.constraint(equalTo: userPhotoImage.rightAnchor, constant: 32),
            changePhotoButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
            changePhotoButton.centerYAnchor.constraint(equalTo: userPhotoImage.centerYAnchor),
            changePhotoButton.heightAnchor.constraint(equalToConstant: 42),
            
            nameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
            nameTextField.bottomAnchor.constraint(equalTo: surnameTextField.topAnchor, constant: -16),
            
            surnameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            surnameTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
            surnameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            separatorView.topAnchor.constraint(equalTo: surnameTextField.bottomAnchor, constant: 16),
            separatorView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            separatorView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
            separatorView.heightAnchor.constraint(equalToConstant: 0.5),
            
            confirmButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 74),
            confirmButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -74),
            confirmButton.topAnchor.constraint(equalTo: surnameTextField.bottomAnchor, constant: 92),
            confirmButton.heightAnchor.constraint(equalToConstant: 42)
            ])
    }
    
    
    // MARK: - Private methods
    
    private func setupUserNameTextField(_ textField: UITextField, placeHolder: String) {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = NSAttributedString(
            string: placeHolder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.finchGrey]
        )
        textField.font = UIFont(name: .regular, size: 16)
        textField.textColor = .black
        textField.autocapitalizationType = .words
        textField.autocorrectionType = .no
        textField.clearsOnBeginEditing = true
    }
    
    
    // MARK: - Actions
    
    @objc func didTapConfirmButton() {
        
        guard
        let nameText = nameTextField.text,
        let surnameTextt = surnameTextField.text
        else {
            return
        }
        
        if surnameTextField.text?.isEmpty == true {
            presentAlert(title: Locals.alertTitle, message: Locals.emptyNameTextFIeldText)
        } else {
            presenter?.didTapConfirmButton(name: nameText, surname: surnameTextt)
        }
        
    }
    
    @objc func didTapchangePhotoButton() {
        imagePicker = ImagePicker(presentationController: self, delegate: self)
        imagePicker?.present(from: changePhotoButton)
    }
    
    @objc func didTapSuperView() {
        view.endEditing(true)
    }

    @objc func doneButtonAction(){
        nameTextField.resignFirstResponder()
        surnameTextField.resignFirstResponder()
    }
    
}


// MARK: - UserDataViewInput
extension UserDataViewController: UserDataViewInput {
    func didFailToUpdateProfile(errorModel: ErrorModel) {
        presentAlert(title: Locals.alertTitle, message: errorModel.message)
    }
}


// MARK: - ImagePickerDelegate
extension UserDataViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        guard let image = image
        else {
            return
        }
        userPhotoImage.image = image
        presenter?.didSetUserPhoto(image: image, fileName: "image")
    }
    
}
