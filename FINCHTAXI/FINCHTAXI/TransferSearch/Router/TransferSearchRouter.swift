//
//  TransferSearchRouter.swift
//  FINCHTAXI
//
//  Created by Marlowe Wind on 21.03.2022.
//

import UIKit

protocol TransferSearchRouterInput {
    func didTapFromButton(delegate: FromChoiceModuleOutput)
}

final class TransferSearchRouter {
    
    // MARK: - Properties

    private unowned let view: UIViewController
    private let transition = PanelTransition()
    
    
    // MARK: - Init
    
    init(view: UIViewController) {
        self.view = view
    }
    
}


// MARK: - TransferSearchRouterInput
extension TransferSearchRouter: TransferSearchRouterInput {
    func didTapFromButton(delegate: FromChoiceModuleOutput) {
        let model = FromChoiceAssembly.Model(delegate: delegate)
        let fromScreen = FromChoiceAssembly.assembleModule(model: model)
        fromScreen.transitioningDelegate = transition
        fromScreen.modalPresentationStyle = .custom
        
        view.present(fromScreen, animated: true)
    }
}
