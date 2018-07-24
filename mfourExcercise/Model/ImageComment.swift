//
//  ImageComment.swift
//  mfourExcercise
//
//  Created by Kateryna Vynogradna on 7/20/18.
//  Copyright © 2018 Kateryna Vynogradna. All rights reserved.
//

import Foundation

final class ImageComment: NSObject, ResponseObjectSerializable {
    let id: Int
    let text: String
    let author: String
    let authorId: Int

    init?(representation: Any) {
        guard let json = representation as? [String: Any] else {
            return nil
        }

        self.id = json["id"] as! Int
        self.text = json["comment"] as! String
        self.author = json["author"] as! String
        self.authorId = json["author_id"] as! Int
        super.init()
    }
}

extension ImageComment: ResponseCollectionSerializable {
    static func collection(representation: Any) -> [ImageComment] {
        guard let json = representation as? [String: Any] else {
            return []
        }

        guard let data = json["data"] as? [[String: Any]] else {
            return []
        }

        return data.compactMap({ dictionary -> ImageComment? in
            return ImageComment(representation: dictionary)
        })
    }
}
