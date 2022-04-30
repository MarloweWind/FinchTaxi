//
//  PickCarView.swift
//  FINCHTAXI
//
//  Created by Marlowe Wind on 29.03.2022.
//

import UIKit

protocol PickCarViewOutput: AnyObject {
    func cellIsSelected()
}

final class PickCarView: UIView {
    
    // MARK: - Types
    
    enum CarCellType {
        case pickCar
        case safetySeat
    }


    // MARK: - Properties
    
    weak var pickCarViewDelegate: PickCarViewOutput?
    
    private var seatCount = 1

    let carLabel = UILabel()
    let carPriceLabel = UILabel()
    let peopleCountLabel = UILabel()
    
    private let carImageView = UIImageView()
    private let seatCountLabel = UILabel()
    private let minusButton = UIButton(type: .system)
    private let plusButton = UIButton(type: .system)


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

        backgroundColor = .white
        
        setupLabel(carLabel,
                   color: .black,
                   textSize: 14)

        carImageView.translatesAutoresizingMaskIntoConstraints = false
        carImageView.image = UIImage(named: "car")

        setupLabel(carPriceLabel,
                   color: .black,
                   textSize: 12)

        setupLabel(peopleCountLabel,
                   color: .finchGrey,
                   textSize: 11)
        
        seatCountLabel.translatesAutoresizingMaskIntoConstraints = false
        seatCountLabel.font = UIFont(name: .medium, size: 14)
        seatCountLabel.textColor = .black
        seatCountLabel.text = String(seatCount)
        
        minusButton.translatesAutoresizingMaskIntoConstraints = false
        minusButton.setTitle("-", for: .normal)
        minusButton.tintColor = .black
        minusButton.titleLabel?.font = UIFont(name: .medium, size: 12)
        minusButton.addTarget(self, action: #selector(didTapMinusButton), for: .touchUpInside)
        
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        plusButton.setTitle("+", for: .normal)
        plusButton.tintColor = .black
        plusButton.titleLabel?.font = UIFont(name: .medium, size: 12)
        plusButton.addTarget(self, action: #selector(didTapPlusButton), for: .touchUpInside)
        
        addSubview(carLabel)
        addSubview(carImageView)
        
        NSLayoutConstraint.activate([
            carLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            carLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),

            carImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            carImageView.topAnchor.constraint(equalTo: carLabel.bottomAnchor, constant: 12),
            carImageView.widthAnchor.constraint(equalToConstant: 44),
            carImageView.heightAnchor.constraint(equalToConstant: 16),
            ])

    }
    

    // MARK: - Private methods

    private func setupLabel(_ label: UILabel, color: UIColor, textSize: CGFloat) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: .medium, size: textSize)
        label.textColor = color
    }
    
    private func seatCountFilter() {
        switch seatCount {
            
        case 0:
            minusButton.isEnabled = false
            plusButton.isEnabled = true
            
        case 1:
            minusButton.isEnabled = true
            plusButton.isEnabled = true
            
        case 2:
            minusButton.isEnabled = true
            plusButton.isEnabled = true
            
        case 3:
            minusButton.isEnabled = true
            plusButton.isEnabled = false
            
        default:
            break
        }
    }
    
    
    // MARK: - Actions

    @objc func didTapPlusButton() {
        seatCount += 1
        seatCountLabel.text = String(seatCount)
        seatCountFilter()
        pickCarViewDelegate?.cellIsSelected()
    }
    
    @objc func didTapMinusButton() {
        seatCount -= 1
        seatCountLabel.text = String(seatCount)
        seatCountFilter()
        pickCarViewDelegate?.cellIsSelected()
    }
    
}


// MARK: - Configurable
extension PickCarView: Configurable {
    func configure(with model: Model) {
        switch model.cellType {
            
        case .pickCar:
            addSubview(carPriceLabel)
            addSubview(peopleCountLabel)
            NSLayoutConstraint.activate([
                carPriceLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                carPriceLabel.topAnchor.constraint(equalTo: carImageView.bottomAnchor, constant: 12),

                peopleCountLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                peopleCountLabel.topAnchor.constraint(equalTo: carPriceLabel.bottomAnchor, constant: 6),
                ])
            
        case .safetySeat:
            addSubview(seatCountLabel)
            addSubview(minusButton)
            addSubview(plusButton)
            NSLayoutConstraint.activate([
                seatCountLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                seatCountLabel.topAnchor.constraint(equalTo: carImageView.bottomAnchor, constant: 16),
                
                minusButton.rightAnchor.constraint(equalTo: seatCountLabel.leftAnchor, constant: 0),
                minusButton.topAnchor.constraint(equalTo: carImageView.bottomAnchor, constant: 10),
                
                plusButton.leftAnchor.constraint(equalTo: seatCountLabel.rightAnchor, constant: 0),
                plusButton.topAnchor.constraint(equalTo: carImageView.bottomAnchor, constant: 10),
                ])
        }
    }
    
    struct Model {
        let cellType: CarCellType
    }
}
