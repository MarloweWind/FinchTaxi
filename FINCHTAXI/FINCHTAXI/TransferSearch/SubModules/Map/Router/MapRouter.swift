//
//  MapRouter.swift
//  FINCHTAXI
//
//  Created by Marlowe Wind on 14.04.2022.
//

import UIKit

protocol MapRouterInput {
    func backToFromChoice()
}

final class MapRouter {
    
    // MARK: - Properties

    private unowned let view: UIViewController
    
    
    // MARK: - Init
    
    init(view: UIViewController) {
        self.view = view
    }
    
}


// MARK: - MapRouterInput
extension MapRouter: MapRouterInput {
    func backToFromChoice() {
        view.dismiss(animated: true)
    }
}
