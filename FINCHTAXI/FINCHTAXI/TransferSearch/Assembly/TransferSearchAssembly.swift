//
//  TransferSearchAssembly.swift
//  FINCHTAXI
//
//  Created by Marlowe Wind on 21.03.2022.
//

import UIKit

final class TransferSearchAssembly {
    
    static func assembleModule() -> UIViewController {
        
        let dataConventer = TransferSearchDataConverter()
        
        let tableViewManager = TransferSearchTableViewManager()
        let view = TransferSearchViewController()
        let router = TransferSearchRouter(view: view)
        let presenter = TransferSearchPresenter(dataConventer: dataConventer)
        let interactor = TransferSearchInteractor()
        
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
