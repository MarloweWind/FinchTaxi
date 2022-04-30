//
//  MapPresenter.swift
//  FINCHTAXI
//
//  Created by Marlowe Wind on 14.04.2022.
//

import Foundation

protocol MapViewOutput: ViewOutput {
    func didTapReadyButton()
}

protocol MapInteractorOutput: AnyObject { }

final class MapPresenter {
    
    // MARK: - Properties
    
    weak var view: MapViewInput?
    var interactor: MapInteractorInput?
    var router: MapRouterInput?
    
}


// MARK: - MapViewOutput
extension MapPresenter: MapViewOutput {
    func didTapReadyButton() {
        router?.backToFromChoice()
    }
}


// MARK: - MapInteractorOutput
extension MapPresenter: MapInteractorOutput { }
