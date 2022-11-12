//
//  MoviesProtocols.swift
//  MoviesDemo
//
//  Created Anis Rehman on 11/02/2020.
//  Copyright © 2020 Anis ur Rehman. All rights reserved.
//
//

import Foundation
import UIKit

//MARK: Wireframe -
protocol MoviesRoutable: AnyObject {
    var navigationController: UINavigationController? { get set }
    func routeToMovieDetails(movie: Movie)
}
//MARK: Presenter -
protocol MoviesPresentable: AnyObject {

    var interactor: MoviesInteractable? { get set }
    
    func fetchMovies(_ category: Category)
    func searchMovies(text: String, category: Category)
    func clearSearch(category: Category)
    func showMovieDetails(movie: Movie)
}

protocol MoviesInteractable: AnyObject {

//    var presenter: MoviesOutputInteractable?  { get set }
    var moviesService: MoviesService { get set }
    /* Presenter -> Interactor */
    func fetchMovies(_ category: Category, completion: @escaping ([Movie]?, Error?) -> Void)
    func searchMovies(text: String, category: Category, completion: ([Movie]) -> Void)
    func clearSearch(category: Category, completion: ([Movie]) -> Void)
}

//MARK: View -
protocol MoviesViewable: AnyObject {

    var presenter: MoviesPresentable?  { get set }

    /* Presenter -> ViewController */
    func showProgress();
    func hideProgress();
    func clearMoviesList();

    func displayMovies(_ movies: [Movie])
    func showError(_ error: Error)
}
