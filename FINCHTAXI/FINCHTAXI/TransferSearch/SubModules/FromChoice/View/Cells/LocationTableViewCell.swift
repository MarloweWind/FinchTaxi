//
//  LocationTableViewCell.swift
//  FINCHTAXI
//
//  Created by Marlowe Wind on 08.04.2022.
//

import UIKit

class LocationTableViewCell: UITableViewCell {
    
    // MARK: - Properties

    static let profileCellId = String(describing: LocationTableViewCell.description())
    
    private let locationLabel = UILabel()
    private let detailLocationLabel = UILabel()
    
    
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
        
        backgroundColor = .clear
        
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.font = UIFont(name: .regular, size: 16)
        locationLabel.textColor = .black
        
        detailLocationLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLocationLabel.font = UIFont(name: .regular, size: 14)
        detailLocationLabel.textColor = .finchLighGrey
        detailLocationLabel.numberOfLines = 3
        
        contentView.addSubview(locationLabel)
        contentView.addSubview(detailLocationLabel)
        
        NSLayoutConstraint.activate([
            locationLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
            locationLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            locationLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
            
            detailLocationLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
            detailLocationLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 4),
            detailLocationLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
            detailLocationLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2)
            ])
    }

}


// MARK: - Model
extension LocationTableViewCell {
    
    func configure(with model: Model) {
        locationLabel.text = model.locationName
        detailLocationLabel.text = model.locationDetail
    }
    
    struct Model {
        let locationName: String
        let locationDetail: String
    }
    
}
