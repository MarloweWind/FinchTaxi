//
//  TransferSearchViewModel.swift
//  FINCHTAXI
//
//  Created by Marlowe Wind on 21.03.2022.
//

import Foundation
import UIKit

// MARK: - TransferSearchCollectionViewModel
enum TransferSearchCollectionViewType {
    case pickCarCollection(model: TransferSearchCollectionViewCell.pickCarModel)
    case safetySeatCollection(model: TransferSearchCollectionViewCell.safetySeatModel)
}

struct TransferSearchCollectionViewModel {
    let row: [Row]
}

extension TransferSearchCollectionViewModel {
    
    struct Row {
        let collectionViewType: TransferSearchCollectionViewType
        
        init(collectionViewType: TransferSearchCollectionViewType) {
            self.collectionViewType = collectionViewType
        }
    }
    
}

enum TransferSaerchViewModelType {
    case carSearch
    case safetySeat
    
}


// MARK: - TransferSearchViewModel
enum TransferSearch {
    case transferFromWhere(model: TransferFromWhereTableViewCell.Model)
    case transferDate(model: TransferDateTableViewCell.Model)
    case pickCar
    case moreOptions(model: MoreOptionsTableViewCell.Model)
}

struct TransferSearchViewModel {
    let section: [Section]
    let header: ConfrimHeaderView.Model
}

extension TransferSearchViewModel {
    
    struct Section {
        let rows: [Row]
        let headerHeight: CGFloat
    }
    
    struct Row {
        let transferCell: TransferSearch
        
        init(transferCell: TransferSearch) {
            self.transferCell = transferCell
        }
    }
    
}
