//
//  SplashScreenRouter.swift
//  FINCH TAXI
//
//  Created by Marlowe Wind on 02.02.2022.
//

import UIKit

protocol SplashScreenRouterInput {
    func openAuthorizationModule()
    func openMainScreenModule()
}

final class SplashScreenRouter {
    
    // MARK: - Properties

    private unowned let view: UIViewController
    
    
    // MARK: - Init
    
    init(view: UIViewController) {
        self.view = view
    }
    
}


// MARK: - SplashScreenRouterInput
extension SplashScreenRouter: SplashScreenRouterInput {
    
    func openAuthorizationModule() {
        let loginViewController = LoginAssembly.assembleModule()
        view.navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    func openMainScreenModule() {
        let mainTabBarController = MainTabBarAssembly.assembleModule()
        view.navigationController?.pushViewController(mainTabBarController, animated: true)
        view.navigationController?.removeViewController(SplashScreenViewController.self)
    }
    
}
