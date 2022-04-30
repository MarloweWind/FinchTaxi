//
//  ProfileTableViewManager.swift
//  FINCH TAXI
//
//  Created by Marlowe Wind on 14.02.2022.
//

import UIKit

protocol ProfileTableViewManagerDelegate: AnyObject {
    func didTapProfilEmptyeDetail()
    func didTapUserData()
}

protocol ProfileTableViewManagerInput {
    func setup(tableView: UITableView)
    func update(with viewModel: ProfileViewModel)
}

final class ProfileTableViewManager: NSObject {    
    
    // MARK: - Properties
    
    weak var delegate: ProfileTableViewManagerDelegate?
    
    private weak var tableView: UITableView?
    private var viewModel: ProfileViewModel?
    
}


// MARK: - ProfileTableViewManagerInput
extension ProfileTableViewManager: ProfileTableViewManagerInput {
    
    func setup(tableView: UITableView) {
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.profileCellId)
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView = tableView
    }
    
    func update(with viewModel: ProfileViewModel) {
        self.viewModel = viewModel
    }
    
}


// MARK: - UITableViewDataSource
extension ProfileTableViewManager: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.rows.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.profileCellId, for: indexPath) as? ProfileTableViewCell,
              let row = viewModel?.rows[indexPath.row]
        else {
            return UITableViewCell()
        }
        
        let model = ProfileTableViewCell.Model(menuName: row.profileName)
        
        cell.configure(with: model)
        cell.separatorInset = .zero
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        
        return cell
    }
    
}


// MARK: - UITableViewDelegate
extension ProfileTableViewManager: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let row = viewModel?.rows[indexPath.row] else {
            return
        }
        
        switch row.selectType {
        case .userInfo:
            delegate?.didTapUserData()
        case .others:
            delegate?.didTapProfilEmptyeDetail()
        }
        
    }
    
}
