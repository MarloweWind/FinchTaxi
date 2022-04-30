//
//  SplashScreenInteractor.swift
//  FINCH TAXI
//
//  Created by Marlowe Wind on 02.02.2022.
//

import Foundation

protocol SplashScreenInteractorInput {
    func obtainToken()
}

final class SplashScreenInteractor {
    
    // MARK: - Properties
    
    weak var presenter: SplashScreenInteractorOutput?
    
    private let userDefaults = UserDefaults.standard
    
}


// MARK: - SplashScreenInteractorInput
extension SplashScreenInteractor: SplashScreenInteractorInput {
    
    func obtainToken() {
        if userDefaults.token != nil {
            presenter?.didObtainToken()
        } else {
            presenter?.didFailObtainToken()
        }
    }
    
}
