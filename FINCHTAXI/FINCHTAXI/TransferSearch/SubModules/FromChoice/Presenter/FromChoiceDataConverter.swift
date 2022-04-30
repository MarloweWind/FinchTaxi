//
//  FromChoiceDataConverter.swift
//  FINCHTAXI
//
//  Created by Marlowe Wind on 20.04.2022.
//

import Foundation
import MapKit

protocol FromChoiceDataConverterInput {
    func convert(to address: String) -> FromChoiceViewModel
}

final class FromChoiceDataConverter {
    
    // MARK: - Types
    
    typealias Row = FromChoiceViewModel.Row
    
    
    // MARK: - Properties
    
    private var rows: [Row] = []
    
    
    // MARK: - Private methods
    
    private func updatePlaceMark(to address: String) -> [Row] {
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) {
            [weak self] (placemarks, error) in
            guard let placemark = placemarks?.first
            else {
                return
            }

            if placemark.isoCountryCode == "RU" {
                let description = placemark.description.components(separatedBy: "@").first
                let location = Row(locationName: placemark.name ?? "", locationDetail: description ?? "")
                self?.rows.insertIfNotContains(location, at: 0)

            } else {
                return
            }
            
        }
        return rows
    }
    
}


// MARK: - FromChoiceDataConverterInput
extension FromChoiceDataConverter: FromChoiceDataConverterInput {
    func convert(to address: String) -> FromChoiceViewModel {
        return FromChoiceViewModel(rows: updatePlaceMark(to: address), mapLocationName: address)
    }
}
