//
//  Profile.swift
//  FINCH TAXI
//
//  Created by Marlowe Wind on 11.02.2022.
//

import UIKit

struct ProfileViewModel {
    let rows: [Row]
    var name: String
    var surname: String
    var phone: String
    var image: UIImage?
}

extension ProfileViewModel {
    
    struct Row {
        
        enum SelectType {
            case userInfo
            case others
        }
        
        let selectType: SelectType
        let profileName: String
        
        init(selectTyper: SelectType = .others, profileName: String) {
            self.selectType = selectTyper
            self.profileName = profileName
        }
    }
    
}
