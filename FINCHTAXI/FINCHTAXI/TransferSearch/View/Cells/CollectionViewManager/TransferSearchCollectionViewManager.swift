//
//  TransferSearchCollectionViewManager.swift
//  FINCHTAXI
//
//  Created by Marlowe Wind on 06.04.2022.
//

import UIKit

protocol TransferSearchCollectionViewManagerInput {
    func setup(collectionView: UICollectionView)
    func update(with viewModel: TransferSearchCollectionViewModel)
}

final class TransferSearchCollectionViewManager: NSObject {
    
    // MARK: - Properties
        
    private weak var collectionView: UICollectionView?
    private var viewModel: TransferSearchCollectionViewModel?
        
}


// MARK: - PickCarCollectionViewManagerInput
extension TransferSearchCollectionViewManager: TransferSearchCollectionViewManagerInput {

    func setup(collectionView: UICollectionView) {
        collectionView.register(TransferSearchCollectionViewCell.self,
                                forCellWithReuseIdentifier: TransferSearchCollectionViewCell.profileCellId)
        collectionView.dataSource = self
        self.collectionView = collectionView
    }
    
    func update(with viewModel: TransferSearchCollectionViewModel) {
        self.viewModel = viewModel
    }
    
}


// MARK: - UICollectionViewDataSource
extension TransferSearchCollectionViewManager: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.row.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let row = viewModel?.row[indexPath.item]
        
        switch row?.collectionViewType {
        case .pickCarCollection(model: let model):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TransferSearchCollectionViewCell.profileCellId,
                                                                for: indexPath) as? TransferSearchCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            
            collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: [])
            
            cell.configurePickCar(with: model)
            return cell
            
        case .safetySeatCollection(model: let model):
            guard let safetySeatCell = collectionView.dequeueReusableCell(withReuseIdentifier: TransferSearchCollectionViewCell.profileCellId,
                                                                          for: indexPath) as? TransferSearchCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            
            collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: [])
            
            safetySeatCell.configureSafetySeat(with: model)
            safetySeatCell.safetySeatDelegate = self
            return safetySeatCell
            
        case .none:
            return UICollectionViewCell()
        }
        
    }
    
}


// MARK: - SafetySeatCollectionViewCellOutput
extension TransferSearchCollectionViewManager: SafetySeatCollectionViewCellOutput {
    func selectItem(cell: TransferSearchCollectionViewCell) {
        let safetyIndexPath = collectionView?.indexPath(for: cell)
        collectionView?.selectItem(at: safetyIndexPath, animated: false, scrollPosition: [])
    }
}

