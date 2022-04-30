//
//  ConfrimHeaderView.swift
//  FINCHTAXI
//
//  Created by Marlowe Wind on 07.04.2022.
//

import UIKit

protocol ConfirmTransferHeaderOutput: AnyObject {
    func addOption()
    func lessOption()
    func moveToMoreOptions()
    func moveToLessOptions()
    func moveToTextField(point: CGPoint)
}

final class ConfrimHeaderView: UIView {
    
    // MARK: - Properties
    
    weak var confirmTransferDelegate: ConfirmTransferHeaderOutput?
    
    private let confirmTransferButton = UIButton(type: .system)
    private let addOptionsButton = UIButton(type: .system)
    private let lessOptionsButton = UIButton(type: .system)
        
    
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
        
        backgroundColor = .clear
        
        confirmTransferButton.translatesAutoresizingMaskIntoConstraints = false
        confirmTransferButton.tintColor = .black
        confirmTransferButton.layer.cornerRadius = 21
        confirmTransferButton.titleLabel?.font = UIFont(name: .regular, size: 16)
        confirmTransferButton.backgroundColor = .buttonColor
        
        setupOptionButton(addOptionsButton,
                          action: #selector(didTapAddOptionsButton))
        
        setupOptionButton(lessOptionsButton,
                          action: #selector(didTapLessOptionsButton))

    }
    
    
    // MARK: - Private methods
    
    private func setupOptionButton(_ button: UIButton, action: Selector) {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        button.layer.cornerRadius = 21
        button.titleLabel?.font = UIFont(name: .regular, size: 16)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.backgroundColor = .white
        button.addTarget(self,
                              action: action,
                              for: .touchUpInside)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.buttonColor.cgColor
    }
    
    
    // MARK: - Actions
    
    @objc func didTapAddOptionsButton() {
        confirmTransferDelegate?.addOption()
        confirmTransferDelegate?.moveToMoreOptions()
    }

    @objc func didTapLessOptionsButton() {
        confirmTransferDelegate?.lessOption()
        confirmTransferDelegate?.moveToMoreOptions()
    }
    
    
}


// MARK: - Configurable
extension ConfrimHeaderView {
    func configure(with model: Model) {
        confirmTransferButton.setTitle(model.confirmTransferButtonText, for: .normal)
        addOptionsButton.setTitle(model.addOptionsButtonText, for: .normal)
        lessOptionsButton.setTitle(model.lessOptionsButtonText, for: .normal)
    }
    
    func configureConfigureHeaderType(with model: TypeModel) {
        switch model.confirmHeaderType {
        case .addOptions:
            addSubview(confirmTransferButton)
            addSubview(addOptionsButton)
            NSLayoutConstraint.activate([
                confirmTransferButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 32),
                confirmTransferButton.topAnchor.constraint(equalTo: topAnchor, constant: 0),
                confirmTransferButton.widthAnchor.constraint(equalToConstant: 120),
                confirmTransferButton.heightAnchor.constraint(equalToConstant: 42),

                addOptionsButton.leftAnchor.constraint(equalTo: confirmTransferButton.rightAnchor, constant: 16),
                addOptionsButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
                addOptionsButton.topAnchor.constraint(equalTo: topAnchor, constant: 0),
                addOptionsButton.heightAnchor.constraint(equalToConstant: 42)
                ])
        case .lessOptions:
            addSubview(lessOptionsButton)
            NSLayoutConstraint.activate([
                lessOptionsButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
                lessOptionsButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
                lessOptionsButton.topAnchor.constraint(equalTo: topAnchor, constant: 0),
                lessOptionsButton.heightAnchor.constraint(equalToConstant: 42)
                ])
        }
    }
    
    struct Model {
        let confirmTransferButtonText: String
        let addOptionsButtonText: String
        let lessOptionsButtonText: String
    }
    
    struct TypeModel {
        let confirmHeaderType: ConfirmHeaderType
    }
}
