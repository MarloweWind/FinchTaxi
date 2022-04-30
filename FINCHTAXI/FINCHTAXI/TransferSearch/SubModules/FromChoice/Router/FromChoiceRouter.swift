//
//  FromChoiceRouter.swift
//  FINCHTAXI
//
//  Created by Marlowe Wind on 12.04.2022.
//

import UIKit

protocol FromChoiceRouterInput {
    func backToTransferSearch()
    func openMap(delegate: MapDelegate)
}

final class FromChoiceRouter {
    
    // MARK: - Properties

    private unowned let view: UIViewController
    
    
    // MARK: - Init
    
    init(view: UIViewController) {
        self.view = view
    }
    
}


// MARK: - FromChoiceRouterInput
extension FromChoiceRouter: FromChoiceRouterInput {
    func backToTransferSearch() {
        view.dismiss(animated: true)
    }
    
    func openMap(delegate: MapDelegate) {
        let model = MapAssembly.Model(delegate: delegate)
        let mapScreen = MapAssembly.assembleModule(model: model)
        view.present(mapScreen, animated: true)
    }
}
