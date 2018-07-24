//
//  Kingfisher+Extension.swift
//  mfourExcercise
//
//  Created by Kateryna Vynogradna on 7/20/18.
//  Copyright © 2018 Kateryna Vynogradna. All rights reserved.
//

import Foundation
import Kingfisher

extension UIImageView {
    func setImage(withUrl url: URL) {
        self.kf.setImage(with: url, options: [.transition(ImageTransition.fade(0.2))])
    }

    func cancelImageDownload() {
        self.kf.cancelDownloadTask()
    }
}
