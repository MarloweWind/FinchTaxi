//
//  FromChoiceTableViewManager.swift
//  FINCHTAXI
//
//  Created by Marlowe Wind on 12.04.2022.
//

import UIKit

protocol FromChoiceTableViewManagerDelegate: AnyObject {
    func didTapLocationCell(fromTransferName: String)
}

protocol FromChoiceTableViewManagerInput {
    func setup(tableView: UITableView)
    func update(with viewModel: FromChoiceViewModel)
}

final class FromChoiceTableViewManager: NSObject {

    // MARK: - Types

    struct Location {
        var locationName: String
        var locationDetail: String
    }


    // MARK: - Properties

    weak var delegate: FromChoiceTableViewManagerDelegate?

    private weak var tableView: UITableView?
    private var viewModel: FromChoiceViewModel?

}


// MARK: - FromChoiceTableViewManagerInput
extension FromChoiceTableViewManager: FromChoiceTableViewManagerInput {

    func setup(tableView: UITableView) {
        tableView.register(LocationTableViewCell.self, forCellReuseIdentifier: LocationTableViewCell.profileCellId)
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView = tableView
    }

    func update(with viewModel: FromChoiceViewModel) {
        self.viewModel = viewModel

        tableView?.reloadData()
    }
    
}


// MARK: - UITableViewDataSource
extension FromChoiceTableViewManager: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.rows.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.profileCellId, for: indexPath) as? LocationTableViewCell,
              let rows = viewModel?.rows[indexPath.row]
        else {
            return UITableViewCell()
        }

        let model = LocationTableViewCell.Model(locationName: rows.locationName , locationDetail: rows.locationDetail)
        cell.configure(with: model)

        return cell
    }

}


// MARK: - UITableViewDelegate
extension FromChoiceTableViewManager: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let rows = viewModel?.rows[indexPath.row]
        else {
            return
        }
        delegate?.didTapLocationCell(fromTransferName: rows.locationName)
    }
}
