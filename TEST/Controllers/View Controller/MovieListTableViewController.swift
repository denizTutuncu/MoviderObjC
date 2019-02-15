//
//  MovieListTableViewController.swift
//  TEST
//
//  Created by Deniz Tutuncu on 2/15/19.
//  Copyright © 2019 Deniz Tutuncu. All rights reserved.
//

import UIKit

class MovieListTableViewController: UITableViewController {
    
    var movies: [DSTMovie] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var serchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        serchBar.delegate = self
        DSTModelController.shared().searchForPost(withSearchTerm: "Kill Bill") { (movies, error) in
            self.movies = movies
        }
        
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        
        let movie = movies[indexPath.row]
        cell.movies = movie
        
        DSTModelController.shared().fetchImage(for: movie) { (image) in
            DispatchQueue.main.async {
                cell.movieImage = image
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension MovieListTableViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {return}
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        DSTModelController.shared().searchForPost(withSearchTerm: searchText) { (movies, error) in
            self.movies = movies
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                self.title = searchText
            }
        }
        searchBar.text = ""
    }
}
