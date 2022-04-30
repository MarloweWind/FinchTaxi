//
//  MainTabBarController.swift
//  FINCH TAXI
//
//  Created by Marlowe Wind on 09.02.2022.
//

import UIKit

protocol MainTabBarViewInput: AnyObject {
    func updateView(viewControllers: [UIViewController]?)
}

final class MainTabBarController: UITabBarController {
    
    // MARK: - Properties
    
    var presenter: MainTabBarViewOutput?
    
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        drawSelf()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    
    
    // MARK: - Private methods
    
    private func drawSelf() {        
        UITabBar.appearance().backgroundColor = .white
        UITabBar.appearance().barTintColor = .white
        tabBar.tintColor = .black
    }

}


// MARK: - MainTabBarViewInput
extension MainTabBarController: MainTabBarViewInput{
    
    func updateView(viewControllers: [UIViewController]?) {
        self.viewControllers = viewControllers
    }
    
}
