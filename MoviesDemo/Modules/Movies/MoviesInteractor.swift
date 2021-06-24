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
    
    func loadMovies(_ category: Category) {
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
        APIClient.sendRequest(router: apiRouter){ [weak self](data, error) in
            guard let weakSelf = self else { return }
            if let error = error {
                // Load movies from db if exist otherwise send error to presenter
                let movies = weakSelf.moviesFromDB(category: category)
                if movies.count > 0 {
                    weakSelf.presenter?.showMovies(movies)
                } else {
                    weakSelf.presenter?.showError(error)
                }
            } else {
                guard let data = data else {
                    let movies = weakSelf.moviesFromDB(category: category)
                    if movies.count > 0 {
                        weakSelf.presenter?.showMovies(movies)
                    } else {
                        let error = APIError.customError(message: "No data from server")
                        weakSelf.presenter?.showError(error)

                    }
                    return
                }
                do {
                    let response = try JSONDecoder().decode(MoviesResponse.self, from: data) as MoviesResponse
                    MovieAccess.resetMovies(response.results, category: category)
                    weakSelf.presenter?.showMovies(response.results)
                } catch  {
                    print(error)
                    let movies = weakSelf.moviesFromDB(category: category)
                    if movies.count > 0 {
                        weakSelf.presenter?.showMovies(movies)
                    } else {
                        let error = APIError.customError(message: "Invalid response from server")
                        weakSelf.presenter?.showError(error)
                    }
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
