//
//  TransferDateTableViewCell.swift
//  FINCHTAXI
//
//  Created by Marlowe Wind on 21.03.2022.
//

import UIKit

final class TransferDateTableViewCell: UITableViewCell {

    // MARK: - Properties

    static let profileCellId = String(describing: TransferDateTableViewCell.description())
    
    private let dateView = DateView()
    

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
        
        dateView.translatesAutoresizingMaskIntoConstraints = false
   
        contentView.addSubview(dateView)
        
        NSLayoutConstraint.activate([
            dateView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            dateView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
            dateView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
            dateView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
            ])
    }
    
}


// MARK: - Configurable
extension TransferDateTableViewCell: Configurable {
    func configure(with model: Model) {
        let dateViewModel = DateView.Model(
            dateLabelText: model.dateLabelText,
            dateDetailLabelText: model.dateDetailLabelText,
            timeLabelText: model.timeLabelText,
            detailTimeLabelText: model.detailTimeLabelText)
        dateView.configure(with: dateViewModel)
    }
    
    struct Model {
        let dateLabelText: String
        let dateDetailLabelText: String
        let timeLabelText: String
        let detailTimeLabelText: String
    }
}
