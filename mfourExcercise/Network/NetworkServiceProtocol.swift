//
//  NetworkServiceProtocol.swift
//  mfourExcercise
//
//  Created by Omelette on 7/24/18.
//  Copyright © 2018 Kateryna Vynogradna. All rights reserved.
//

import Foundation

protocol NetworkServiceProtocol {
    @discardableResult
    func request<T: ResponseObjectSerializable>(_ endpoint: RestAPI, completionHandler: @escaping (Result<T>) -> Void) -> RequestProtocol

    @discardableResult
    func request<T: ResponseCollectionSerializable>(_ endpoint: RestAPI, completionHandler: @escaping (Result<[T]>) -> Void) -> RequestProtocol

}
