//
//  SplashScreenViewController.swift
//  FINCH TAXI
//
//  Created by Marlowe Wind on 02.02.2022.
//

import UIKit

protocol SplashScreenViewInput: AnyObject { }

final class SplashScreenViewController: UIViewController {
    
    // MARK: - Locals
    
    private enum Locals {
        static let logoText = "FINCH taxi"
    }
    
    
    // MARK: - Properties
    
    var presenter: SplashScreenViewOutput?
    
    private let logoLabel = UILabel()
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawSelf()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.viewDidAppear()
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        view.backgroundColor = .white
        
        navigationController?.navigationBar.isHidden = true
        
        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        logoLabel.text = Locals.logoText
        logoLabel.font = UIFont(name: .bold, size: 40)
        logoLabel.textColor = .black
        
        view.addSubview(logoLabel)
        
        NSLayoutConstraint.activate([
            logoLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
    }

}


// MARK: - SplashScreenViewInput
extension SplashScreenViewController: SplashScreenViewInput { }
