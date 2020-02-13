//
//  MovieTableViewCell.swift
//  MoviesDemo
//
//  Created by Anis Rehman on 12/02/2020.
//  Copyright © 2020 Anis ur Rehman. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        titleLabel.text = ""
        overviewLabel.text = ""
        posterImageView.image = UIImage(named: "poster")
    }
}

//MARK: - Public Methods
extension MovieTableViewCell {
    func displayContents(of movie: Movie) {
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
        let imageURLString = Constants.smallImageBaseURL + (movie.posterPath ?? "")
        posterImageView.setImage(from: imageURLString)
    }
}
