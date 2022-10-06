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
    
    func fetchMovies(_ category: Category) {
        // Decide which API to be called based on category
        var apiRouter = APIRouter.popular(page: 1)
        switch category {
        case .popular:
            apiRouter = .popular(page: 1)
        case .topRated:
            apiRouter = .topRated(page: 1)
        case .upcoming:
            apiRouter = .upcoming(page: 1)
        }
        APIClient.sendRequest(router: apiRouter, type: MoviesResponse.self){ [weak self](response, error) in
            guard let weakSelf = self else { return }
            if let response = response {
                MovieAccess.resetMovies(response.results, category: category)
                weakSelf.presenter?.showMovies(response.results)
            } else if let error = error {
                // Load movies from db if exist otherwise send error to presenter
                let movies = weakSelf.moviesFromDB(category: category)
                if movies.count > 0 {
                    weakSelf.presenter?.showMovies(movies)
                } else {
                    weakSelf.presenter?.showError(error)
                }
            }
        }
    }
    
    func searchMovies(text: String, category: Category) {
        let movieEntities = MovieAccess.searchMovies(text: text, category: category)
        var movies: [Movie] = []
        movieEntities.forEach { (entity) in
            let movie = Movie(movieEntity: entity)
            movies.append(movie)
        }
        presenter?.showMovies(movies)
    }
    
    func clearSearch(category: Category) {
        let movieEntities = MovieAccess.allMovies(category: category)
        var movies: [Movie] = []
        movieEntities.forEach { (entity) in
            let movie = Movie(movieEntity: entity)
            movies.append(movie)
        }
        presenter?.showMovies(movies)
    }
    
    private func moviesFromDB(category: Category) -> [Movie] {
        let movieEntities = MovieAccess.allMovies(category: category)
        var movies: [Movie] = []
        movieEntities.forEach { (entity) in
            let movie = Movie(movieEntity: entity)
            movies.append(movie)
        }
        return movies
    }
}
