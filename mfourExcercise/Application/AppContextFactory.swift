//
//  AppContextFactory.swift
//  mfourExcercise
//
//  Created by Kateryna Vynogradna on 7/15/18.
//  Copyright © 2018 Kateryna Vynogradna. All rights reserved.
//

import Foundation

class AppContextFactory {
    static func context() -> AppContextProtocol {
        let service = NetworkService(provider: NetworkProvider())
        let manager = GalleryManager(networkService: service)
        let context = AppContext(galleryManager: manager)
        return context
    }
}
