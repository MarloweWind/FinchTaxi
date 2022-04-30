//
//  GraphQLError.swift
//  SberSound
//
//  Created by Vlad Shmatok on 10.02.2021.
//

import Apollo

enum GraphQLError: LocalizedError {
    
    // MARK: - Properties
    
    var errorDescription: String? {
        
        switch self {
            
        case .couldNotParse(let error):
            return error.localizedDescription
            
        case .graphQLError(let error):
            return parseApolloError(error: error)
            
        case .backendError(let errors):
            return errors.compactMap({ $0.description }).joined(separator: "\n")
            
        case .apiClientNotInitialized:
            return "apiClientNotInitialized"
            
        case .unknownError:
            return "unknown"
        }
    }
    
    
    // MARK: - Cases
    
    case couldNotParse(Error)
    case graphQLError(Error)
    case backendError([Apollo.GraphQLError])
    case apiClientNotInitialized
    case unknownError
    
    
    // MARK: - Private methods
    
    private func parseApolloError(error: Error) -> String {
        guard let error = error as? URLSessionClient.URLSessionClientError else {
            return error.localizedDescription
        }
        
        switch error {
            
        case .noHTTPResponse:
            return "noHTTPResponse"
            
        case .sessionBecameInvalidWithoutUnderlyingError:
            return "sessionBecameInvalidWithoutUnderlyingError"
            
        case .dataForRequestNotFound:
            return "dataForRequestNotFound"
            
        case .networkError:
            return "networkError"
            
        case .sessionInvalidated:
            return "sessionInvalidated"
        }
        
    }
    
}
