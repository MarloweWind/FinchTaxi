//
//  GetProfileModel.swift
//  FINCHTAXI
//
//  Created by Marlowe Wind on 14.03.2022.
//

struct GetProfileModel: Decodable {
    let userQuery: GetProfileUserQuery

    enum CodingKeys: String, CodingKey {
        case userQuery = "UserQuery"
    }
}

struct GetProfileUserQuery: Decodable {
    let getProfile: GetProfile
}

struct GetProfile: Decodable {
    let user: User
    let phone: String
}

struct User: Decodable {
    let name: String
    let surname: String
}

