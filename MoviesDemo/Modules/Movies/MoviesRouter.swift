//
//  MoviesRouter.swift
//  MoviesDemo
//
//  Created Anis Rehman on 11/02/2020.
//  Copyright © 2020 Anis ur Rehman. All rights reserved.
//
//

import UIKit

class MoviesRouter: MoviesWireframeProtocol {
    
    weak var viewController: UIViewController?

    static func createModule(viewController: MoviesViewController) {
        // Change to get view from storyboard if not using progammatic UI
        let interactor = MoviesInteractor()
        let router = MoviesRouter()
        let presenter = MoviesPresenter(interface: viewController, interactor: interactor, router: router)

        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
    }
    
    func routeToMovieDetails(movie: Movie, title: String) {
        let movieDetailsViewController = MovieDetailsRouter.createModule(with: movie)
        movieDetailsViewController.title = title
        viewController?.navigationController?.pushViewController(movieDetailsViewController, animated: true)

    }
}
