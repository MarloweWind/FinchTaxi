//
//  Configurable.swift
//  FINCHTAXI
//
//  Created by Marlowe Wind on 25.03.2022.
//

protocol Configurable {
    associatedtype Model
    func configure(with model: Model)
}
