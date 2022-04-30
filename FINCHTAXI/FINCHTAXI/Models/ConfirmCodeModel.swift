//
//  ConfirmCodeModel.swift
//  FINCHTAXI
//
//  Created by Marlowe Wind on 04.03.2022.
//

struct ConfirmCodeModel: Decodable {
    let userMutation: ConfirmCodeUserMutation

    enum CodingKeys: String, CodingKey {
        case userMutation = "UserMutation"
    }
}

struct ConfirmCodeUserMutation: Decodable {
    let confirmCode: ConfirmCode
}

struct ConfirmCode: Decodable {
    let token: String
}

