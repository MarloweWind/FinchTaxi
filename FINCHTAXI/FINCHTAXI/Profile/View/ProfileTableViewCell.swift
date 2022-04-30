//
//  ProfileTableViewCell.swift
//  FINCH TAXI
//
//  Created by Marlowe Wind on 11.02.2022.
//

import UIKit

final class ProfileTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let profileCellId = String(describing: ProfileTableViewCell.description())
    
    private var menuNameLabel = UILabel()

    
    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        drawSelf()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        menuNameLabel.translatesAutoresizingMaskIntoConstraints = false
        menuNameLabel.font = UIFont(name: .regular, size: 18)
        menuNameLabel.textColor = .black
        menuNameLabel.adjustsFontSizeToFitWidth = true
        contentView.addSubview(menuNameLabel)
        
        NSLayoutConstraint.activate([
            menuNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            menuNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
            ])
    }

}


// MARK: - Model

extension ProfileTableViewCell {
    
    func configure(with model: Model) {
        menuNameLabel.text = model.menuName
    }
    
    struct Model {
        let menuName: String
    }
    
}

