//
//  MainTabBarPresenter.swift
//  FINCH TAXI
//
//  Created by Marlowe Wind on 11.02.2022.
//

import Foundation

protocol MainTabBarViewOutput: ViewOutput { }

final class MainTabBarPresenter {
    
    // MARK: - Properties
    
    weak var view: MainTabBarViewInput?
    var router: MainTabBarRouterInput?
    
}


// MARK: - SplashScreenViewOutput
extension MainTabBarPresenter: MainTabBarViewOutput {
    
    func viewWillAppear() {
        let modules = router?.prepareControllers()
        view?.updateView(viewControllers: modules)
    }
    
}
