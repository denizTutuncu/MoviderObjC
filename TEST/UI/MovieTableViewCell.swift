//
//  MovieTableViewCell.swift
//  TEST
//
//  Created by Deniz Tutuncu on 2/15/19.
//  Copyright © 2019 Deniz Tutuncu. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    
    
    
    var movies: DSTMovie?{
        didSet{
            updateViews()
        }
    }
    
    var movieImage: UIImage? {
        didSet{
            updateViews()
        }
    }
    
    func updateViews() {
        guard let movies = movies else {return}
        titleLable.text = movies.title
        ratingLabel.text = movies.overview
        overviewLabel.text = " Rating: \(movies.rating) / 100"
        movieImageView.image = movieImage
    }
}

    
    

