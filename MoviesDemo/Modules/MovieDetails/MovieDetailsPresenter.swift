//
//  MovieDetailsPresenter.swift
//  MoviesDemo
//
//  Created Anis Rehman on 13/02/2020.
//  Copyright © 2020 Anis ur Rehman. All rights reserved.
//
//

import UIKit

class MovieDetailsPresenter: MovieDetailsPresenterProtocol, MovieDetailsInteractorOutputProtocol {

    weak private var view: MovieDetailsViewProtocol?
    var interactor: MovieDetailsInteractorInputProtocol?
    private let router: MovieDetailsWireframeProtocol
    var movie: Movie

    init(interface: MovieDetailsViewProtocol, interactor: MovieDetailsInteractorInputProtocol?, router: MovieDetailsWireframeProtocol, movie: Movie) {
        self.view = interface
        self.interactor = interactor
        self.router = router
        self.movie = movie
    }

    func showMovieDetails() {
        DispatchQueue.main.async { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.view?.movieToShowDetails(movie: weakSelf.movie)
        }
    }
}
