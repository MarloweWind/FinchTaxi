//
//  ProfileRouter.swift
//  FINCH TAXI
//
//  Created by Marlowe Wind on 11.02.2022.
//

import UIKit

protocol ProfileRouterInput {
    func openProfilEmptyeDetailsSreen()
    func openUserData(delegate: UserDataDelegate)
    func backToLoginScreen()
}

final class ProfileRouter {    
    
    // MARK: - Properties

    private unowned let view: UIViewController
    
    
    // MARK: - Init
    
    init(view: UIViewController) {
        self.view = view
    }
    
}


// MARK: - ProfileRouterInput
extension ProfileRouter: ProfileRouterInput {
    
    func openProfilEmptyeDetailsSreen() {
        view.navigationController?.pushViewController(ProfilEmptyeDetailViewController(), animated: true)
    }
    
    func openUserData(delegate: UserDataDelegate) {
        let model = UserDataAssembly.Model(delegate: delegate)
        let userDataView = UserDataAssembly.assembleModule(model: model)
        view.navigationController?.pushViewController(userDataView, animated: true)
    }
    
    func backToLoginScreen() {
        let loginView = LoginAssembly.assembleModule()
        view.navigationController?.pushViewController(loginView, animated: true)
        view.navigationController?.removeViewController(ProfileViewController.self)
        
        guard let window = view.view.window else { return }
        let navigationController = UINavigationController(rootViewController: loginView)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
}
