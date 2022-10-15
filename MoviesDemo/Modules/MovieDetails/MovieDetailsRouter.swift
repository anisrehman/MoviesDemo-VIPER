//
//  MovieDetailsRouter.swift
//  MoviesDemo
//
//  Created Anis Rehman on 13/02/2020.
//  Copyright © 2020 Anis ur Rehman. All rights reserved.
//
//

import UIKit

class MovieDetailsRouter: MovieDetailsRoutable {

    weak var viewController: UIViewController?

    static func createModule(with movie: Movie) -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let storyBoard = UIStoryboard(name: Storyboard.main.rawValue, bundle: nil)
        let viewController = storyBoard.instantiateViewController(identifier: StoryboardID.movieDetailsViewController.rawValue) as! MovieDetailsViewController
        let interactor = MovieDetailsInteractor()
        let router = MovieDetailsRouter()
        let presenter = MovieDetailsPresenter(interface: viewController, interactor: interactor, router: router, movie: movie)

        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController

        return viewController
    }
}
