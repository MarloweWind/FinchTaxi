//
//  UserDataPresenter.swift
//  FINCH TAXI
//
//  Created by Marlowe Wind on 15.02.2022.
//

import UIKit

protocol UserDataDelegate: AnyObject {
    func passData(name: String, surname: String)
}

protocol UserDataViewOutput: ViewOutput {
    func getUserPhoto() -> UIImage?
    func didTapConfirmButton(name: String, surname: String)
    func didSetUserPhoto(image: UIImage, fileName: String)
}

protocol UserDataInteractorOutput: AnyObject {
    func didUpdatedProfile()
    func didFailToUpdateProfile(errorModel: ErrorModel)
}

final class UserDataPresenter {
    
    // MARK: - Properties
    
    weak var view: UserDataViewInput?
    weak var delegate: UserDataDelegate?
    var interactor: UserDataInteractorInput?
    var router: UserDataRouterInput?
    
}


// MARK: - UserDataViewOutput
extension UserDataPresenter: UserDataViewOutput {
    
    func getUserPhoto() -> UIImage? {
        return interactor?.getUserPhoto()
    }
    
    func didTapConfirmButton(name: String, surname: String) {
        interactor?.updateProfile(name: name, surname: surname)
        delegate?.passData(name: name, surname: surname)
    }
    
    func didSetUserPhoto(image: UIImage, fileName: String) {
        interactor?.setUserPhoto(image: image, fileName: fileName)
    }
    
}


// MARK: - UserDataInteractorOutput
extension UserDataPresenter: UserDataInteractorOutput {
    
    func didUpdatedProfile() {
        router?.backToProfile()
    }
    
    func didFailToUpdateProfile(errorModel: ErrorModel) {
        view?.didFailToUpdateProfile(errorModel: errorModel)
    }
}


