//
//  ProfileInteractor.swift
//  FINCH TAXI
//
//  Created by Marlowe Wind on 11.02.2022.
//

import UIKit

protocol ProfileInteractorInput {
    func getUserProfile()
    var getUserPhoto: UIImage { get }
    func deleteUserData()
}

final class ProfileInteractor {
    
    // MARK: - Properties
    
    weak var presenter: ProfileInteractorOutput?
    
    private let userDefaults = UserDefaults.standard
    private let photoServies: PhotoServiesInput
    private let networkServies: GraphQLClientInput
    
    
    // MARK: - Init
    
    init(photoServies: PhotoServiesInput, networkServies: GraphQLClientInput) {
        self.photoServies = photoServies
        self.networkServies = networkServies
    }
    
}


// MARK: - ProfileInteractorInput
extension ProfileInteractor: ProfileInteractorInput {
    
    func getUserProfile() {
//        networkServies.fetch(query: GetProfileQuery()) {
//            [weak self] (result: Result<GetProfileModel, GraphQLError>) in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let result):
//                    self?.presenter?.getProfile(profile: result.userQuery.getProfile)
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }
//        }
        
        presenter?.getProfile(profile: GetProfile(user: User(name: "Иванов", surname: "Иван"), phone: userDefaults.userPhoneNumber ?? ""))
        
    }
    
    var getUserPhoto: UIImage {
        return photoServies.loadImageFromDocumentDirectory(fileName: "image") ?? UIImage()
    }

    func deleteUserData() {
        userDefaults.userPhoneNumber = nil
        userDefaults.token = nil
        photoServies.deleteImageFromDocumentDirectory(fileName: "image")
    }
    
}
