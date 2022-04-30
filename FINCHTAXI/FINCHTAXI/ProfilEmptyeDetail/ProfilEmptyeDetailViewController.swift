//
//  ProfilEmptyeDetailViewController.swift
//  FINCH TAXI
//
//  Created by Marlowe Wind on 14.02.2022.
//

import UIKit

final class ProfilEmptyeDetailViewController: UIViewController {
    
    // MARK: - Locals

    private enum Locals {
        static let backtext = "Назад"
    }
    
    
    // MARK: - Properties
    
    private let backButtonItem = UIBarButtonItem()
    
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.view.backgroundColor = .clear
        navigationController?.navigationBar.isTranslucent = true
        
        backButtonItem.title = Locals.backtext
        backButtonItem.tintColor = .black
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButtonItem
    }

}
