//
//  SplashScreenPresenter.swift
//  FINCH TAXI
//
//  Created by Marlowe Wind on 02.02.2022.
//

import Foundation

protocol SplashScreenViewOutput: ViewOutput { }

protocol SplashScreenInteractorOutput: AnyObject {
    func didObtainToken()
    func didFailObtainToken()
}

final class SplashScreenPresenter {
    
    // MARK: - Properties
    
    weak var view: SplashScreenViewInput?
    var interactor: SplashScreenInteractorInput?
    var router: SplashScreenRouterInput?
    
}


// MARK: - SplashScreenViewOutput
extension SplashScreenPresenter: SplashScreenViewOutput {
    
    func viewDidAppear() {
        interactor?.obtainToken()
    }
    
}


// MARK: - SplashScreenInteractorOutput
extension SplashScreenPresenter: SplashScreenInteractorOutput {
    
    func didObtainToken() {
        router?.openMainScreenModule()
    }
    
    func didFailObtainToken() {
        router?.openAuthorizationModule()
    }
    
}
