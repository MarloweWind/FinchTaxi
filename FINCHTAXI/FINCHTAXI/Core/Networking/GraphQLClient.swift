//
//  GraphQLClient.swift
//  GetTransfer
//
//  Created by Artem on 19.01.2022.
//

import Apollo

protocol GraphQLClientInput {
    func fetch<Model: Decodable, Request: GraphQLQuery>(query: Request, completion: @escaping ((Result<Model, GraphQLError>) -> Void))
    func mutate<Model: Decodable, Request: GraphQLMutation>(mutation: Request, completion: @escaping ((Result<Model, GraphQLError>) -> Void))
}

final class GraphQLClient {
    
    private enum Locals {
        
        static let logoutCode = 401
        
    }
    
    // MARK: - Properties
    
    private lazy var apolloClient: ApolloClient? = {
        
        let configuration = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: configuration)
        
        if let baseGraphQLURL = URL(string: "https://taxi.dev.finch.fm/finch/cms/graphql") {
            
            let store = ApolloStore()
            let interceptorProvider = NetworkInterceptorProvider(client: URLSessionClient(sessionConfiguration: configuration),
                                                                 shouldInvalidateClientOnDeinit: false, store: store)
            let networkTransport = RequestChainNetworkTransport(interceptorProvider: interceptorProvider, endpointURL: baseGraphQLURL)
            
            return ApolloClient(networkTransport: networkTransport, store: store)
        }
        
        return nil
        
    }()
    
    
    // MARK: - Private methods
    
    private func parse<Model: Decodable>(selectionSet: GraphQLSelectionSet, completion: @escaping ((Result<Model, GraphQLError>) -> Void)) {
        do {
            let data = try JSONSerialization.data(withJSONObject: selectionSet.jsonObject.jsonValue, options: [])
            let model = try JSONDecoder().decode(Model.self, from: data)
            completion(.success(model))
        } catch let error {
            completion(.failure(.couldNotParse(error)))
        }
    }
}


// MARK: - GraphQLInput
extension GraphQLClient: GraphQLClientInput {
    
    func fetch<Model: Decodable, Request: GraphQLQuery>(query: Request, completion: @escaping ((Result<Model, GraphQLError>) -> Void)) {
        
        guard let apolloClient = apolloClient else {
            completion(.failure(.apiClientNotInitialized))
            return
        }
        
        apolloClient.fetch(query: query, cachePolicy: .fetchIgnoringCacheCompletely) { [weak self] result in
            switch result {
            
            case .success(let response):
                if let errors = response.errors, !errors.isEmpty {
                    completion(.failure(.backendError(errors)))
                } else if let data = response.data {
                    self?.parse(selectionSet: data, completion: completion)
                } else {
                    completion(.failure(.unknownError))
                }
                
            case .failure(let error):
                if let error = error as? ResponseCodeInterceptor.ResponseCodeError {
                    switch error {
                    case .invalidResponseCode(let response, _):
                        
                        if let response = response, response.statusCode == Locals.logoutCode {
                            // self?.supportService.reloadAndCleanTokensApp()
                        } else {
                            completion(.failure(.graphQLError(error)))
                        }
                    }
                    
                } else {
                    completion(.failure(.graphQLError(error)))
                }
                
            }
        }
    }
    
    func mutate<Model: Decodable, Request: GraphQLMutation>(mutation: Request, completion: @escaping ((Result<Model, GraphQLError>) -> Void)) {
        
        guard let apolloClient = apolloClient else {
            completion(.failure(.apiClientNotInitialized))
            return
        }
        
        apolloClient.perform(mutation: mutation) { [weak self] result in
            switch result {
            
            case .success(let response):
                if let errors = response.errors, !errors.isEmpty {
                    completion(.failure(.backendError(errors)))
                } else if let data = response.data {
                    self?.parse(selectionSet: data, completion: completion)
                } else {
                    completion(.failure(.unknownError))
                }
                
            case .failure(let error):
                completion(.failure(.graphQLError(error)))
            }
        }
    }
    
}
