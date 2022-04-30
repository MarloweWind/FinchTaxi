//
//  TransferSearchDataConventer.swift
//  FINCHTAXI
//
//  Created by Marlowe Wind on 25.03.2022.
//

import Foundation

protocol TransferSearchDataConverterInput {
    func convert(locationType: LocationType?, transferButton: String?) -> TransferSearchViewModel
}

final class TransferSearchDataConverter {
    
    // MARK: - Types
    
    typealias Section = TransferSearchViewModel.Section
    typealias Row = TransferSearchViewModel.Row
    
    
    // MARK: - Locals
    
    private enum Locals {
        static let fromLabelText = "Откуда?"
        static let toWhereLabelText = "Куда?"
        static let dateLabelText = "Дата"
        static let dateDetailLabelText = "01 Август 2018"
        static let timeLabelText = "Время"
        static let detailTimeLabelText = "08:00"
        static let confirmTransferButtonText = "Заказать"
        static let addOptionsButtonText = "+   Добавить опции"
        static let lessOptionsButtonText = "-   Убрать опции"
        static let optionsLabelText = "Опции"
        static let pickYourPriceLabelText = "Предложить свою цену"
        static let yourPriceTextFieldText = "1200"
        static let transferBackButtonText = "+ Обратный трансфер"
        static let transferNumberLabelText = "Номер рейса или поезда"
        static let transferNumberTextFieldText = "A9"
        static let meetWithSignLabelText = "Встретить с табличкой"
        static let meetWithSignTextFieldText = "Надпись на табличке"
        static let safetySeatLabelText = "Детское кресло"
        static let promoCodeLabelText = "Промокод"
        static let promoCodeTextfieldText = "5731"
        static let membershipCardLabelText = "У меня есть карта Малина"
        static let membershipCardTextFieldText = "1234 5678 1234 9876"
        static let userCommentLabelText = "Комментарий"
        static let userCommentTextFieldText = "Нужен пустой багажник"
    }
    
    
    // MARK: - Properties

    private var fromLocation = Locals.fromLabelText
    private var toWhereLocation = Locals.toWhereLabelText
    
    
    // MARK: - Private methods
    
    private func mainSection() -> Section {
        let rows = [
            Row(transferCell: .transferFromWhere(model: TransferFromWhereTableViewCell.Model(
                fromLabelText: fromLocation,
                toWhereLabelText: toWhereLocation))
               ),
            Row(transferCell: .transferDate(model: TransferDateTableViewCell.Model(
                dateLabelText: Locals.dateLabelText,
                dateDetailLabelText: Locals.dateDetailLabelText,
                timeLabelText: Locals.timeLabelText,
                detailTimeLabelText: Locals.detailTimeLabelText))
               ),
            Row(transferCell: .pickCar)
        ]
        
        return Section(rows: rows, headerHeight: 0)
    }
    
    private func optionSection() -> Section {
        
        let model = MoreOptionsTableViewCell.Model(
            optionsLabelText: Locals.optionsLabelText,
            pickYourPriceLabelText: Locals.pickYourPriceLabelText,
            yourPriceTextFieldText: Locals.yourPriceTextFieldText,
            transferBackButtonText: Locals.transferBackButtonText,
            transferNumberLabelText: Locals.transferNumberLabelText,
            transferNumberTextFieldText: Locals.transferNumberTextFieldText,
            meetWithSignLabelText: Locals.meetWithSignLabelText,
            meetWithSignTextFieldText: Locals.meetWithSignTextFieldText,
            safetySeatLabelText: Locals.safetySeatLabelText,
            promoCodeLabelText: Locals.promoCodeLabelText,
            promoCodeTextfieldText: Locals.promoCodeTextfieldText,
            membershipCardLabelText: Locals.membershipCardLabelText,
            membershipCardTextFieldText: Locals.membershipCardTextFieldText,
            userCommentLabelText: Locals.userCommentLabelText,
            userCommentTextFieldText: Locals.userCommentTextFieldText,
            confirmTransferButtonText: Locals.confirmTransferButtonText
        )

        return Section(rows: [Row(transferCell: .moreOptions(model: model))], headerHeight: 46)
    }
    
    private func confirmHeader() -> ConfrimHeaderView.Model {
        let model = ConfrimHeaderView.Model(
            confirmTransferButtonText: Locals.confirmTransferButtonText,
            addOptionsButtonText: Locals.addOptionsButtonText,
            lessOptionsButtonText: Locals.lessOptionsButtonText)
        
        return model
    }
    
}


// MARK: - TransferSearchDataConverterInput
extension TransferSearchDataConverter: TransferSearchDataConverterInput {
    func convert(locationType: LocationType?, transferButton: String? = nil) -> TransferSearchViewModel {
        switch locationType {
        case .from:
            fromLocation = transferButton ?? Locals.fromLabelText

        case .toWhere:
            toWhereLocation = transferButton ?? Locals.toWhereLabelText

        case .none:
            fromLocation = Locals.fromLabelText
            toWhereLocation = Locals.toWhereLabelText
        }

        return TransferSearchViewModel(section: [mainSection(), optionSection()], header: confirmHeader())
    }
}
