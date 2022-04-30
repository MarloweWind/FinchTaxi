//
//  LoginInteractor.swift
//  FINCH TAXI
//
//  Created by Marlowe Wind on 02.02.2022.
//

import Foundation
import Apollo

protocol LoginInteractorInput {
    var getUserPhone: String? { get set }
    
    func sendCode(userPhone: String)
}

final class LoginInteractor {
    
    // MARK: - Properties
    
    weak var presenter: LoginInteractorOutput?
    
    private let userDefaults = UserDefaults.standard
    private let networkServies: GraphQLClientInput
    
    
    // MARK: - Init
    
    init(networkServies: GraphQLClientInput) {
        self.networkServies = networkServies
    }
    
}


// MARK: - LoginInteractorInput
extension LoginInteractor: LoginInteractorInput {
    
    var getUserPhone: String? {
        get {
            return userDefaults.userPhoneNumber
        } set {
            userDefaults.userPhoneNumber = newValue
        }
    }
    
    func sendCode(userPhone: String) {
        
        networkServies.mutate(mutation: SendCodeRequestMutation(phone: userPhone)) {
            [weak self] (result: Result<SendCodeModel, GraphQLError>) in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    
                    if result.userMutation.sendCode != false {
                        self?.presenter?.didObtainCode()
                        print("login success")
                    } else {
                        self?.presenter?.didFailCode(errorModel: ErrorModel.phoneNumberProblem)
                    }
                    
                case .failure(let error):
                    
                    let errorModel = ErrorModel.custom(message: error.errorDescription)

                    if error.errorDescription != "" {
                        self?.presenter?.didFailCode(errorModel: errorModel)
                    }
                    
                }
            }
        }
    }
    
}
