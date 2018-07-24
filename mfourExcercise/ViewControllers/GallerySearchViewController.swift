//
//  GallerySearchViewController.swift
//  mfourExcercise
//
//  Created by Kateryna Vynogradna on 7/15/18.
//  Copyright © 2018 Kateryna Vynogradna. All rights reserved.
//

import UIKit

protocol GallerySearchViewControllerDelegate: class {
    func gallerySearchController(_ controller: GallerySearchViewController, didSelectImage image: GalleryImage)
}

class GallerySearchViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    weak var delegate: GallerySearchViewControllerDelegate?

    private let manager: GalleryManagerProtocol
    private var gallery: [GalleryImage] = []

    init(manager: GalleryManagerProtocol) {
        self.manager = manager
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

extension GallerySearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gallery.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GallerySearchResultCollectionViewCell.staticReuseIdentifier, for: indexPath) as! GallerySearchResultCollectionViewCell
        let model = GallerySearchResultCollectionViewCellViewModel(imageUrl: gallery[indexPath.row].imageURL)
        cell.model = model
        return cell
    }
}

extension GallerySearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.gallerySearchController(self, didSelectImage: gallery[indexPath.row])
    }
}

extension GallerySearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(search), object: nil)
        self.perform(#selector(search), with: nil, afterDelay: 0.5)
    }
}

private extension GallerySearchViewController {
    func setupView() {
        setupCollectionView()
        setupSearchBar()
    }

    func setupCollectionView() {
        collectionView.register(UINib(nibName: GallerySearchResultCollectionViewCell.staticNibName, bundle: nil), forCellWithReuseIdentifier: GallerySearchResultCollectionViewCell.staticReuseIdentifier)
    }

    func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = NSLocalizedString("Enter keyword (e.g. cats)", comment: "")
        navigationItem.title = NSLocalizedString("Gallery", comment: "")
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }

    @objc func search() {
        guard let query = navigationItem.searchController?.searchBar.text else {
            return
        }
        activityIndicator.startAnimating()
        manager.search(query: query) {[weak self] result in
            DispatchQueue.main.async {
                guard let `self` = self else {
                    return
                }
                self.activityIndicator.stopAnimating()
                switch result {
                case .success(let gallery):
                    self.display(gallery: gallery)
                case .failure(let error):
                    self.display(error: error)
                }
            }
        }
    }

    func display(gallery: [GalleryImage]) {
        self.gallery = gallery
        collectionView.reloadData()
    }
}

