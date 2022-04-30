//
//  LoginRouter.swift
//  FINCH TAXI
//
//  Created by Marlowe Wind on 02.02.2022.
//

import UIKit

protocol LoginRouterInput {
    func codeDidConfirmed()
}

final class LoginRouter {
    
    // MARK: - Properties

    private unowned let view: UIViewController
    
    
    // MARK: - Init
    
    init(view: UIViewController) {
        self.view = view
    }
    
}


// MARK: - LoginRouterInput
extension LoginRouter: LoginRouterInput {
    
    func codeDidConfirmed() {
        
        let confirmeCodeScreen = ConfirmeCodeAssembly.assembleModule()
        
        view.navigationController?.pushViewController(confirmeCodeScreen, animated: true)
    }
    
}
