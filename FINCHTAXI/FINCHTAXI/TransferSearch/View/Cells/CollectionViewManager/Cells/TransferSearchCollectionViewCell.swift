//
//  TransferSearchCollectionViewCell.swift
//  FINCHTAXI
//
//  Created by Marlowe Wind on 06.04.2022.
//

import UIKit

protocol SafetySeatCollectionViewCellOutput: AnyObject {
    func selectItem(cell: TransferSearchCollectionViewCell)
}

final class TransferSearchCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let profileCellId = String(describing: TransferSearchCollectionViewCell.description())
    weak var safetySeatDelegate: SafetySeatCollectionViewCellOutput?
    override var isSelected: Bool {
            didSet {
                pickCarView.backgroundColor = isSelected ? .fincWhite : .white
            }
        }
    
    private let pickCarView = PickCarView()
    
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        drawSelf()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Drawing
    
    func drawSelf() {
        
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 10
        
        pickCarView.backgroundColor = .white
        pickCarView.pickCarViewDelegate = self
        
        pickCarView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(pickCarView)
        
        NSLayoutConstraint.activate([
            pickCarView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            pickCarView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
            pickCarView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
            pickCarView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            ])
    }
    
}


// MARK: - Configurable
extension TransferSearchCollectionViewCell {
    
    func configurePickCar(with model: pickCarModel) {
        let cellType = PickCarView.Model(cellType: .pickCar)
        pickCarView.configure(with: cellType)
        pickCarView.carLabel.text = model.carTypeText
        pickCarView.carPriceLabel.text = model.carPriceText
        pickCarView.peopleCountLabel.text = model.carPeopleCounttext
    }
    
    func configureSafetySeat(with model: safetySeatModel) {
        let cellType = PickCarView.Model(cellType: .safetySeat)
        pickCarView.configure(with: cellType)
        pickCarView.carLabel.text = model.childAgeText
    }

    struct pickCarModel {
        let carTypeText: String
        let carPriceText: String
        let carPeopleCounttext: String
    }
    
    struct safetySeatModel {
        let childAgeText: String
    }
    
}


// MARK: - PickCarViewOutput
extension TransferSearchCollectionViewCell: PickCarViewOutput {
    func cellIsSelected() {
        safetySeatDelegate?.selectItem(cell: self)
    }
}
