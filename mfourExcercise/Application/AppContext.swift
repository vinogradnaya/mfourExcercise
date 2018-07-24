//
//  AppContext.swift
//  mfourExcercise
//
//  Created by Kateryna Vynogradna on 7/15/18.
//  Copyright © 2018 Kateryna Vynogradna. All rights reserved.
//

import Foundation

class AppContext: AppContextProtocol {
    private(set) var galleryManager: GalleryManagerProtocol

    init(galleryManager: GalleryManagerProtocol) {
        self.galleryManager = galleryManager
    }
}
