//
//  ConfirmeCodeRouter.swift
//  FINCH TAXI
//
//  Created by Marlowe Wind on 03.02.2022.
//

import UIKit

protocol ConfirmeCodeRouterInput {
    func openMainModule()
    func backToLigonScreen()
}

final class ConfirmeCodeRouter {
    
    // MARK: - Properties

    private unowned let view: UIViewController
    
    
    // MARK: - Init
    
    init(view: UIViewController) {
        self.view = view
    }
    
}


// MARK: - ConfirmeCodeRouterInput
extension ConfirmeCodeRouter: ConfirmeCodeRouterInput {
    
    func openMainModule() {
        let mainTabBarController = MainTabBarAssembly.assembleModule()
        view.navigationController?.pushViewController(mainTabBarController, animated: true)
        view.navigationController?.removeViewControllers(exception: mainTabBarController)
    }
    
    func backToLigonScreen() {
        view.navigationController?.popViewController(animated: true)
    }

}
