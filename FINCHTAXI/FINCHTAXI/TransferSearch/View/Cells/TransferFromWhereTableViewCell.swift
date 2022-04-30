//
//  TransferFromWhereTableViewCell.swift
//  FINCHTAXI
//
//  Created by Marlowe Wind on 21.03.2022.
//

import UIKit

protocol TransferFromWhereDelegate: AnyObject {
    func didTapPresentFromView(locationType: LocationType)
}

final class TransferFromWhereTableViewCell: UITableViewCell {
    
    // MARK: - Types
    
    enum ButtonType: Int {
        case from
        case toWhere
    }
    

    // MARK: - Properties
    
    weak var transferFromWhereDelegate: TransferFromWhereDelegate?

    static let profileCellId = String(describing: TransferFromWhereTableViewCell.description())
    
    private let transferArrowImageView = UIImageView()
    private let fromButton = UIButton(type: .system)
    private let toWhereButton = UIButton(type: .system)
    private let refreshButton = UIButton(type: .system)
    
    
    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        drawSelf()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Drawing
    
    func drawSelf() {
        
        contentView.backgroundColor = .white
        
        transferArrowImageView.translatesAutoresizingMaskIntoConstraints = false
        transferArrowImageView.image = UIImage(named: "transferArrow")
        
        setupDirectionButton(fromButton, action: #selector(didTapFromButton), tag: .from)
        
        setupDirectionButton(toWhereButton, action: #selector(didTapFromButton), tag: .toWhere)
        
        refreshButton.translatesAutoresizingMaskIntoConstraints = false
        refreshButton.setBackgroundImage(UIImage(named: "refresh"), for: .normal)
        refreshButton.addTarget(self, action: #selector(didTapRefreshButton), for: .touchUpInside)
        
        contentView.addSubview(transferArrowImageView)
        contentView.addSubview(fromButton)
        contentView.addSubview(toWhereButton)
        contentView.addSubview(refreshButton)
        
        NSLayoutConstraint.activate([
            
            transferArrowImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 32),
            transferArrowImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
            
            fromButton.leftAnchor.constraint(equalTo: transferArrowImageView.leftAnchor, constant: 24),
            fromButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            fromButton.heightAnchor.constraint(equalToConstant: 34),

            toWhereButton.leftAnchor.constraint(equalTo: transferArrowImageView.leftAnchor, constant: 24),
            toWhereButton.topAnchor.constraint(equalTo: fromButton.bottomAnchor, constant: 24),
            toWhereButton.heightAnchor.constraint(equalToConstant: 34),
            toWhereButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32),
            
            refreshButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -32),
            refreshButton.centerYAnchor.constraint(equalTo: transferArrowImageView.centerYAnchor),
            refreshButton.widthAnchor.constraint(equalToConstant: 20),
            refreshButton.heightAnchor.constraint(equalToConstant: 15)
            
            ])
    }
    
    
    // MARK: - Private methods
    
    private func setupDirectionButton(_ button: UIButton, action: Selector, tag: ButtonType) {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        button.titleLabel?.font = UIFont(name: .regular, size: 14)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18)
        button.backgroundColor = .fincWhite
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16
        button.tag = tag.rawValue
        button.addTarget(self,
                              action: action,
                              for: .touchUpInside)
    }
    
    
    // MARK: - Actions
    
    @objc func didTapFromButton(_ sender: UIButton) {
        
        guard let locationType = LocationType(rawValue: sender.tag)
        else {
            return
        }

        transferFromWhereDelegate?.didTapPresentFromView(locationType: locationType)
        
    }
    
    @objc func didTapRefreshButton() {
        fromButton.setTitle(toWhereButton.titleLabel?.text, for: .normal)
        toWhereButton.setTitle(fromButton.titleLabel?.text, for: .normal)
    }
    
}


// MARK: - Configurable
extension TransferFromWhereTableViewCell: Configurable {
    func configure(with model: Model) {
        fromButton.setTitle(model.fromLabelText, for: .normal)
        toWhereButton.setTitle(model.toWhereLabelText, for: .normal)
    }
    
    struct Model {
        let fromLabelText: String
        let toWhereLabelText: String
    }
}
