//
//  MapInteractor.swift
//  FINCHTAXI
//
//  Created by Marlowe Wind on 14.04.2022.
//

import Foundation

protocol MapInteractorInput { }

final class MapInteractor {
    
    // MARK: - Properties
    
    weak var presenter: MapInteractorOutput?
    
}


// MARK: - MapInteractorInput
extension MapInteractor: MapInteractorInput { }

