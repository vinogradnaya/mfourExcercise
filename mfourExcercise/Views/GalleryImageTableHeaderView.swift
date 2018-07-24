//
//  GalleryImageTableHeaderView.swift
//  mfourExcercise
//
//  Created by Kateryna Vynogradna on 7/16/18.
//  Copyright © 2018 Kateryna Vynogradna. All rights reserved.
//

import UIKit

class GalleryImageTableHeaderViewViewModel: ViewModelProtocol {
    let imageUrl: String
    init(imageUrl: String) {
        self.imageUrl = imageUrl
    }
}

class GalleryImageTableHeaderView: UIView, ViewProtocol {
    typealias Model = GalleryImageTableHeaderViewViewModel

    @IBOutlet weak var imageView: UIImageView!

    var model: Model! {
        didSet {
            guard let url = URL(string: model.imageUrl) else {
                return
            }
            imageView.setImage(withUrl: url)
        }
    }
}
