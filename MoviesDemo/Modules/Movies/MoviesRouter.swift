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
    
    var navigationController: UINavigationController?
    
    func routeToMovieDetails(movie: Movie) {
        let viewController = setupMovieDetails(movie)
        
        viewController.title = "Movie Details"
        navigationController?.pushViewController(viewController, animated: true)
    }
}

//MARK: - Private Functions
extension MoviesRouter {
    private func setupMovieDetails(_ movie: Movie) -> MovieDetailsViewController {
        let storyBoard = UIStoryboard(name: Storyboard.main.rawValue, bundle: nil)
        let movieDetailsViewController = storyBoard.instantiateViewController(identifier: StoryboardID.movieDetailsViewController.rawValue) as! MovieDetailsViewController

        let interactor = MovieDetailsInteractor()
        let router = MovieDetailsRouter()
        let presenter = MovieDetailsPresenter(interface: movieDetailsViewController, interactor: interactor, router: router, movie: movie)

        movieDetailsViewController.presenter = presenter
        interactor.presenter = presenter

        return movieDetailsViewController;
    }
}
