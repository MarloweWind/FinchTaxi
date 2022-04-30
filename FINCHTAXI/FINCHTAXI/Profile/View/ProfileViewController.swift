//
//  ProfileViewController.swift
//  FINCH TAXI
//
//  Created by Marlowe Wind on 09.02.2022.
//

import UIKit

protocol ProfileViewInput: AnyObject {
    func updateView(viewModel: ProfileViewModel)
}

final class ProfileViewController: UIViewController {    
    
    // MARK: - Locals

    private enum Locals {
        static let exitButtonText = "Выйти"
    }
    
    
    // MARK: - Properties
    
    var presenter: ProfileViewOutput?
    var tableViewManager: ProfileTableViewManager?
    
    private let scrollView = UIScrollView()
    private let profileContentView = UIView()
    private let userNameLabel = UILabel()
    private let userPhoneLabel = UILabel()
    private let userPhotoImage = UIImageView()
    private let profileTableView = UITableView()
    private let exitButton = UIButton(type: .system)

    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawSelf()
        presenter?.viewIsReady()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.flashScrollIndicators()
        profileContentView.translatesAutoresizingMaskIntoConstraints = false
        
        navigationItem.setHidesBackButton(true, animated: true)
        navigationController?.navigationBar.isHidden = true

        view.backgroundColor = .white

        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.numberOfLines = 2
        userNameLabel.font = UIFont(name: .bold, size: 40)
        userNameLabel.textColor = .black
        userNameLabel.adjustsFontSizeToFitWidth = true

        userPhoneLabel.translatesAutoresizingMaskIntoConstraints = false
        userPhoneLabel.numberOfLines = 2
        userPhoneLabel.font = UIFont(name: .regular, size: 16)
        userPhoneLabel.textColor = .finchGrey

        userPhotoImage.translatesAutoresizingMaskIntoConstraints = false
        userPhotoImage.backgroundColor = .separatorColor
        userPhotoImage.layer.cornerRadius = 30
        userPhotoImage.clipsToBounds = true

        profileTableView.translatesAutoresizingMaskIntoConstraints = false
        profileTableView.rowHeight = 48
        profileTableView.backgroundColor = .clear
        profileTableView.separatorStyle = .singleLine
        profileTableView.isScrollEnabled = false

        exitButton.translatesAutoresizingMaskIntoConstraints = false
        exitButton.setTitle(Locals.exitButtonText, for: .normal)
        exitButton.tintColor = .black
        exitButton.titleLabel?.font = UIFont(name: .medium, size: 18)
        exitButton.addTarget(self,
                              action: #selector(didTapExitButton),
                              for: .touchUpInside)
        
        view.addSubview(scrollView)
        scrollView.addSubview(profileContentView)
        profileContentView.addSubview(userNameLabel)
        profileContentView.addSubview(userPhoneLabel)
        profileContentView.addSubview(userPhotoImage)
        profileContentView.addSubview(profileTableView)
        profileContentView.addSubview(exitButton)
        
        NSLayoutConstraint.activate([
            
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            profileContentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            profileContentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            profileContentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            profileContentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            userNameLabel.topAnchor.constraint(equalTo: profileContentView.topAnchor, constant: 108),
            userNameLabel.leftAnchor.constraint(equalTo: profileContentView.leftAnchor, constant: 32),
            userNameLabel.rightAnchor.constraint(equalTo: userPhotoImage.leftAnchor, constant: -64),
            userNameLabel.bottomAnchor.constraint(equalTo: userPhoneLabel.topAnchor, constant: -8),

            userPhoneLabel.leftAnchor.constraint(equalTo: profileContentView.leftAnchor, constant: 32),
            userPhoneLabel.topAnchor.constraint(equalTo: userNameLabel.topAnchor, constant: 92),

            userPhotoImage.rightAnchor.constraint(equalTo: profileContentView.rightAnchor, constant: -32),
            userPhotoImage.topAnchor.constraint(equalTo: profileContentView.topAnchor, constant: 116),
            userPhotoImage.heightAnchor.constraint(equalToConstant: 60),
            userPhotoImage.widthAnchor.constraint(equalToConstant: 60),

            profileTableView.topAnchor.constraint(equalTo: userPhoneLabel.topAnchor, constant: 108),
            profileTableView.leftAnchor.constraint(equalTo: profileContentView.leftAnchor, constant: 32),
            profileTableView.rightAnchor.constraint(equalTo: profileContentView.rightAnchor, constant: 0),
            profileTableView.heightAnchor.constraint(equalToConstant: 192),

            exitButton.topAnchor.constraint(equalTo: profileTableView.bottomAnchor, constant: 64),
            exitButton.leftAnchor.constraint(equalTo: profileContentView.leftAnchor, constant: 36),
            exitButton.bottomAnchor.constraint(equalTo: profileContentView.bottomAnchor, constant: -60)
            ])
        
        tableViewManager?.setup(tableView: profileTableView)
    }
    
    
    // MARK: - Actions
    
    @objc func didTapExitButton() {
        presenter?.didTapExitButton()
    }
    
}


// MARK: - ProfileViewInput
extension ProfileViewController: ProfileViewInput {
    func updateView(viewModel: ProfileViewModel) {
        userPhotoImage.image = viewModel.image
        userNameLabel.text = viewModel.name + "\n" + viewModel.surname
        userPhoneLabel.text = viewModel.phone
        tableViewManager?.update(with: viewModel)
    }
}
