//
//  CellProtocol.swift
//  mfourExcercise
//
//  Created by Kateryna Vynogradna on 7/16/18.
//  Copyright © 2018 Kateryna Vynogradna. All rights reserved.
//

import UIKit

protocol CellProtocol: ViewProtocol {
    static var staticReuseIdentifier: String { get }
    static var staticNibName: String { get }
}

extension CellProtocol {
    static var staticReuseIdentifier: String {
        return String(describing: self)
    }

    static var staticNibName: String {
        return String(describing: self)
    }
}
