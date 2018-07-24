//
//  AppCoordinator.swift
//  mfourExcercise
//
//  Created by Kateryna Vynogradna on 7/15/18.
//  Copyright © 2018 Kateryna Vynogradna. All rights reserved.
//

import UIKit

class AppCoordinator {
    private let window: UIWindow
    private let context: AppContextProtocol
    private var navigationController: UINavigationController!

    init(window: UIWindow, context: AppContextProtocol) {
        self.window = window
        self.context = context
    }
}

extension AppCoordinator: AppCoordinatorProtocol {
    func start() {
        let controller = GallerySearchViewController(manager: context.galleryManager)
        controller.delegate = self
        navigationController = UINavigationController(rootViewController: controller)
        window.rootViewController = navigationController
    }
}

extension AppCoordinator: GallerySearchViewControllerDelegate {
    func gallerySearchController(_ controller: GallerySearchViewController, didSelectImage image: GalleryImage) {
        let controller = GalleryImageDetailViewController(image: image, manager: context.galleryManager)
        navigationController.pushViewController(controller, animated: true)
    }
}
