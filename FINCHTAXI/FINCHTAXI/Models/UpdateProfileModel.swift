//
//  UpdateProfileModel.swift
//  FINCHTAXI
//
//  Created by Marlowe Wind on 11.03.2022.
//

struct UpdateProfileModel: Decodable {
    let userMutation: UpdateProfileUserMutation

    enum CodingKeys: String, CodingKey {
        case userMutation = "UserMutation"
    }
}

struct UpdateProfileUserMutation: Decodable {
    let updateProfile: UpdateProfile
}

struct UpdateProfile: Decodable {
}

