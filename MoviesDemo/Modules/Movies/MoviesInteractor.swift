//
//  MoviesInteractor.swift
//  MoviesDemo
//
//  Created Anis Rehman on 11/02/2020.
//  Copyright © 2020 Anis ur Rehman. All rights reserved.
//
//

import UIKit

class MoviesInteractor: MoviesInteractorInputProtocol {
    weak var presenter: MoviesInteractorOutputProtocol?
    var moviesService = MoviesService()

    init() {
        DependencyContainer.shared.register(type: MovieStoring.self, value: MovieRepository(), overwrite: false)
    }

    func fetchMovies(_ category: Category) {
        moviesService.fetchMovies(category) { [weak self] movies, error in
            guard let weakSelf = self else { return }
            let movieRepository = DependencyContainer.shared.get(MovieStoring.self)
            if let movies {
                movieRepository?.resetMovies(movies, category: category)
                weakSelf.presenter?.showMovies(movies)
            } else if error != nil {
                let movies = weakSelf.moviesFromDB(category: category)
                weakSelf.presenter?.showMovies(movies)
            }
        }
    }
    
    func searchMovies(text: String, category: Category) {
        let movieRepository = DependencyContainer.shared.get(MovieStoring.self)
        let movieEntities = movieRepository?.searchMovies(text: text, category: category) ?? []
        var movies: [Movie] = []
        movieEntities.forEach { (entity) in
            let movie = Movie(movieEntity: entity)
            movies.append(movie)
        }
        presenter?.showMovies(movies)
    }
    
    func clearSearch(category: Category) {
        let movies = moviesFromDB(category: category)
        presenter?.showMovies(movies)
    }
    
    private func moviesFromDB(category: Category) -> [Movie] {
        let movieRepository = DependencyContainer.shared.get(MovieStoring.self)
        let movieEntities = movieRepository?.allMovies(category: category) ?? []
        var movies: [Movie] = []
        movieEntities.forEach { (entity) in
            let movie = Movie(movieEntity: entity)
            movies.append(movie)
        }
        return movies
    }
}
