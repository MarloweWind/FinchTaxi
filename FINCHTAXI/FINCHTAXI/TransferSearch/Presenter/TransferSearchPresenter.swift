//
//  TransferSearchPresenter.swift
//  FINCHTAXI
//
//  Created by Marlowe Wind on 21.03.2022.
//

import Foundation

protocol TransferSearchViewOutput: ViewOutput { }

protocol TransferSearchInteractorOutput: AnyObject { }

final class TransferSearchPresenter {
    
    // MARK: - Properties
    
    weak var view: TransferSearchViewInput?
    var interactor: TransferSearchInteractorInput?
    var router: TransferSearchRouterInput?
    var viewModel: TransferSearchViewModel?
    var location: LocationType?
    
    private let dataConventer: TransferSearchDataConverterInput
    
    
    // MARK: - Init
    
    init(dataConventer: TransferSearchDataConverterInput) {
        self.dataConventer = dataConventer
    }
        
}


// MARK: - TransferSearchViewOutput
extension TransferSearchPresenter: TransferSearchViewOutput {
    
    func viewIsReady() {
        
        viewModel = dataConventer.convert(locationType: .none, transferButton: nil)
        
        guard let transferSearchViewModel = viewModel
        else {
            return
        }
        
        view?.updateView(viewModel: transferSearchViewModel)
        
    }
        
}


// MARK: - TransferSearchInteractorOutput
extension TransferSearchPresenter: TransferSearchInteractorOutput { }


// MARK: - TransferSearchTableViewManagerDelegate
extension TransferSearchPresenter: TransferSearchTableViewManagerDelegate {
    func didTapPresentFromView(locationType: LocationType) {
        location = locationType
        router?.didTapFromButton(delegate: self)
    }
}


// MARK: - FromChoiceDelegate
extension TransferSearchPresenter: FromChoiceModuleOutput {
    func updateFromTransferName(fromTransferName: String) {
        viewModel = dataConventer.convert(locationType: location, transferButton: fromTransferName)
        
        guard let transferSearchViewModel = viewModel
        else {
            return
        }

        view?.updateView(viewModel: transferSearchViewModel)
    }
}
