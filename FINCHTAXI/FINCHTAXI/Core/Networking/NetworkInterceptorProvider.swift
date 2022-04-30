//
//  NetworkInterceptorProvider.swift
//  SberSound
//
//  Created by Aleksandr Konakov on 28.04.2021.
//

import Apollo

final class NetworkInterceptorProvider: LegacyInterceptorProvider {
    
    override func interceptors<Operation: GraphQLOperation>(for operation: Operation) -> [ApolloInterceptor] {
        var interceptors = super.interceptors(for: operation)
        interceptors.insert(CustomInterceptor(), at: 0)
        return interceptors
    }
    
}
