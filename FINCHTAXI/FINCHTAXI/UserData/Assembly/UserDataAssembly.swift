//
//  UserDataAssembly.swift
//  FINCH TAXI
//
//  Created by Marlowe Wind on 15.02.2022.
//

import UIKit

final class UserDataAssembly {
    
    static func assembleModule(model: Model) -> UIViewController {
        
        let photoServies = PhotoServies()
        let networkServies = GraphQLClient()
        
        let view = UserDataViewController()
        let router = UserDataRouter(view: view)
        let presenter = UserDataPresenter()
        let interactor = UserDataInteractor(photoServies: photoServies,
                                            networkServies: networkServies)
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        presenter.delegate = model.delegate
        
        interactor.presenter = presenter
        
        return view
    }
    
}

extension UserDataAssembly {
    
    struct Model {
        weak var delegate: UserDataDelegate?
    }
    
}
