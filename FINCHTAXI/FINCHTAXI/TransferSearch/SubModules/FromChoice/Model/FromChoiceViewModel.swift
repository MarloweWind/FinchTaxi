//
//  FromChoiceViewModel.swift
//  FINCHTAXI
//
//  Created by Marlowe Wind on 15.04.2022.
//

struct FromChoiceViewModel {
    var rows: [Row]
    var mapLocationName: String
}

extension FromChoiceViewModel {
    
    struct Row: Equatable {
        
        let locationName: String
        let locationDetail: String
        
        init(locationName: String, locationDetail: String) {
            self.locationName = locationName
            self.locationDetail = locationDetail
        }
    }
    
}
