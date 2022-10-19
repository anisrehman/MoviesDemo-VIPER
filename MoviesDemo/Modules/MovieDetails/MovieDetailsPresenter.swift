//
//  MovieDetailsPresenter.swift
//  MoviesDemo
//
//  Created Anis Rehman on 13/02/2020.
//  Copyright © 2020 Anis ur Rehman. All rights reserved.
//
//

import UIKit

class MovieDetailsPresenter: MovieDetailsPresentable, MovieDetailsInteractorOutputProtocol {

    weak private var view: MovieDetailsViewable?
    var interactor: MovieDetailsInteractable?
    private let router: MovieDetailsRoutable
    var movie: Movie

    init(interface: MovieDetailsViewable, interactor: MovieDetailsInteractable?, router: MovieDetailsRoutable, movie: Movie) {
        self.view = interface
        self.interactor = interactor
        self.router = router
        self.movie = movie
    }

    func showMovieDetails() {
        DispatchQueue.main.async { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.view?.showMovieDetails(movie: weakSelf.movie)
        }
    }
}
