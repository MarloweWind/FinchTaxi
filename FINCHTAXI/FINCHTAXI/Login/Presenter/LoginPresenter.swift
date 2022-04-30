//
//  LoginPresenter.swift
//  FINCH TAXI
//
//  Created by Marlowe Wind on 02.02.2022.
//

import Foundation

protocol LoginViewOutput: ViewOutput {
    func didTapLoginButton(userPhoneNumber: String)
}

protocol LoginInteractorOutput: AnyObject {
    func didObtainCode()
    func didFailCode(errorModel: ErrorModel)
}

final class LoginPresenter {
    
    // MARK: - Properties
    
    weak var view: LoginViewInput?
    var interactor: LoginInteractorInput?
    var router: LoginRouterInput?
        
}


// MARK: - LoginViewOutput
extension LoginPresenter: LoginViewOutput {
    
    func didTapLoginButton(userPhoneNumber: String) {
        interactor?.getUserPhone = userPhoneNumber
        interactor?.sendCode(userPhone: userPhoneNumber)
    }
    
}


// MARK: - LoginInteractorOutput
extension LoginPresenter: LoginInteractorOutput {
    
    func didObtainCode() {
        router?.codeDidConfirmed()
    }
    
    func didFailCode(errorModel: ErrorModel) {
        view?.didFailCode(errorModel: errorModel)
    }
    
}
