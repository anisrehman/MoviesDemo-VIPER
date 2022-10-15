//
//  MoviesInteractor.swift
//  MoviesDemo
//
//  Created Anis Rehman on 11/02/2020.
//  Copyright © 2020 Anis ur Rehman. All rights reserved.
//
//

import UIKit

class MoviesInteractor: MoviesInteractable {
    weak var presenter: MoviesOutputInteractable?
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
        let movies = movieEntities.map { entity in
            Movie(id: entity.id, popularity: entity.popularity, voteCount: entity.voteCount, video: entity.video, posterPath: entity.posterPath, adult: entity.adult, backdropPath: entity.backdropPath, originalLanguage: entity.originalLanguage ?? "", originalTitle: entity.originalTitle ?? "", title: entity.title ?? "", voteAverage: entity.voteAverage, overview: entity.overview ?? "", releaseDate: entity.releaseDate ?? "")
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
        let movies = movieEntities.map { entity in
            Movie(id: entity.id, popularity: entity.popularity, voteCount: entity.voteCount, video: entity.video, posterPath: entity.posterPath, adult: entity.adult, backdropPath: entity.backdropPath, originalLanguage: entity.originalLanguage ?? "", originalTitle: entity.originalTitle ?? "", title: entity.title ?? "", voteAverage: entity.voteAverage, overview: entity.overview ?? "", releaseDate: entity.releaseDate ?? "")
        }
        return movies
    }
}
