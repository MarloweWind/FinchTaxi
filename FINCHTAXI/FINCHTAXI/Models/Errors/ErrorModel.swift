//
//  ErrorModel.swift
//  FINCHTAXI
//
//  Created by Marlowe Wind on 04.03.2022.
//

enum ErrorModel: Error {
    
    private enum Locals {
        static let somethingWrongText = "Что-то пошло не так"
        static let connectionProblemText = "Нет подключения к интернету"
        static let phoneNumberProblemText = "Введите другой номер телефона"
        static let wrongCodeAlertMessage = "Вы ввели неверный код"
    }
    
    case somethingWrong
    case connectionProblem
    case phoneNumberProblem
    case wrongCodeAlert
    case custom(message: String? = nil)
    
    var message: String {
        switch self {
            
        case .somethingWrong:
            return Locals.somethingWrongText
            
        case .connectionProblem:
            return Locals.connectionProblemText
            
        case .phoneNumberProblem:
            return Locals.phoneNumberProblemText
            
        case.wrongCodeAlert:
            return Locals.wrongCodeAlertMessage
            
        case .custom(message: let message):
            if let message = message {
                return message
            }
        }
        return Locals.connectionProblemText
    }
    
}
