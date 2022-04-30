//
//  TransferSearchTableViewManager.swift
//  FINCHTAXI
//
//  Created by Marlowe Wind on 21.03.2022.
//

import UIKit

protocol TransferSearchTableViewManagerDelegate: AnyObject {
    func didTapPresentFromView(locationType: LocationType)
}

protocol TransferSearchTableViewManagerInput {
    func setup(tableView: UITableView)
    func update(with viewModel: TransferSearchViewModel)
}

final class TransferSearchTableViewManager: NSObject {
    
    // MARK: - Properties
    
    weak var delegate: TransferSearchTableViewManagerDelegate?
    
    private weak var tableView: UITableView?
    private var viewModel: TransferSearchViewModel?
    private var hiddenState = true
    
}


// MARK: - TransferSearchTableViewManagerInput
extension TransferSearchTableViewManager: TransferSearchTableViewManagerInput {
    
    func setup(tableView: UITableView) {
        tableView.register(TransferFromWhereTableViewCell.self,
                           forCellReuseIdentifier: TransferFromWhereTableViewCell.profileCellId)
        tableView.register(TransferDateTableViewCell.self,
                           forCellReuseIdentifier: TransferDateTableViewCell.profileCellId)
        tableView.register(PickCarTableViewCell.self,
                           forCellReuseIdentifier: PickCarTableViewCell.profileCellId)
        tableView.register(MoreOptionsTableViewCell.self,
                           forCellReuseIdentifier: MoreOptionsTableViewCell.profileCellId)
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView = tableView
    }
    
    func update(with viewModel: TransferSearchViewModel) {
        self.viewModel = viewModel
        tableView?.reloadData()
    }
    
}


// MARK: - UITableViewDataSource
extension TransferSearchTableViewManager: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return viewModel?.section.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.section[section].rows.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let section = viewModel?.section[indexPath.section]
        else {
            return UITableViewCell()
        }
        
        let row = section.rows[indexPath.row]
        
            switch row.transferCell {
            case .transferFromWhere(model: let model):
                guard let fromWhereCell = tableView.dequeueReusableCell(withIdentifier: TransferFromWhereTableViewCell.profileCellId,
                                                                        for: indexPath) as? TransferFromWhereTableViewCell
                else {
                    return UITableViewCell()
                }
                fromWhereCell.transferFromWhereDelegate = self
                fromWhereCell.configure(with: model)
                return fromWhereCell
                
            case .transferDate(model: let model):
                guard let dateCell = tableView.dequeueReusableCell(withIdentifier: TransferDateTableViewCell.profileCellId,
                                                                     for: indexPath) as? TransferDateTableViewCell
                else {
                    return UITableViewCell()
                }
                dateCell.configure(with: model)
                return dateCell
                
            case .pickCar:
                guard let pickCarCell = tableView.dequeueReusableCell(withIdentifier: PickCarTableViewCell.profileCellId,
                                                                      for: indexPath) as? PickCarTableViewCell
                else {
                    return UITableViewCell()
                }
                return pickCarCell
                
            case .moreOptions(model: let model):
                guard let moreOptionsCell = tableView.dequeueReusableCell(withIdentifier: MoreOptionsTableViewCell.profileCellId,
                                                                          for: indexPath) as? MoreOptionsTableViewCell
                else {
                    return UITableViewCell()
                }
                moreOptionsCell.confirmTransferDelegate = self
                moreOptionsCell.configure(with: model)
                
                switch hiddenState {
                case true:
                    return UITableViewCell()
                    
                case false:
                    return moreOptionsCell
                }
        }

    }
    
}


// MARK: - UITableViewDelegate
extension TransferSearchTableViewManager: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let transferSearchSection = viewModel?.section
        else {
            return 0
        }
        
        switch section {
        case 0:
            return transferSearchSection[0].headerHeight

        case 1:
            return transferSearchSection[1].headerHeight

        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return UIView()
            
        case 1:
            switch hiddenState {
            case true:
                let headerView = ConfrimHeaderView()
                headerView.confirmTransferDelegate = self
                guard let model = viewModel?.header
                else {
                    return UIView()
                }

                headerView.configure(with: model)
                headerView.configureConfigureHeaderType(with: ConfrimHeaderView.TypeModel(confirmHeaderType: .addOptions))
                return headerView
                
            case false:
                let headerView = ConfrimHeaderView()
                headerView.confirmTransferDelegate = self
                guard let model = viewModel?.header
                else {
                    return UIView()
                }

                headerView.configure(with: model)
                headerView.configureConfigureHeaderType(with: ConfrimHeaderView.TypeModel(confirmHeaderType: .lessOptions))
                return headerView
            }

        default:
            return UIView()
        }
    }
}


// MARK: - ConfirmTransferTableViewCellOutput
extension TransferSearchTableViewManager: ConfirmTransferHeaderOutput {
    func addOption() {
        hiddenState = false
        tableView?.reloadData()
    }
    
    func lessOption() {
        hiddenState = true
        tableView?.reloadData()
    }
    
    func moveToMoreOptions() {
        let indexPath = IndexPath(row: 0, section: 1)
        tableView?.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    func moveToLessOptions() {
        let indexPath = IndexPath(row: 0, section: 0)
        tableView?.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    func moveToTextField(point: CGPoint) {
        tableView?.setContentOffset(point, animated: true)
    }
}


// MARK: - TransferFromWhereDelegate
extension TransferSearchTableViewManager: TransferFromWhereDelegate {
    func didTapPresentFromView(locationType: LocationType) {
        delegate?.didTapPresentFromView(locationType: locationType)
    }
}
