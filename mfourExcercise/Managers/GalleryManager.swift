//
//  GalleryManager.swift
//  mfourExcercise
//
//  Created by Kateryna Vynogradna on 7/15/18.
//  Copyright © 2018 Kateryna Vynogradna. All rights reserved.
//

import Foundation

class GalleryManager {
    private(set) var networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
}

extension GalleryManager: GalleryManagerProtocol {
    @discardableResult
    func search(query: String, completionHandler:  @escaping (Result<[GalleryImage]>) -> Void) -> RequestProtocol {
        return networkService.request(RestAPI.gallerySearch(query: query), completionHandler: completionHandler)
    }

    @discardableResult
    func fetchComments(id: String, completionHandler:  @escaping (Result<[ImageComment]>) -> Void) -> RequestProtocol {
        return networkService.request(RestAPI.galleryImageComments(id: id), completionHandler: completionHandler)
    }
}
