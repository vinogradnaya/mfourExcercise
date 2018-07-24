//
//  Networking.swift
//  mfourExcercise
//
//  Created by Kateryna Vynogradna on 4/10/18.
//  Copyright © 2018 Kateryna Vynogradna. All rights reserved.
//

import Foundation

class NetworkService {
    private let provider: NetworkProvider
    
    required init(provider: NetworkProvider) {
        self.provider = provider
    }
}

extension NetworkService: NetworkServiceProtocol {
    @discardableResult
    func request<T: ResponseObjectSerializable>(_ endpoint: RestAPI, completionHandler: @escaping (Result<T>) -> Void) -> RequestProtocol {
        return provider.requestObject(endpoint, completionHandler: completionHandler)
    }

    @discardableResult
    func request<T: ResponseCollectionSerializable>(_ endpoint: RestAPI, completionHandler: @escaping (Result<[T]>) -> Void) -> RequestProtocol {
        return provider.requestCollection(endpoint, completionHandler: completionHandler)
    }
}
