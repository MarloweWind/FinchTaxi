//
//  ProfileAssembly.swift
//  FINCH TAXI
//
//  Created by Marlowe Wind on 11.02.2022.
//

import UIKit

final class ProfileAssembly {
    
    static func assembleModule() -> UIViewController {
        
        let dataConveter = ProfileDataConverter()
        
        let networkServies = GraphQLClient()
        let photoServies = PhotoServies()
        
        let tableViewManager = ProfileTableViewManager()
        let view = ProfileViewController()
        let router = ProfileRouter(view: view)
        let presenter = ProfilePresenter(dataConveter: dataConveter)
        let interactor = ProfileInteractor(photoServies: photoServies, networkServies: networkServies)
        
        view.presenter = presenter
        view.tableViewManager = tableViewManager
        
        tableViewManager.delegate = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        return view
    }
    
}
