//
//  Extension + CLLocation.swift
//  FINCHTAXI
//
//  Created by Marlowe Wind on 14.04.2022.
//

import CoreLocation

extension CLLocation {
    
    func lookUpPlaceMark(_ handler: @escaping (CLPlacemark?) -> Void) {
        
        let geoCoder = CLGeocoder()
            
        geoCoder.reverseGeocodeLocation(self) { (placemarks, error) in
            if error == nil {
                let firstLocation = placemarks?[0]
                handler(firstLocation)
            } else {
                handler(nil)
                print("geocoder error")
            }
        }
    }
    
    
    func lookUpLocationName(_ handler: @escaping (String?) -> Void) {
        lookUpPlaceMark { (placemark) in
            handler(placemark?.name)
        }
    }
}
