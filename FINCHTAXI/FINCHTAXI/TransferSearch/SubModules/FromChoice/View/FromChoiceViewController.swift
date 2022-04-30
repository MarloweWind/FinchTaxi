//
//  FromChoiceViewController.swift
//  FINCHTAXI
//
//  Created by Marlowe Wind on 08.04.2022.
//

import UIKit

protocol FromChoiceViewInput: AnyObject {
    func updateView(viewModel: FromChoiceViewModel)
}

final class FromChoiceViewController: UIViewController {
    
    // MARK: - Locals
    
    private enum Locals {
        static let closeText = "Закрыть"
        static let placeHoldertext = "Адрес начала поездки"
        static let mapText = "Указать на карте"
    }
    
    
    // MARK: - Properties
    
    var presenter: FromChoiceViewOutput?
    var tableViewManager: FromChoiceTableViewManager?
    
    private let closeButton = UIButton(type: .system)
    private let locationTableView = UITableView()
    private let directionTextField = UITextField()
    private let topSeparatorView = UIView()
    private let bottomSeparatorView = UIView()
    private let mapButton = UIButton(type: .system)

    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawSelf()
        presenter?.viewIsReady()
    }
    
    
    // MARK: - Drawing

    func drawSelf() {
        
        view.backgroundColor = .white
        view.layer.cornerRadius = 8.8
        view.layer.maskedCorners = [ .layerMaxXMinYCorner, .layerMinXMinYCorner ]
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setTitle(Locals.closeText, for: .normal)
        closeButton.titleLabel?.font = UIFont(name: .medium, size: 16)
        closeButton.tintColor = .black
        closeButton.addTarget(self,
                              action: #selector(didTapCloseButton),
                              for: .touchUpInside)
        
        directionTextField.translatesAutoresizingMaskIntoConstraints = false
        directionTextField.attributedPlaceholder = NSAttributedString(
            string: Locals.placeHoldertext,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.finchGrey]
        )
        directionTextField.font = UIFont(name: .regular, size: 16)
        directionTextField.textColor = .black
        directionTextField.delegate = self
        directionTextField.autocorrectionType = .no
        directionTextField.keyboardType = .namePhonePad
        directionTextField.becomeFirstResponder()
        
        topSeparatorView.translatesAutoresizingMaskIntoConstraints = false
        topSeparatorView.backgroundColor = .separatorColor
        
        locationTableView.translatesAutoresizingMaskIntoConstraints = false
        locationTableView.backgroundColor = .clear
        locationTableView.separatorStyle = .none
        locationTableView.rowHeight = 300
        locationTableView.rowHeight = UITableView.automaticDimension
        locationTableView.estimatedRowHeight = 80
        
        bottomSeparatorView.translatesAutoresizingMaskIntoConstraints = false
        bottomSeparatorView.backgroundColor = .separatorColor
        
        mapButton.translatesAutoresizingMaskIntoConstraints = false
        mapButton.setTitle(Locals.mapText, for: .normal)
        mapButton.titleLabel?.font = UIFont(name: .medium, size: 16)
        mapButton.tintColor = .black
        mapButton.backgroundColor = .clear
        mapButton.addTarget(self,
                              action: #selector(didTapMapButton),
                              for: .touchUpInside)
        
        view.addSubview(closeButton)
        view.addSubview(directionTextField)
        view.addSubview(topSeparatorView)
        view.addSubview(locationTableView)
        view.addSubview(bottomSeparatorView)
        view.addSubview(mapButton)
        
        NSLayoutConstraint.activate([
            closeButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -18),
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            
            directionTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            directionTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            
            topSeparatorView.topAnchor.constraint(equalTo: directionTextField.bottomAnchor, constant: 16),
            topSeparatorView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            topSeparatorView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            topSeparatorView.heightAnchor.constraint(equalToConstant: 0.5),
            
            locationTableView.topAnchor.constraint(equalTo: topSeparatorView.bottomAnchor, constant: 16),
            locationTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            locationTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            locationTableView.bottomAnchor.constraint(equalTo: bottomSeparatorView.topAnchor, constant: 0),
            
            bottomSeparatorView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            bottomSeparatorView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            bottomSeparatorView.heightAnchor.constraint(equalToConstant: 0.5),
            bottomSeparatorView.bottomAnchor.constraint(equalTo: mapButton.topAnchor, constant: -10),
            
            mapButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            mapButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
            ])
        
        tableViewManager?.setup(tableView: locationTableView)
        
    }

    
    // MARK: - Actions
    
    @objc func didTapCloseButton() {
        presenter?.didTapBackButton()
    }
    
    @objc func didTapMapButton() {
        presenter?.didTapMapButton()
    }

}


// MARK: - FromChoiceViewInput
extension FromChoiceViewController: FromChoiceViewInput {
    func updateView(viewModel: FromChoiceViewModel) {
        directionTextField.text = viewModel.mapLocationName
        tableViewManager?.update(with: viewModel)
    }
}


// MARK: - UITextFieldDelegate
extension FromChoiceViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        presenter?.updatePlaceMark(to: textField.text ?? "")
    }
}
