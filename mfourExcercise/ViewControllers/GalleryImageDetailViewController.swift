//
//  GalleryImageDetailViewController.swift
//  mfourExcercise
//
//  Created by Kateryna Vynogradna on 7/16/18.
//  Copyright © 2018 Kateryna Vynogradna. All rights reserved.
//

import UIKit

class GalleryImageDetailViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private let image: GalleryImage
    private let manager: GalleryManagerProtocol
    private var comments: [ImageComment] = []
    private var request: RequestProtocol?

    init(image: GalleryImage, manager: GalleryManagerProtocol) {
        self.image = image
        self.manager = manager
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
         super.viewDidLoad()
        setupTableView(forImage: image)
        request = fetchComments(forImage: image)
    }

    override func viewWillDisappear(_ animated: Bool) {
        request?.cancelRequest()
        super.viewWillDisappear(animated)
    }
}

extension GalleryImageDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.staticReuseIdentifier, for: indexPath) as! CommentTableViewCell
        let comment = comments[indexPath.row]
        let model = CommentTableViewCellViewModel(author: comment.author, comment: comment.text)
        cell.model = model
        return cell
    }
}

private extension GalleryImageDetailViewController {
    func setupTableView(forImage image: GalleryImage) {
        tableView.register(UINib(nibName: CommentTableViewCell.staticNibName, bundle: nil), forCellReuseIdentifier: CommentTableViewCell.staticReuseIdentifier)
        tableView.tableHeaderView = createTableHeaderView(forImage: image)
    }

    func createTableHeaderView(forImage image: GalleryImage) -> GalleryImageTableHeaderView {
        let headerModel = GalleryImageTableHeaderViewViewModel(imageUrl: image.imageURL)
        let headerView = GalleryImageTableHeaderView.build()
        headerView.model = headerModel
        return headerView
    }

    func fetchComments(forImage image: GalleryImage) -> RequestProtocol {
        return manager.fetchComments(id: image.id) {[weak self] result in
            DispatchQueue.main.async {
                guard let `self` = self else {
                    return
                }
                switch result {
                case .success(let comments):
                    self.display(comments: comments)
                case .failure(let error):
                    self.display(error: error)
                }
            }
        }
    }

    func display(comments: [ImageComment]) {
        self.comments = comments
        self.tableView.reloadData()
    }
}
