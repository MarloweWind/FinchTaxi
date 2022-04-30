//
//  LoginAssembly.swift
//  FINCH TAXI
//
//  Created by Marlowe Wind on 02.02.2022.
//

import UIKit

final class LoginAssembly {
    
    static func assembleModule() -> UIViewController {
        
        let networkServies = GraphQLClient()
        
        let view = LoginViewController()
        let router = LoginRouter(view: view)
        let presenter = LoginPresenter()
        let interactor = LoginInteractor(networkServies: networkServies)
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        return view
    }
}
