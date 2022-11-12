//
//  MainRouter.swift
//  MoviesDemo-MVVM
//
//  Created by Anis Rehman on 11/11/2022.
//

import Foundation
import UIKit

protocol MainRoutable {
    init(navigationController: UINavigationController)
    var navigationController: UINavigationController { get set }
    func setupRouter()
}

class MainRouter: MainRoutable {
    var navigationController: UINavigationController
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func setupRouter() {
        guard let viewController = navigationController.topViewController as? MoviesViewController else {
            fatalError("Top ViewController should be instance of MoviesViewController")
        }
        MoviesRouter.createModule(viewController: viewController)
    }
}
