//
//  ProfilePresenter.swift
//  FINCH TAXI
//
//  Created by Marlowe Wind on 11.02.2022.
//

import UIKit

protocol ProfileViewOutput: ViewOutput {
    var getUserPhoto: UIImage? { get }
    func didTapExitButton()
}

protocol ProfileInteractorOutput: AnyObject {
    func getProfile(profile: GetProfile)
}

final class ProfilePresenter {
    
    // MARK: - Properties
    
    weak var view: ProfileViewInput?
    var interactor: ProfileInteractorInput?
    var router: ProfileRouterInput?
    var viewModel: ProfileViewModel?
    
    private let dataConveter: ProfileDataConverter


    // MARK: - Init

    init(dataConveter: ProfileDataConverter) {
        self.dataConveter = dataConveter
    }
    
}


// MARK: - ProfileViewOutput
extension ProfilePresenter: ProfileViewOutput {
    
    var getUserPhoto: UIImage? {
        return interactor?.getUserPhoto
    }
    
    func viewIsReady() {
        
        viewModel = dataConveter.convert()
        
        guard let profileViewModel = viewModel
        else {
            return
        }
        
        interactor?.getUserProfile()
        view?.updateView(viewModel: profileViewModel)
        
    }
    
    func viewWillAppear() {
        
        viewModel?.image = getUserPhoto
        
        guard let profileViewModel = viewModel
        else {
            return
        }
        
        view?.updateView(viewModel: profileViewModel)
    }

    func didTapExitButton() {
        interactor?.deleteUserData()
        router?.backToLoginScreen()
    }
    
}


// MARK: - ProfileInteractorOutput
extension ProfilePresenter: ProfileInteractorOutput {
    func getProfile(profile: GetProfile) {
        
        viewModel?.name = profile.user.name
        viewModel?.surname = profile.user.surname
        viewModel?.phone = profile.phone
        
        guard let profileViewModel = viewModel
        else {
            return
        }
        
        view?.updateView(viewModel: profileViewModel)
    }
}


// MARK: - ProfileTableViewManagerDelegate
extension ProfilePresenter: ProfileTableViewManagerDelegate {
    
    func didTapUserData() {
        router?.openUserData(delegate: self)
    }
    
    func didTapProfilEmptyeDetail() {
        router?.openProfilEmptyeDetailsSreen()
    }
    
}


// MARK: - UserDataDelegate
extension ProfilePresenter: UserDataDelegate {
    
    func passData(name: String, surname: String) {
        
        viewModel?.name = name
        viewModel?.surname = surname
        
        guard let profileViewModel = viewModel
        else {
            return
        }
        
        view?.updateView(viewModel: profileViewModel)
    }
    
}
