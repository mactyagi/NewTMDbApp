//
//  MovieViewModel.swift
//  NewTMDbApp
//
//  Created by manukant tyagi on 29/10/24.
//

import Foundation

class MoviesViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    
    func fetchPopularMovies() {
        NetworkManager.shared.fetchPopularMovies { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self.movies = movies
                case .failure(let error):
                    print("Error fetching movies: \(error)")
                }
            }
        }
    }
}
