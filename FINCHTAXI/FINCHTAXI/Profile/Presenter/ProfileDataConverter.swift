//
//  ProfileDataConverter.swift
//  FINCHTAXI
//
//  Created by Marlowe Wind on 21.04.2022.
//

import Foundation

protocol ProfileDataConverterInput {
    func convert() -> ProfileViewModel
}

final class ProfileDataConverter {
    
    // MARK: - Locals

    private enum Locals {
        static let myDataText = "Мои данные"
        static let rulesDataText = "Правила"
        static let faqDataText = "FAQ"
        static let settingsDataText = "Настройки"
        static let namePlaceHolder = "Имя"
        static let surnamePlaceHolder = "Фамилия"
        static let phonePlaceHolder = "Ваш телефон"
    }
    
    
    // MARK: - Types
    
    typealias Row = ProfileViewModel.Row
    
    
    // MARK: - Private methods
    
    private func mainSection() -> ProfileViewModel {
        let model = ProfileViewModel(rows: [
            ProfileViewModel.Row(selectTyper: .userInfo, profileName: Locals.myDataText),
            ProfileViewModel.Row(profileName: Locals.rulesDataText),
            ProfileViewModel.Row(profileName: Locals.faqDataText),
            ProfileViewModel.Row(profileName: Locals.settingsDataText)
            ],
                                     name: Locals.namePlaceHolder,
                                     surname: Locals.surnamePlaceHolder,
                                     phone: Locals.phonePlaceHolder)
        
        return model
    }
    
}


// MARK: - ProfileDataConverterInput
extension ProfileDataConverter: ProfileDataConverterInput {
    func convert() -> ProfileViewModel {
        return mainSection()
    }
}
