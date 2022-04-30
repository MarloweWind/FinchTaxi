//
//  ConfirmeCodePresenter.swift
//  FINCH TAXI
//
//  Created by Marlowe Wind on 03.02.2022.
//

import Foundation

protocol ConfirmeCodeViewOutput: ViewOutput {
    var getUserPhone: String? { get }
    
    func didTapReadyButton(code: String)
    func didTapAnotherNumberButton()
    func setTimer()
}

protocol ConfirmeCodeInteractorOutput: AnyObject {
    func didConfirmCode()
    func didFailConfirmCode(errorModel: ErrorModel)
}

final class ConfirmeCodePresenter {
    
    // MARK: - Properties
    
    weak var view: ConfirmeCodeViewInput?
    var interactor: ConfirmeCodeInteractorInput?
    var router: ConfirmeCodeRouterInput?
    
    private var timer: Timer?
    private var timerSeconds = 30
    
    
    // MARK: - Private methods
    
    private func deleteTimer() {
        timer?.invalidate()
        timer = nil
        timerSeconds = 30
    }
    
    
    // MARK: - Actions
    
    @objc private func updateTimer() {
        timerSeconds -= 1
        let isHiddenTimer = timerSeconds == 0
        if isHiddenTimer {
            deleteTimer()
        }
        view?.updateTimer(seconds: timerSeconds, isHiddenTimer: isHiddenTimer)
    }
    
}


// MARK: - ConfirmeCodeViewOutput
extension ConfirmeCodePresenter: ConfirmeCodeViewOutput {
    
    var getUserPhone: String? {
        return interactor?.getUserPhone
    }
    
    func viewIsReady() {
        setTimer()
    }
    
    func viewWillDisappear() {
        deleteTimer()
    }
    
    func didTapReadyButton(code: String) {
        interactor?.setToken(code: code)
    }
    
    func didTapAnotherNumberButton() {
        router?.backToLigonScreen()
    }
    
    func setTimer() {
        view?.updateTimer(seconds: timerSeconds, isHiddenTimer: false)
        deleteTimer()
        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(updateTimer),
            userInfo: nil,
            repeats: true)
    }

}


// MARK: - ConfirmeCodeInteractorOutput
extension ConfirmeCodePresenter: ConfirmeCodeInteractorOutput {
    
    func didConfirmCode() {
        router?.openMainModule()
    }
    
    func didFailConfirmCode(errorModel: ErrorModel) {
        view?.didFailConfirmCode(errorModel: errorModel)
    }
}
