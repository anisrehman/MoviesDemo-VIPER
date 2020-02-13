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
protocol MoviesWireframeProtocol: class {
    func routeToMovieDetails(movie: Movie, title: String)
}
//MARK: Presenter -
protocol MoviesPresenterProtocol: class {

    var interactor: MoviesInteractorInputProtocol? { get set }
    
    func loadMovies(_ category: Category)
    func searchMovies(text: String, category: Category)
    func clearSearch(category: Category)
    func showMovieDetails(movie: Movie)
}

//MARK: Interactor -
protocol MoviesInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
    func moviesLoaded(_ movies: [Movie])
    func moviesLoadFailed(_ error: Error)
}

protocol MoviesInteractorInputProtocol: class {

    var presenter: MoviesInteractorOutputProtocol?  { get set }

    /* Presenter -> Interactor */
    func loadMovies(_ category: Category)
    func searchMovies(text: String, category: Category)
    func clearSearch(category: Category)
}

//MARK: View -
protocol MoviesViewProtocol: class {

    var presenter: MoviesPresenterProtocol?  { get set }

    /* Presenter -> ViewController */
    func moviesLoaded(_ movies: [Movie])
    func moviesLoadFailed(_ error: Error)
}
