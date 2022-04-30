//
//  MainTabBarAssembly.swift
//  FINCH TAXI
//
//  Created by Marlowe Wind on 11.02.2022.
//

import UIKit

final class MainTabBarAssembly {
    
    static func assembleModule() -> UITabBarController {
        let view = MainTabBarController()
        let router = MainTabBarRouter(view: view)
        let presenter = MainTabBarPresenter()
        view.presenter = presenter
        
        presenter.view = view
        presenter.router = router
        
        return view
    }
    
}
