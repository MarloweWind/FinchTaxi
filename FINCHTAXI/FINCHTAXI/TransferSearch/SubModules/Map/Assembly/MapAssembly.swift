//
//  MapAssembly.swift
//  FINCHTAXI
//
//  Created by Marlowe Wind on 14.04.2022.
//

import UIKit

final class MapAssembly {
    
    static func assembleModule(model: Model) -> UIViewController {
        let view = MapViewController()
        let router = MapRouter(view: view)
        let presenter = MapPresenter()
        let interactor = MapInteractor()
        
        view.presenter = presenter
        view.mapDelegate = model.delegate
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        return view
    }
    
}

extension MapAssembly {
    
    struct Model {
        weak var delegate: MapDelegate?
    }
    
}
