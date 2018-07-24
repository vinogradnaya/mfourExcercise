//
//  NetworkProvider.swift
//  mfourExcercise
//
//  Created by Kateryna Vynogradna on 4/13/18.
//  Copyright © 2018 Kateryna Vynogradna. All rights reserved.
//

import Foundation
import Alamofire

class NetworkProvider: NetworkProviderProtocol {
    @discardableResult
    func requestObject<T: ResponseObjectSerializable>(_ endpoint: RestAPI, completionHandler: @escaping (Result<T>) -> Void) -> RequestProtocol {
        return Alamofire.request(endpoint).validate().responseObject { (response: DataResponse<T>) in
            if let result = response.result.value {
                completionHandler(.success(result))
            } else if let error = response.error {
                completionHandler(.failure(error))
            }
        }
    }

    @discardableResult
    func requestCollection<T: ResponseCollectionSerializable>(_ endpoint: RestAPI, completionHandler: @escaping (Result<[T]>) -> Void) -> RequestProtocol {
        return Alamofire.request(endpoint).validate().responseCollection { (response: DataResponse<[T]>) in
            if let result = response.result.value {
                completionHandler(.success(result))
            } else if let error = response.error {
                completionHandler(.failure(error))
            }
        }
    }
}

