//
//  Extension + RangeReplaceableCollection.swift
//  FINCHTAXI
//
//  Created by Marlowe Wind on 19.04.2022.
//

extension RangeReplaceableCollection where Element: Equatable {
    mutating func appendIfNotContains(_ element: Element)  {
        if !contains(element) {
            append(element)
        }
    }
    
    mutating func insertIfNotContains(_ element: Element, at: Self.Index)  {
        if !contains(element) {
            insert(element, at: at)
        }
    }
}
