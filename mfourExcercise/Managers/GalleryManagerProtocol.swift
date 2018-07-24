//
//  GalleryManager.swift
//  mfourExcercise
//
//  Created by Kateryna Vynogradna on 7/15/18.
//  Copyright © 2018 Kateryna Vynogradna. All rights reserved.
//

import Foundation

protocol GalleryManagerProtocol {
    @discardableResult
    func search(query: String, completionHandler: @escaping (Result<[GalleryImage]>) -> Void) -> RequestProtocol

    @discardableResult
    func fetchComments(id: String, completionHandler:  @escaping (Result<[ImageComment]>) -> Void) -> RequestProtocol
}
