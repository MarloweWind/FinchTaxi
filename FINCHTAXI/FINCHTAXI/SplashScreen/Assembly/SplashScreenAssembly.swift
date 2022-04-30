//
//  SplashScreenAssemby.swift
//  FINCH TAXI
//
//  Created by Marlowe Wind on 02.02.2022.
//

import UIKit

final class SplashScreenAssembly {
    
    static func assembleModule() -> UIViewController {
        let view = SplashScreenViewController()
        let router = SplashScreenRouter(view: view)
        let presenter = SplashScreenPresenter()
        let interactor = SplashScreenInteractor()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        return view
    }
    
}
