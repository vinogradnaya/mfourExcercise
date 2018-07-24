//
//  UIView+Extension.swift
//  mfourExcercise
//
//  Created by Kateryna Vynogradna on 7/15/18.
//  Copyright © 2018 Kateryna Vynogradna. All rights reserved.
//

import UIKit

extension UIView {
    static func build() -> Self {
        return buildHelper()
    }

    private class func buildHelper<T>() -> T {
        let view = UINib(nibName: String(describing: self), bundle: nil).instantiate(withOwner: self, options: nil)[0] as! T
        return view
    }
}
