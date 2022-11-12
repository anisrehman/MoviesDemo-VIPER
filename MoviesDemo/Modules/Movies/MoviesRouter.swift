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
        let movieDetailsViewController = MovieDetailsRouter.createModule(with: movie)
        movieDetailsViewController.title = "Movie Details"
        navigationController?.pushViewController(movieDetailsViewController, animated: true)
    }
}
