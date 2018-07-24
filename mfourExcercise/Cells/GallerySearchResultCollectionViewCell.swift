//
//  UISearchResultCollectionViewCell.swift
//  mfourExcercise
//
//  Created by Kateryna Vynogradna on 7/15/18.
//  Copyright © 2018 Kateryna Vynogradna. All rights reserved.
//

import UIKit
import Alamofire

class GallerySearchResultCollectionViewCellViewModel: ViewModelProtocol {
    let imageUrl: String
    init(imageUrl: String) {
        self.imageUrl = imageUrl
    }
}

class GallerySearchResultCollectionViewCell: UICollectionViewCell, CellProtocol {
    typealias Model = GallerySearchResultCollectionViewCellViewModel

    @IBOutlet weak var imageView: UIImageView!
    
    var model: Model! {
        didSet {
            guard let url = URL(string: model.imageUrl) else {
                return
            }
            imageView.setImage(withUrl: url)
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.cancelImageDownload()
        imageView.image = nil
    }
}
