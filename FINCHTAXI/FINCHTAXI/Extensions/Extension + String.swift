//
//  Extension + String.swift
//  FINCH TAXI
//
//  Created by Marlowe Wind on 08.02.2022.
//

extension String {

    var isCheckedPhoneOperator: Bool {
        
        let maskArray = ["910", "911", "912", "913", "914",
                         "915", "916", "917", "918", "919",
                         "980", "981", "982", "983", "984",
                         "985", "986", "987", "988", "903",
                         "905", "909", "960", "961", "962",
                         "963", "964", "920", "921", "922",
                         "923", "924", "925", "926", "927",
                         "928", "929", "930", "931", "937"]
        
        for word in maskArray {
            if contains(word) {
                return true
            }
        }
        
        return false
    }

}
