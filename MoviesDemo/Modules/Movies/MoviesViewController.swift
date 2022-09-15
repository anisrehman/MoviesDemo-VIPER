//
//  MoviesViewController.swift
//  MoviesDemo
//
//  Created Anis Rehman on 11/02/2020.
//  Copyright © 2020 Anis ur Rehman. All rights reserved.
//
//

import UIKit

class MoviesViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var progressView: UIView!
    var movies: [Movie]? = nil
	var presenter: MoviesPresenterProtocol?
	override func viewDidLoad() {
        super.viewDidLoad()
        MoviesRouter.createModule(viewController: self)
        self.fetchMovies(category: self.selectedCategory)
    }
}

// MARK: - Actions
extension MoviesViewController {
    @IBAction func categoryAction(_ sender: UISegmentedControl) {
        self.fetchMovies(category: self.selectedCategory)
    }
}
// MARK: - Private Methods
extension MoviesViewController {
    private func fetchMovies(category: Category) {
        self.resetView()
        self.showProgress()
        presenter?.loadMovies(category)
    }
    
    private func showProgress() {
        self.view.isUserInteractionEnabled = false
        self.progressView.isHidden = false
    }
    
    private func hideProgress() {
        self.view.isUserInteractionEnabled = true
        self.progressView.isHidden = true
    }
    
    private func resetView() {
        self.searchBar.text = ""
        self.searchBar.resignFirstResponder()
        self.movies = []
        self.tableView.reloadData();
    }
    
    private var selectedCategory: Category {
        get {
            return Category(rawValue: segmentedControl.selectedSegmentIndex) ?? .popular
        }
    }
}
// MARK: - TableView DataSource
extension MoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let movies = self.movies {
            return movies.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.movieTableViewCell.rawValue) as! MovieTableViewCell
        cell.displayContents(of: self.movies![indexPath.row])
        return cell
    }
}
// MARK: - TableView Delegate
extension MoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter?.showMovieDetails(movie: self.movies![indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - SearchBar Delegate
extension MoviesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            presenter?.clearSearch(category: self.selectedCategory)
        } else {
            presenter?.searchMovies(text: searchText, category: self.selectedCategory)
        }
    }
}

// MARK: - MoviesViewProtocol
extension MoviesViewController: MoviesViewProtocol {
    func displayMovies(_ movies: [Movie]) {
        self.hideProgress()
        self.movies = movies
        self.tableView.reloadData()
    }

    func showError(_ error: Error) {
        self.hideProgress()
        let alertViewController = UIAlertController(title: "", message: error.localizedDescription, preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertViewController, animated: true, completion: nil)
    }
}
