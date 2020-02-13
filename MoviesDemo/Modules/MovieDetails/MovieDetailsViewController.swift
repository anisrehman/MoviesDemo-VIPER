//
//  MovieDetailsViewController.swift
//  MoviesDemo
//
//  Created Anis Rehman on 13/02/2020.
//  Copyright © 2020 Anis ur Rehman. All rights reserved.
//
//

import UIKit

class MovieDetailsViewController: UIViewController  {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
	var presenter: MovieDetailsPresenterProtocol?

	override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.showMovieDetails()
    }
}

extension MovieDetailsViewController: MovieDetailsViewProtocol {
    func movieToShowDetails(movie: Movie) {
        self.titleLabel.text = "\(movie.title) (\(movie.releaseDate)) "
        self.overviewLabel.text = movie.overview
        ratingLabel.text = "Rating: \(movie.voteAverage)"
        let imageURLString = Constants.mediumImageBaseURL + (movie.posterPath ?? "")
        self.posterImageView.setImage(from: imageURLString)
    }
}
