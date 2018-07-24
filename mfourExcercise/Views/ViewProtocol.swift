//
//  ViewProtocol.swift
//  mfourExcercise
//
//  Created by Kateryna Vynogradna on 7/16/18.
//  Copyright © 2018 Kateryna Vynogradna. All rights reserved.
//

import Foundation

protocol ViewModelProtocol {}

protocol ViewProtocol: class {
    associatedtype Model: ViewModelProtocol
    var model: Model! { get set }
}
