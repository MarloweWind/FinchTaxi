//
//  OptionView.swift
//  FINCHTAXI
//
//  Created by Marlowe Wind on 23.03.2022.
//

import UIKit

protocol OptionViewOutput: AnyObject {
    func setContentOffsetY(y: CGFloat)
}

final class OptionView: UIView {
    
    // MARK: - Types
    
    enum OptionTextFieldType {
        case numpad
        case defaultKeyBoard
    }
    
    
    // MARK: - Properties

    private let optionLabel = UILabel()
    private let optionTextField = UITextField()
    private let optionSeparator = UIView()
    
    weak var optionViewDelegate: OptionViewOutput?
    private var placeHolder = ""
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawSelf()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Drawing
    
    func drawSelf() {
        
        optionLabel.translatesAutoresizingMaskIntoConstraints = false
        optionLabel.font = UIFont(name: .regular, size: 16)
        optionLabel.textColor = .finchLighGrey
        
        optionTextField.translatesAutoresizingMaskIntoConstraints = false
        optionTextField.font = UIFont(name: .medium, size: 20)
        optionTextField.textColor = .black
        optionTextField.delegate = self
        optionTextField.autocorrectionType = .no
        optionTextField.clearsOnBeginEditing = false
        optionTextField.autocapitalizationType = .sentences

        optionSeparator.translatesAutoresizingMaskIntoConstraints = false
        optionSeparator.backgroundColor = .separatorColor
        
        addSubview(optionLabel)
        addSubview(optionTextField)
        addSubview(optionSeparator)
        
        
        NSLayoutConstraint.activate([
            
            optionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 36),
            optionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 32),
            optionLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -32),
            
            optionTextField.topAnchor.constraint(equalTo: optionLabel.bottomAnchor, constant: 8),
            optionTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 32),
            optionTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -32),
            
            optionSeparator.topAnchor.constraint(equalTo: optionTextField.bottomAnchor, constant: 12),
            optionSeparator.leftAnchor.constraint(equalTo: leftAnchor, constant: 32),
            optionSeparator.widthAnchor.constraint(equalToConstant: 170),
            optionSeparator.heightAnchor.constraint(equalToConstant: 0.5),
            optionSeparator.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)

            ])
    }
    
}


// MARK: - Configurable
extension OptionView: Configurable {
    
    func configure(with model: Model) {
        optionLabel.text = model.labelText
        optionTextField.attributedPlaceholder = NSAttributedString(
            string: model.textFieldPlaceholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.finchGrey])
        placeHolder = model.textFieldPlaceholder
        
        switch model.textFieldType {
            
        case .numpad:
            optionTextField.keyboardType = .numberPad
            
        case .defaultKeyBoard:
            optionTextField.keyboardType = .default
        }
    }
    
    func configureTextFieldText(text: String) {
        optionTextField.text = text
    }
    
    func configureInputAccessoryView(view: UIView) {
        optionTextField.inputAccessoryView = view
    }
    
    func configureResignFirstResponder() {
        optionTextField.resignFirstResponder()
    }
    
    func configureCurrency() {
        guard let text = optionTextField.text
        else {
            return
        }
        
        if optionTextField.text?.contains("₽") != true {
            if optionTextField.text?.isEmpty == true {
                optionTextField.text = ""
            } else {
                optionTextField.text = (text) + "₽"
            }
        }
    }
    
    struct Model {
        let textFieldType: OptionTextFieldType
        let labelText: String
        let textFieldPlaceholder: String
    }
    
}


// MARK: - UITextFieldDelegate
extension OptionView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.placeholder = ""
        let y = frame.origin.y + 291
        optionViewDelegate?.setContentOffsetY(y: y)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.attributedPlaceholder = NSAttributedString(
            string: placeHolder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.finchGrey])
        let y = frame.origin.y
        optionViewDelegate?.setContentOffsetY(y: y)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            return self.textLimit(existingText: textField.text, newText: string, limit: 40)
        }
                
    func textLimit(existingText: String?, newText: String, limit: Int) -> Bool {
        let text = existingText ?? ""
        let isAtLimit = text.count + newText.count <= limit
        return isAtLimit
    }

}
