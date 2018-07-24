//
//  CommentTableViewCell.swift
//  mfourExcercise
//
//  Created by Kateryna Vynogradna on 7/16/18.
//  Copyright © 2018 Kateryna Vynogradna. All rights reserved.
//

import UIKit

class CommentTableViewCellViewModel: ViewModelProtocol {
    let author: String
    let comment: String

    init(author: String, comment: String) {
        self.author = author
        self.comment = comment
    }
}

class CommentTableViewCell: UITableViewCell, CellProtocol {
    typealias Model = CommentTableViewCellViewModel

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var commentTextView: UITextView!

    var model: Model! {
        didSet {
            authorLabel.text = model.author
            commentTextView.text = model.comment
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        authorLabel.text = nil
        commentTextView.text = nil
    }
}
