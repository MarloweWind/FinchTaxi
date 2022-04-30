//
//  TransferSearchViewController.swift
//  FINCH TAXI
//
//  Created by Marlowe Wind on 02.02.2022.
//

import UIKit

protocol TransferSearchViewInput: AnyObject {
    func updateView(viewModel: TransferSearchViewModel)
}

final class TransferSearchViewController: UIViewController {
    
    // MARK: - Locals
    
    private enum Locals {
        static let largeTitleText = "Куда поедем?"
    }
    
    
    // MARK: - Properties
    
    var presenter: TransferSearchViewOutput?
    var tableViewManager: TransferSearchTableViewManager?
    
    private let transferTableView = UITableView(frame: .zero, style: .grouped)
    private let scrollEdgeAppearance = UINavigationBarAppearance()
    private let standartAppearance = UINavigationBarAppearance()
    

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawSelf()
        presenter?.viewIsReady()
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
                
        setUpNavigationBarAppearance(scrollEdgeAppearance, backGroundColor: .white)
        setUpNavigationBarAppearance(standartAppearance, backGroundColor: .fincWhite)
        
        navigationItem.setHidesBackButton(true, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.title = Locals.largeTitleText
        navigationController?.navigationBar.layoutMargins.left = 32
        navigationController?.navigationBar.scrollEdgeAppearance = scrollEdgeAppearance
        navigationController?.navigationBar.standardAppearance = standartAppearance
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont(name: .bold, size: 40) as Any
        ]
        
        view.backgroundColor = .white
        
        transferTableView.translatesAutoresizingMaskIntoConstraints = false
        transferTableView.backgroundColor = .clear
        transferTableView.separatorStyle = .none
        transferTableView.rowHeight = UITableView.automaticDimension
        transferTableView.estimatedRowHeight = 112
        
        view.addSubview(transferTableView)
        
        NSLayoutConstraint.activate([
            
            transferTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            transferTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            transferTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            transferTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
            ])
        
        tableViewManager?.setup(tableView: transferTableView)
        
    }
    
    
    // MARK: - Private methods
    
    private func setUpNavigationBarAppearance(_ appearance: UINavigationBarAppearance, backGroundColor: UIColor) {
        appearance.backgroundColor = backGroundColor
        appearance.shadowColor = .clear
    }

}


// MARK: - TransferSearchViewInput
extension TransferSearchViewController: TransferSearchViewInput {
    func updateView(viewModel: TransferSearchViewModel) {
        tableViewManager?.update(with: viewModel)
    }
}
