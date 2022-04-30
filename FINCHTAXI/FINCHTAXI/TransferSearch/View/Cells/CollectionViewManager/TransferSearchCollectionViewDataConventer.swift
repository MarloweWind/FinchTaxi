//
//  TransferSearchCollectionViewDataConventer.swift
//  FINCHTAXI
//
//  Created by Marlowe Wind on 06.04.2022.
//

import Foundation

protocol TransferSearchCollectionViewDataConventerInput {
    func convert(type: TransferSaerchViewModelType) -> TransferSearchCollectionViewModel
}

final class TransferSearchCollectionViewDataConventer {
    
    // MARK: - Types
    
    typealias Row = TransferSearchCollectionViewModel.Row
    
    
    // MARK: - Locals
    
    private enum Locals {
        static let firstAgeText = "До 4 лет"
        static let secondAgeText = "До 7 лет"
        static let thirdAgeText = "До 12 лет"
        static let ecoCarText = "Эконом"
        static let buseinesCarText = "Бизнес"
        static let premiumCarText = "Премиум"
        static let miniVanCartext = "Минивэн"
        static let firstCatPriceText = "от 1280р"
        static let secondCarPriceText = "от 1380р"
        static let thirdCarPriceText = "от 1580р"
        static let fourthCarPriceText = "от 2280р"
        static let firstPeopleCount = "3 чел"
        static let secondPeopleCount = "8 чел"
        
    }
    
    
    // MARK: - Private methods
    
    func pickCar() -> [Row] {
        
        let rows = [ Row(collectionViewType: .pickCarCollection(model: TransferSearchCollectionViewCell.pickCarModel(
                        carTypeText: Locals.ecoCarText,
                        carPriceText: Locals.firstCatPriceText,
                        carPeopleCounttext: Locals.firstPeopleCount))
                         ),
                      Row(collectionViewType: .pickCarCollection(model: TransferSearchCollectionViewCell.pickCarModel(
                        carTypeText: Locals.buseinesCarText,
                        carPriceText: Locals.secondCarPriceText,
                        carPeopleCounttext: Locals.firstPeopleCount))
                         ),
                      Row(collectionViewType: .pickCarCollection(model: TransferSearchCollectionViewCell.pickCarModel(
                        carTypeText: Locals.premiumCarText,
                        carPriceText: Locals.thirdCarPriceText,
                        carPeopleCounttext: Locals.firstPeopleCount))
                         ),
                      Row(collectionViewType: .pickCarCollection(model: TransferSearchCollectionViewCell.pickCarModel(
                        carTypeText: Locals.miniVanCartext,
                        carPriceText: Locals.fourthCarPriceText,
                        carPeopleCounttext: Locals.secondPeopleCount))
                         )
        ]
        
        return rows
    }
    
    func safetySeat() -> [Row] {
        let rows = [ Row(collectionViewType: .safetySeatCollection(model: TransferSearchCollectionViewCell.safetySeatModel(
            childAgeText: Locals.firstAgeText))),
                     Row(collectionViewType: .safetySeatCollection(model: TransferSearchCollectionViewCell.safetySeatModel(
                        childAgeText: Locals.secondAgeText))),
                     Row(collectionViewType: .safetySeatCollection(model: TransferSearchCollectionViewCell.safetySeatModel(
                        childAgeText: Locals.thirdAgeText)))
        ]
        
        return rows
    }
    
}


// MARK: - TransferSearchDataConverterInput
extension TransferSearchCollectionViewDataConventer: TransferSearchCollectionViewDataConventerInput {
    func convert(type: TransferSaerchViewModelType) -> TransferSearchCollectionViewModel {
        switch type {
        case .carSearch:
            return TransferSearchCollectionViewModel(row: pickCar())
        case.safetySeat:
            return TransferSearchCollectionViewModel(row: safetySeat())
        }
    }
}


