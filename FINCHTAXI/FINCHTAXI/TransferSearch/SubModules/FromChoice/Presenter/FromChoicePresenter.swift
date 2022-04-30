//
//  FromChoicePresenter.swift
//  FINCHTAXI
//
//  Created by Marlowe Wind on 12.04.2022.
//

import Foundation

protocol FromChoiceModuleOutput: AnyObject {
    func updateFromTransferName(fromTransferName: String)
}

protocol FromChoiceViewOutput: ViewOutput {
    func didTapBackButton()
    func didTapMapButton()
    func updatePlaceMark(to address: String)
}

final class FromChoicePresenter {

    // MARK: - Properties

    weak var view: FromChoiceViewInput?
    weak var fromChoiceDelegate: FromChoiceModuleOutput?
    var router: FromChoiceRouterInput?
    var viewModel: FromChoiceViewModel?

    private let dataConveter: FromChoiceDataConverter


    // MARK: - Init

    init(dataConveter: FromChoiceDataConverter) {
        self.dataConveter = dataConveter
    }

}


// MARK: - FromChoiceViewOutput
extension FromChoicePresenter: FromChoiceViewOutput {

    func didTapBackButton() {
        router?.backToTransferSearch()
    }

    func didTapMapButton() {
        router?.openMap(delegate: self)
    }

    func viewIsReady() {
        viewModel = FromChoiceViewModel(
            rows: [FromChoiceViewModel.Row(
                locationName: "",
                locationDetail: "")],
            mapLocationName: "")

        guard let fromChoiceViewModel = viewModel
        else {
            return
        }

        view?.updateView(viewModel: fromChoiceViewModel)
    }

    func updatePlaceMark(to address: String) {
        viewModel = dataConveter.convert(to: address)

        guard let fromChoiceViewModel = viewModel
        else {
            return
        }

        view?.updateView(viewModel: fromChoiceViewModel)
    }

}


// MARK: - FromChoiceTableViewManagerDelegate
extension FromChoicePresenter: FromChoiceTableViewManagerDelegate {
    func didTapLocationCell(fromTransferName: String) {
        fromChoiceDelegate?.updateFromTransferName(fromTransferName: fromTransferName)
        router?.backToTransferSearch()
    }
}


// MARK: - MapDelegate
extension FromChoicePresenter: MapDelegate {
    func updateTransferName(transferName: String) {

        viewModel = dataConveter.convert(to: transferName)

        guard let fromChoiceViewModel = viewModel
        else {
            return
        }

        view?.updateView(viewModel: fromChoiceViewModel)
    }
}
