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
protocol MoviesWireframeProtocol: AnyObject {
    func routeToMovieDetails(movie: Movie, title: String)
}
//MARK: Presenter -
protocol MoviesPresenterProtocol: AnyObject {

    var interactor: MoviesInteractorInputProtocol? { get set }
    
    func loadMovies(_ category: Category)
    func searchMovies(text: String, category: Category)
    func clearSearch(category: Category)
    func showMovieDetails(movie: Movie)
}

//MARK: Interactor -
protocol MoviesInteractorOutputProtocol: AnyObject {

    /* Interactor -> Presenter */
    func showMovies(_ movies: [Movie])
    func showError(_ error: Error)
}

protocol MoviesInteractorInputProtocol: AnyObject {

    var presenter: MoviesInteractorOutputProtocol?  { get set }

    /* Presenter -> Interactor */
    func loadMovies(_ category: Category)
    func searchMovies(text: String, category: Category)
    func clearSearch(category: Category)
}

//MARK: View -
protocol MoviesViewProtocol: AnyObject {

    var presenter: MoviesPresenterProtocol?  { get set }

    /* Presenter -> ViewController */
    func moviesLoaded(_ movies: [Movie])
    func moviesLoadFailed(_ error: Error)
}
