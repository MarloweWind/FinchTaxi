//
//  MoreOptionsTableViewCell.swift
//  FINCHTAXI
//
//  Created by Marlowe Wind on 22.03.2022.
//

import UIKit

final class MoreOptionsTableViewCell: UITableViewCell {
    
    // MARK: - Locals

    private enum Locals {
        static let readyText = "Готово"
    }
    
    
    // MARK: - Properties
    
    static let profileCellId = String(describing: MoreOptionsTableViewCell.description())
    
    var safetySeatCollectionViewManager: TransferSearchCollectionViewManagerInput
    weak var confirmTransferDelegate: ConfirmTransferHeaderOutput?
    let offerButtonText = ["1100₽", "1300₽", "1500₽"]
    var offerButtons: [UIButton] = []
    let dataConvetner = TransferSearchCollectionViewDataConventer()
    
    private let optionsLabel = UILabel()
    private let yourPriceView = OptionView()
    private let yourPriceLayout = UICollectionViewFlowLayout()
    private let offerStackView = UIStackView()
    private let transferBackButton = UIButton(type: .system)
    private let transferNumberView = OptionView()
    private let meetWithSignView = OptionView()
    private let safetySeatLabel = UILabel()
    private let safetySeatLayout = UICollectionViewFlowLayout()
    private lazy var safetySeatCollectionView = UICollectionView(
        frame: contentView.bounds,
        collectionViewLayout: safetySeatLayout
    )
    private let promoCodeView = OptionView()
    private let membershipCardView = OptionView()
    private let userCommentView = OptionView()
    private let confirmTransferButton = UIButton(type: .system)
    

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        safetySeatCollectionViewManager = TransferSearchCollectionViewManager()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        drawSelf()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Drawing
    
    func drawSelf() {
        
        contentView.backgroundColor = .white
        
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
        doneToolbar.barStyle = .default
        let flexSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(
            title: Locals.readyText,
            style: .done,
            target: self,
            action: #selector(self.doneButtonAction))
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        yourPriceView.configureInputAccessoryView(view: doneToolbar)
        transferNumberView.configureInputAccessoryView(view: doneToolbar)
        meetWithSignView.configureInputAccessoryView(view: doneToolbar)
        promoCodeView.configureInputAccessoryView(view: doneToolbar)
        membershipCardView.configureInputAccessoryView(view: doneToolbar)
        userCommentView.configureInputAccessoryView(view: doneToolbar)
        
        optionsLabel.translatesAutoresizingMaskIntoConstraints = false
        optionsLabel.font = UIFont(name: .bold, size: 24)
        optionsLabel.textColor = .black
        
        yourPriceView.translatesAutoresizingMaskIntoConstraints = false
        yourPriceView.optionViewDelegate = self
        
        offerStackView.translatesAutoresizingMaskIntoConstraints = false
        offerStackView.axis = .horizontal
        offerStackView.distribution = .fill
        offerStackView.alignment = .fill
        offerStackView.spacing = 14
        
        for index in 0..<offerButtonText.count {
            let offerButton = UIButton(type: .system)
            offerButton.setTitle(offerButtonText[index], for: .normal)
            offerButton.addTarget(self, action: #selector(didTapOfferButton), for: .touchUpInside)
            offerButton.translatesAutoresizingMaskIntoConstraints = false
            offerButton.backgroundColor = .fincWhite
            offerButton.tintColor = .black
            offerButton.titleLabel?.textAlignment = .center
            offerButton.titleLabel?.adjustsFontSizeToFitWidth = true
            offerButton.layer.masksToBounds = true
            offerButton.layer.cornerRadius = 16
            offerButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
            offerButton.tag = index
            offerButtons.append(offerButton)
        }
        
        offerButtons.forEach { offerButton in
            offerStackView.addArrangedSubview(offerButton)
        }
        
        transferBackButton.translatesAutoresizingMaskIntoConstraints = false
        transferBackButton.tintColor = .black
        transferBackButton.layer.cornerRadius = 21
        transferBackButton.titleLabel?.font = UIFont(name: .regular, size: 16)
        transferBackButton.titleLabel?.adjustsFontSizeToFitWidth = true
        transferBackButton.backgroundColor = .white
        transferBackButton.layer.masksToBounds = true
        transferBackButton.layer.cornerRadius = 16
        transferBackButton.layer.borderWidth = 1
        transferBackButton.layer.borderColor = UIColor.buttonColor.cgColor
        
        transferNumberView.translatesAutoresizingMaskIntoConstraints = false
        transferNumberView.optionViewDelegate = self

        meetWithSignView.translatesAutoresizingMaskIntoConstraints = false
        meetWithSignView.optionViewDelegate = self

        safetySeatLabel.translatesAutoresizingMaskIntoConstraints = false
        safetySeatLabel.font = UIFont(name: .regular, size: 16)
        safetySeatLabel.textColor = .finchLighGrey
        
        safetySeatLayout.scrollDirection = .horizontal
        safetySeatLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12)
        safetySeatLayout.itemSize = CGSize(width: 82, height: 106)
        safetySeatLayout.sectionInsetReference = .fromLayoutMargins
        safetySeatCollectionView.translatesAutoresizingMaskIntoConstraints = false
        safetySeatCollectionView.backgroundColor = .clear
        safetySeatCollectionView.showsHorizontalScrollIndicator = false
        safetySeatCollectionView.clipsToBounds = false
        
        promoCodeView.translatesAutoresizingMaskIntoConstraints = false
        promoCodeView.optionViewDelegate = self
        
        membershipCardView.translatesAutoresizingMaskIntoConstraints = false
        membershipCardView.optionViewDelegate = self
        
        userCommentView.translatesAutoresizingMaskIntoConstraints = false
        userCommentView.optionViewDelegate = self
        
        confirmTransferButton.translatesAutoresizingMaskIntoConstraints = false
        confirmTransferButton.tintColor = .black
        confirmTransferButton.layer.cornerRadius = 21
        confirmTransferButton.titleLabel?.font = UIFont(name: .regular, size: 16)
        confirmTransferButton.backgroundColor = .buttonColor
        
        contentView.addSubview(optionsLabel)
        contentView.addSubview(yourPriceView)
        contentView.addSubview(offerStackView)
        contentView.addSubview(transferBackButton)
        contentView.addSubview(transferNumberView)
        contentView.addSubview(meetWithSignView)
        contentView.addSubview(safetySeatLabel)
        contentView.addSubview(safetySeatCollectionView)
        contentView.addSubview(promoCodeView)
        contentView.addSubview(membershipCardView)
        contentView.addSubview(userCommentView)
        contentView.addSubview(confirmTransferButton)
        
        NSLayoutConstraint.activate([
            optionsLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 36),
            optionsLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 32),
            
            yourPriceView.topAnchor.constraint(equalTo: optionsLabel.bottomAnchor, constant: 0),
            yourPriceView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
            yourPriceView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
        
            offerStackView.topAnchor.constraint(equalTo: yourPriceView.bottomAnchor, constant: 18),
            offerStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 32),
            offerStackView.widthAnchor.constraint(equalToConstant: 238),
            offerStackView.heightAnchor.constraint(equalToConstant: 34),

            transferBackButton.topAnchor.constraint(equalTo: offerStackView.bottomAnchor, constant: 32),
            transferBackButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 32),
            transferBackButton.widthAnchor.constraint(equalToConstant: 200),
            transferBackButton.heightAnchor.constraint(equalToConstant: 42),

            transferNumberView.topAnchor.constraint(equalTo: transferBackButton.bottomAnchor, constant: 0),
            transferNumberView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
            transferNumberView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),

            meetWithSignView.topAnchor.constraint(equalTo: transferNumberView.bottomAnchor, constant: 0),
            meetWithSignView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
            meetWithSignView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),

            safetySeatLabel.topAnchor.constraint(equalTo: meetWithSignView.bottomAnchor, constant: 36),
            safetySeatLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 32),

            safetySeatCollectionView.topAnchor.constraint(equalTo: safetySeatLabel.bottomAnchor, constant: 18),
            safetySeatCollectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 24),
            safetySeatCollectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
            safetySeatCollectionView.heightAnchor.constraint(equalToConstant: 112),

            promoCodeView.topAnchor.constraint(equalTo: safetySeatCollectionView.bottomAnchor, constant: 0),
            promoCodeView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
            promoCodeView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),

            membershipCardView.topAnchor.constraint(equalTo: promoCodeView.bottomAnchor, constant: 0),
            membershipCardView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
            membershipCardView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),

            userCommentView.topAnchor.constraint(equalTo: membershipCardView.bottomAnchor, constant: 0),
            userCommentView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
            userCommentView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),

            confirmTransferButton.topAnchor.constraint(equalTo: userCommentView.bottomAnchor, constant: 36),
            confirmTransferButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 32),
            confirmTransferButton.widthAnchor.constraint(equalToConstant: 120),
            confirmTransferButton.heightAnchor.constraint(equalToConstant: 42),
            confirmTransferButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32),
            ])

        safetySeatCollectionViewManager.setup(collectionView: safetySeatCollectionView)
        safetySeatCollectionViewManager.update(with: dataConvetner.convert(type: .safetySeat))
    }
    
    
    // MARK: - Actions
    
    @objc func didTapSuperView() {
        contentView.endEditing(true)
    }
    
    @objc func didTapOfferButton(_ sender: UIButton) {
        offerButtons.forEach { offerButton in
            
            if sender.tag == offerButton.tag {
                
                guard let titleText = offerButton.currentTitle
                else {
                    return
                }
                
                yourPriceView.configureTextFieldText(text: titleText)
            }
        }
    }
    
    @objc func doneButtonAction(){
        yourPriceView.configureResignFirstResponder()
        yourPriceView.configureCurrency()
        transferNumberView.configureResignFirstResponder()
        meetWithSignView.configureResignFirstResponder()
        promoCodeView.configureResignFirstResponder()
        membershipCardView.configureResignFirstResponder()
        userCommentView.configureResignFirstResponder()
    }

}


// MARK: - Configurable
extension MoreOptionsTableViewCell: Configurable {
    func configure(with model: Model) {
        optionsLabel.text = model.optionsLabelText
        
        let yourPriceViewModel = OptionView.Model(textFieldType: .numpad, labelText: model.pickYourPriceLabelText,
                                                  textFieldPlaceholder: model.yourPriceTextFieldText)
        yourPriceView.configure(with: yourPriceViewModel)
        
        transferBackButton.setTitle(model.transferBackButtonText, for: .normal)
        
        let transferNumberViewModel = OptionView.Model(textFieldType: .defaultKeyBoard, labelText: model.transferNumberLabelText,
                                                               textFieldPlaceholder: model.transferNumberTextFieldText)
        transferNumberView.configure(with: transferNumberViewModel)
        
        let meetWithSignViewModel = OptionView.Model(textFieldType: .defaultKeyBoard, labelText: model.meetWithSignLabelText,
                                                             textFieldPlaceholder: model.meetWithSignTextFieldText)
        meetWithSignView.configure(with: meetWithSignViewModel)
        
        safetySeatLabel.text = model.safetySeatLabelText
        
        let promoCodeViewModel = OptionView.Model(textFieldType: .numpad, labelText: model.promoCodeLabelText,
                                                             textFieldPlaceholder: model.promoCodeTextfieldText)
        promoCodeView.configure(with: promoCodeViewModel)
        
        let membershipCardViewModel = OptionView.Model(textFieldType: .numpad, labelText: model.membershipCardLabelText,
                                                             textFieldPlaceholder: model.membershipCardTextFieldText)
        membershipCardView.configure(with: membershipCardViewModel)
        
        let userCommentViewModel = OptionView.Model(textFieldType: .defaultKeyBoard, labelText: model.userCommentLabelText,
                                                             textFieldPlaceholder: model.userCommentTextFieldText)
        userCommentView.configure(with: userCommentViewModel)
        
        confirmTransferButton.setTitle(model.confirmTransferButtonText, for: .normal)
    }
    
    struct Model {
        let optionsLabelText: String
        let pickYourPriceLabelText: String
        let yourPriceTextFieldText: String
        let transferBackButtonText: String
        let transferNumberLabelText: String
        let transferNumberTextFieldText: String
        let meetWithSignLabelText: String
        let meetWithSignTextFieldText: String
        let safetySeatLabelText: String
        let promoCodeLabelText: String
        let promoCodeTextfieldText: String
        let membershipCardLabelText: String
        let membershipCardTextFieldText: String
        let userCommentLabelText: String
        let userCommentTextFieldText: String
        let confirmTransferButtonText: String
    }
}

extension MoreOptionsTableViewCell: OptionViewOutput {
    func setContentOffsetY(y: CGFloat) {
        confirmTransferDelegate?.moveToTextField(point: CGPoint(x: 0, y: y))
    }
}
