//
//  NetworkProviderProtocol.swift
//  mfourExcercise
//
//  Created by Kateryna Vynogradna on 7/22/18.
//  Copyright © 2018 Kateryna Vynogradna. All rights reserved.
//

import Foundation

protocol NetworkProviderProtocol {
    @discardableResult
    func requestObject<T: ResponseObjectSerializable>(_ endpoint: RestAPI, completionHandler: @escaping (Result<T>) -> Void) -> RequestProtocol
    
    @discardableResult
    func requestCollection<T: ResponseCollectionSerializable>(_ endpoint: RestAPI, completionHandler: @escaping (Result<[T]>) -> Void) -> RequestProtocol
}
