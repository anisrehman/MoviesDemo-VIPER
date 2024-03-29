//
//  MoviesPresenter.swift
//  MoviesDemo
//
//  Created Anis Rehman on 11/02/2020.
//  Copyright © 2020 Anis ur Rehman. All rights reserved.
//
//

import UIKit

class MoviesPresenter: MoviesPresentable {
    weak private var view: MoviesViewable?
    var interactor: MoviesInteractable?
    private let router: MoviesRoutable
    init(interface: MoviesViewable, interactor: MoviesInteractable?, router: MoviesRoutable) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    //load movies under a category
    func fetchMovies(_ category: Category) {
        view?.clearMoviesList()
        view?.showProgress()
        interactor?.fetchMovies(category) { [weak self] (movies, error) in
            if let error {
                DispatchQueue.main.async {[weak self] in
                    self?.view?.showError(error)
                }
                return
            }

            let movies = movies ?? []
            DispatchQueue.main.async {[weak self] in
                self?.view?.displayMovies(movies)
            }
        }
    }
    
    //Search movies for a string under a category
    func searchMovies(text: String, category: Category) {
        interactor?.searchMovies(text: text, category: category) { [weak self] movies in
            self?.view?.displayMovies(movies)
        }
    }
    
    //Remove search filter for a category
    func clearSearch(category: Category) {
        interactor?.clearSearch(category: category) { [weak self] movies in
            self?.view?.displayMovies(movies)
        }
    }
    
    //Show movie details screen
    func showMovieDetails(movie: Movie) {
        router.routeToMovieDetails(movie: movie)
    }
}
