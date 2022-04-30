//
//  ConfirmeCodeInteractor.swift
//  FINCH TAXI
//
//  Created by Marlowe Wind on 03.02.2022.
//

import Foundation

protocol ConfirmeCodeInteractorInput {
    var getUserPhone: String? { get }
    
    func setToken(code: String)
}

final class ConfirmeCodeInteractor {
    
    // MARK: - Properties
    
    weak var presenter: ConfirmeCodeInteractorOutput?
    
    private let userDefaults = UserDefaults.standard
    private let networkServies: GraphQLClientInput
    
    
    // MARK: - Init
    
    init(networkServies: GraphQLClientInput) {
        self.networkServies = networkServies
    }
    
}


// MARK: - ConfirmeCodeInteractorInput
extension ConfirmeCodeInteractor: ConfirmeCodeInteractorInput {
    
    var getUserPhone: String? {
        userDefaults.userPhoneNumber
    }
    
    func setToken(code: String) {
        
        guard let userPhone = getUserPhone else {
            return
        }
        
        networkServies.mutate(mutation: CondfirmCodeRequestMutation(phone: userPhone, code: code)) {
            [weak self] (result: Result<ConfirmCodeModel, GraphQLError>) in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    
                    self?.userDefaults.token = result.userMutation.confirmCode.token
                    self?.presenter?.didConfirmCode()
                        
                    print("confirm login success")
                    
                case .failure(let error):
                    
                    let errorModel: ErrorModel
                        
                    if error.errorDescription?.isEmpty == false {
                        errorModel = ErrorModel.wrongCodeAlert
                    } else {
                        errorModel = ErrorModel.custom(message: error.errorDescription)
                    }
                        
                    self?.presenter?.didFailConfirmCode(errorModel: errorModel)
                        
                    print(error.localizedDescription)
                    
                }
            }
        }
        
    }
    
}
