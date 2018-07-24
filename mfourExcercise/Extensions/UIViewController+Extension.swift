//
//  UIViewController+Extension.swift
//  mfourExcercise
//
//  Created by Kateryna Vynogradna on 7/22/18.
//  Copyright © 2018 Kateryna Vynogradna. All rights reserved.
//

import UIKit

extension UIViewController {
    func display(error: Error) {
        let title = NSLocalizedString("Error occured", comment: "")
        let buttonTitle = NSLocalizedString("Close", comment: "")
        let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
