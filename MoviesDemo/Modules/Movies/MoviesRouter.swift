//
//  MoviesRouter.swift
//  MoviesDemo
//
//  Created Anis Rehman on 11/02/2020.
//  Copyright © 2020 Anis ur Rehman. All rights reserved.
//
//

import UIKit

class MoviesRouter: MoviesRoutable {
    
    weak var viewController: UIViewController?

    static func createModule(viewController: MoviesViewController) {
        let interactor = MoviesInteractor()
        let router = MoviesRouter()
        let presenter = MoviesPresenter(interface: viewController, interactor: interactor, router: router)

        viewController.presenter = presenter
        router.viewController = viewController
    }
    
    func routeToMovieDetails(movie: Movie) {
        let movieDetailsViewController = MovieDetailsRouter.createModule(with: movie)
        movieDetailsViewController.title = "Movie Details"
        viewController?.navigationController?.pushViewController(movieDetailsViewController, animated: true)
    }
}
