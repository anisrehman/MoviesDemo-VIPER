//
//  MoviesPresenter.swift
//  MoviesDemo
//
//  Created Anis Rehman on 11/02/2020.
//  Copyright © 2020 Anis ur Rehman. All rights reserved.
//
//

import UIKit

class MoviesPresenter: MoviesPresenterProtocol {
    
    weak private var view: MoviesViewProtocol?
    var interactor: MoviesInteractorInputProtocol?
    private let router: MoviesWireframeProtocol
    init(interface: MoviesViewProtocol, interactor: MoviesInteractorInputProtocol?, router: MoviesWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    //load movies under a category
    func loadMovies(_ category: Category) {
        interactor?.loadMovies(category)
    }
    
    //Search movies for a string under a category
    func searchMovies(text: String, category: Category) {
        interactor?.searchMovies(text: text, category: category)
    }
    
    //Remove search filter for a category
    func clearSearch(category: Category) {
        interactor?.clearSearch(category: category)
    }
    
    //Show movie details screen
    func showMovieDetails(movie: Movie) {
        router.routeToMovieDetails(movie: movie, title: "Movie Details")
    }
}

//Interactor responses are handled here
extension MoviesPresenter: MoviesInteractorOutputProtocol {
    func showMovies(_ movies: [Movie]) {
        DispatchQueue.main.async {[weak self] in
            self?.view?.moviesLoaded(movies)
        }
    }
    
    func showError(_ error: Error) {
        DispatchQueue.main.async {[weak self] in
            self?.view?.moviesLoadFailed(error)
        }
    }
}
