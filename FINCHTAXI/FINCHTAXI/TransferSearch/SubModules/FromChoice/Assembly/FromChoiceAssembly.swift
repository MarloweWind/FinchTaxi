//
//  FromChoiceAssembly.swift
//  FINCHTAXI
//
//  Created by Marlowe Wind on 12.04.2022.
//

import UIKit

final class FromChoiceAssembly {
    
    static func assembleModule(model: Model) -> UIViewController {
        
        let dataConveter = FromChoiceDataConverter()
        
        let tableViewManager = FromChoiceTableViewManager()
        let view = FromChoiceViewController()
        let router = FromChoiceRouter(view: view)
        let presenter = FromChoicePresenter(dataConveter: dataConveter)
        
        view.presenter = presenter
        view.tableViewManager = tableViewManager
        
        tableViewManager.delegate = presenter
        
        presenter.view = view
        presenter.router = router
        presenter.fromChoiceDelegate = model.delegate
        
        return view
    }
    
}

extension FromChoiceAssembly {
    
    struct Model {
        weak var delegate: FromChoiceModuleOutput?
    }
    
}
