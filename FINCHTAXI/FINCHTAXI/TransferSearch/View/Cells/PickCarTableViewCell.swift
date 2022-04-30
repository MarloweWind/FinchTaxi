//
//  PickCarTableViewCell.swift
//  FINCHTAXI
//
//  Created by Marlowe Wind on 21.03.2022.
//

import UIKit

final class PickCarTableViewCell: UITableViewCell {
    
    // MARK: - Properties

    static let profileCellId = String(describing: PickCarTableViewCell.description())
    var collectionViewManager: TransferSearchCollectionViewManagerInput?
    let dataConvetner = TransferSearchCollectionViewDataConventer()
    
    private let layout = UICollectionViewFlowLayout()
    private lazy var pickCarCollectionView = UICollectionView(
        frame: contentView.bounds,
        collectionViewLayout: layout
    )
    
    
    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        collectionViewManager = TransferSearchCollectionViewManager()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        drawSelf()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Drawing
    
    func drawSelf() {
        
        contentView.backgroundColor = .white
        
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12)
        layout.sectionInsetReference = .fromLayoutMargins
        layout.itemSize = CGSize(width: 82, height: 106)
        
        pickCarCollectionView.translatesAutoresizingMaskIntoConstraints = false
        pickCarCollectionView.backgroundColor = .clear
        pickCarCollectionView.showsHorizontalScrollIndicator = false
        pickCarCollectionView.clipsToBounds = false
        
        contentView.addSubview(pickCarCollectionView)
        
        NSLayoutConstraint.activate([
            pickCarCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            pickCarCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            pickCarCollectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 24),
            pickCarCollectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
            pickCarCollectionView.heightAnchor.constraint(equalToConstant: 112),
            ])
        
        collectionViewManager?.setup(collectionView: pickCarCollectionView)
        collectionViewManager?.update(with: dataConvetner.convert(type: .carSearch))
        
    }

}
