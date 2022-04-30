//
//  CustomJSON.swift
//  SberSound
//
//  Created by Aleksandr Konakov on 08.05.2021.
//

import Apollo

// Добавлено для поддержки JSON-полей в GraphQL
// Без этих плясок оно падает где-то в недрах Apollo

public enum CustomJSON {
    case dictionary([String: Any])
    case array([Any])
    case json(String)
}


// MARK: - JSONDecodable
extension CustomJSON: JSONDecodable {
    
    public init(jsonValue value: JSONValue) throws {
        
        if let dict = value as? [String: Any] {
            if let string = dict.toString() {
                self = .json(string)
                return
            }
            self = .dictionary(dict)
        } else if let array = value as? [Any] {
            if let string = array.toString() {
                self = .json(string)
                return
            }
            self = .array(array)
        } else {
            throw JSONDecodingError.couldNotConvert(value: value, to: CustomJSON.self)
        }
    
    }
    
}


// MARK: - JSONEncodable
extension CustomJSON: JSONEncodable {
    
    public var jsonValue: JSONValue {
        switch self {
            
        case .dictionary(let dictionary):
            return dictionary.jsonValue
            
        case .array(let array):
            return array.jsonValue
            
        case .json(let string):
            return string.jsonValue
        }
    }
    
}
