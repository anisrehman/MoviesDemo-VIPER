//
//  MoviesProtocols.swift
//  MoviesDemo
//
//  Created Anis Rehman on 11/02/2020.
//  Copyright © 2020 Anis ur Rehman. All rights reserved.
//
//

import Foundation

//MARK: Wireframe -
protocol MoviesRoutable: AnyObject {
    func routeToMovieDetails(movie: Movie, title: String)
}
//MARK: Presenter -
protocol MoviesPresentable: AnyObject {

    var interactor: MoviesInteractable? { get set }
    
    func fetchMovies(_ category: Category)
    func searchMovies(text: String, category: Category)
    func clearSearch(category: Category)
    func showMovieDetails(movie: Movie)
}

//MARK: Interactor -
protocol MoviesOutputInteractable: AnyObject {

    /* Interactor -> Presenter */
    func showMovies(_ movies: [Movie])
    func showError(_ error: Error)
}

protocol MoviesInteractable: AnyObject {

    var presenter: MoviesOutputInteractable?  { get set }
    var moviesService: MoviesService { get set }
    /* Presenter -> Interactor */
    func fetchMovies(_ category: Category)
    func searchMovies(text: String, category: Category)
    func clearSearch(category: Category)
}

//MARK: View -
protocol MoviesViewable: AnyObject {

    var presenter: MoviesPresentable?  { get set }

    /* Presenter -> ViewController */
    func showProgress();
    func hideProgress();
    func clearMoviesList();

    func displayMovies(_ movies: [Movie])
    func showError(_ error: Error)
}
