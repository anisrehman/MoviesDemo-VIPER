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
    func start()
}

class MainRouter: MainRoutable {
    var navigationController: UINavigationController
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        guard let viewController = navigationController.topViewController as? MoviesViewController else {
            fatalError("Top ViewController should be instance of MoviesViewController")
        }
        
        let interactor = MoviesInteractor()
        let moviesRouter = MoviesRouter()
        let presenter = MoviesPresenter(interface: viewController, interactor: interactor, router: moviesRouter)

        viewController.presenter = presenter
        moviesRouter.navigationController = viewController.navigationController
    }
}
