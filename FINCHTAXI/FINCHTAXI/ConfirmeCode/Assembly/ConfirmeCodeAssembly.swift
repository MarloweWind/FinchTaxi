//
//  ConfirmeCodeAssembly.swift
//  FINCH TAXI
//
//  Created by Marlowe Wind on 03.02.2022.
//

import UIKit

final class ConfirmeCodeAssembly {
    
    static func assembleModule() -> UIViewController {
        
        let networkServies = GraphQLClient()
        
        let view = ConfirmeCodeViewController()
        let router = ConfirmeCodeRouter(view: view)
        let presenter = ConfirmeCodePresenter()
        let interactor = ConfirmeCodeInteractor(networkServies: networkServies)
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        return view
    }
    
}
