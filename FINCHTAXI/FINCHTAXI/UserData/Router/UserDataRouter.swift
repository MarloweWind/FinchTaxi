//
//  UserDataRouter.swift
//  FINCH TAXI
//
//  Created by Marlowe Wind on 15.02.2022.
//

import UIKit

protocol UserDataRouterInput {
    func backToProfile()
}

final class UserDataRouter {    
    
    // MARK: - Properties

    private unowned let view: UIViewController
    
    
    // MARK: - Init
    
    init(view: UIViewController) {
        self.view = view
    }
    
}


// MARK: - UserDataRouterInput
extension UserDataRouter: UserDataRouterInput {
    
    func backToProfile() {
        view.navigationController?.popViewController(animated: true)
    }
    
}
