//
//  UserDataInteractor.swift
//  FINCH TAXI
//
//  Created by Marlowe Wind on 15.02.2022.
//

import UIKit

protocol UserDataInteractorInput {
    func getUserPhoto() -> UIImage?
    func setUserPhoto(image: UIImage, fileName: String)
    func updateProfile(name: String, surname: String)
}

final class UserDataInteractor {
    
    // MARK: - Properties
    
    weak var presenter: UserDataInteractorOutput?
    
    private let userDefaults = UserDefaults.standard
    private let photoServies: PhotoServiesInput
    private let networkServies: GraphQLClientInput
    
    
    // MARK: - Init
    
    init(photoServies: PhotoServiesInput, networkServies: GraphQLClientInput) {
        self.photoServies = photoServies
        self.networkServies = networkServies
    }
    
}


// MARK: - UserDataInteractorInput
extension UserDataInteractor: UserDataInteractorInput {
    
    func updateProfile(name: String, surname: String) {
        
//        networkServies.mutate(mutation: UpdateProfileMutation(profile: InputUserProfile(name: name, surname: surname))) {
//            [weak self] (result: Result<UpdateProfileModel, GraphQLError>) in
//
//            DispatchQueue.main.async {
//                switch result {
//                case .success(_):
//
//                    self?.presenter?.didUpdatedProfile()
//                    print("update profile success")
//
//                case .failure(let error):
//
//                    let errorModel = ErrorModel.custom(message: error.errorDescription)
//
//                    if error.errorDescription?.isEmpty != true {
//                        self?.presenter?.didFailToUpdateProfile(errorModel: errorModel)
//                    }
//
//                }
//            }
//        }
        
        presenter?.didUpdatedProfile()
        
    }
    
    func getUserPhoto() -> UIImage? {
        return photoServies.loadImageFromDocumentDirectory(fileName: "image")
    }
    
    func setUserPhoto(image: UIImage, fileName: String) {
        photoServies.saveImageInDocumentDirectory(image: image, fileName: fileName)
    }
    
}
