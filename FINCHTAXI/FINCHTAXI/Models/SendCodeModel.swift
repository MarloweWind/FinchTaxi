//
//  SendCodeModel.swift
//  FINCHTAXI
//
//  Created by Marlowe Wind on 03.03.2022.
//

struct SendCodeModel: Decodable {
    let userMutation: SendCodeUserMutation

    enum CodingKeys: String, CodingKey {
        case userMutation = "UserMutation"
    }
}

struct SendCodeUserMutation: Decodable {
    let sendCode: Bool
}
