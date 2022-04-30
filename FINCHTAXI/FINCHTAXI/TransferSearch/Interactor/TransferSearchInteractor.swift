//
//  TransferSearchInteractor.swift
//  FINCHTAXI
//
//  Created by Marlowe Wind on 21.03.2022.
//

import Foundation

protocol TransferSearchInteractorInput { }

final class TransferSearchInteractor {
    
    // MARK: - Properties
    
    weak var presenter: TransferSearchInteractorOutput?
    
}


// MARK: - TransferSearchInteractorInput
extension TransferSearchInteractor: TransferSearchInteractorInput {
//    CreateTripMutation
}
