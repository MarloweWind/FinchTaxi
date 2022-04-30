//
//  MainTabBarRouter.swift
//  FINCH TAXI
//
//  Created by Marlowe Wind on 11.02.2022.
//

import UIKit

protocol MainTabBarRouterInput {
    func prepareControllers() -> [UIViewController]
}

final class MainTabBarRouter {
    
    // MARK: - Locals
    
    private enum Locals {
        static let mainText = "Главная"
        static let profileText = "Профиль"
    }
    
        
    // MARK: - Properties

    private unowned let view: UIViewController
    
    
    // MARK: - Init
    
    init(view: UIViewController) {
        self.view = view
    }
    
    
    // MARK: - Private methods
    
    private func createNavigationController(
        for rootViewController: UIViewController,
        title: String,
        image: UIImage) -> UIViewController {
          let navigationController = UINavigationController(rootViewController: rootViewController)
          navigationController.tabBarItem.title = title
          navigationController.tabBarItem.image = image
          return navigationController
      }
   
}


// MARK: - SplashScreenRouterInput
extension MainTabBarRouter: MainTabBarRouterInput {
    
    func prepareControllers() -> [UIViewController] {
        let profileViewController = ProfileAssembly.assembleModule()
        let transferSearchViewController = TransferSearchAssembly.assembleModule()
        return [
            createNavigationController(for: transferSearchViewController,
                                       title: Locals.mainText,
                                       image: UIImage(named: "finchHouse") ?? UIImage()),
            createNavigationController(for: profileViewController,
                                       title: Locals.profileText,
                                       image: UIImage(named: "finchPerson") ?? UIImage()),
        ]
    }

}
