//
//  ApiKeys.swift
//  mfourExcercise
//
//  Created by Kateryna Vynogradna on 4/16/18.
//  Copyright © 2018 Kateryna Vynogradna. All rights reserved.
//

import Foundation

final class ApiKeys {
    let key: String

    private convenience init() {
        self.init(key: MFour.clientId)
    }
    
    private init(key: String) {
        self.key = key
    }
    
    static let shared = ApiKeys()
}
