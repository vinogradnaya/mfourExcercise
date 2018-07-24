//
//  GalleryImage.swift
//  mfourExcercise
//
//  Created by Kateryna Vynogradna on 7/18/18.
//  Copyright © 2018 Kateryna Vynogradna. All rights reserved.
//

import Foundation

final class GalleryImage: NSObject, ResponseObjectSerializable {
    let id: String
    let imageURL: String

    init?(representation: Any) {
        guard let json = representation as? [String: Any] else {
            return nil
        }

        guard let type = json["type"] as? String, type == "image/jpeg" else {
            return nil
        }

        self.id = json["id"] as! String
        self.imageURL = json["link"] as! String
        super.init()
    }
}

extension GalleryImage: ResponseCollectionSerializable {
    static func collection(representation: Any) -> [GalleryImage] {
        guard let json = representation as? [String: Any] else {
            return []
        }

        guard let data = json["data"] as? [[String: Any]] else {
            return []
        }

        var gallery: [GalleryImage] = []
        data.forEach { dictionary in
            let isAlbum = dictionary["is_album"] as! Bool
            let albumId = dictionary["id"] as! String
            if isAlbum {
                let imagesJson = dictionary["images"] as! [[String: Any]]
                let images = imagesJson.compactMap({ dictionary -> GalleryImage? in
                    var dict = dictionary
                    // the comments can be found only for the gallery id, not for the specific image id
                    dict["id"] = albumId
                    return GalleryImage(representation: dict)
                })
                gallery.append(contentsOf: images)
            } else {
                if let image = GalleryImage(representation: dictionary) {
                    gallery.append(image)
                }
            }
        }
        return gallery
    }
}
