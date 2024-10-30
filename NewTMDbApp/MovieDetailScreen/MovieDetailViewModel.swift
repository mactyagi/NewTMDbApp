//
//  MovieDetailViewModel.swift
//  NewTMDbApp
//
//  Created by manukant tyagi on 29/10/24.
//

import Foundation
import AVKit

class MovieDetailViewModel: ObservableObject {
    @Published var movieDetail: MovieDetail?
    @Published var trailerURL: URL?
    @Published var teasorURL: URL?
    @Published var casts: [Cast] = []
    var movieId: Int
    
    init(movieId: Int) {
        self.movieId = movieId
    }
    
    func fetchMovieDetails() {
        NetworkManager.shared.fetchMovieDetails(movieId: movieId) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movieDetail):
                    self.movieDetail = movieDetail
                case .failure(let error):
                    print("Error fetching movie details: \(error)")
                }
            }
        }
    }
    
    func fetchTrailer() {
        NetworkManager.shared.fetchTrailer(movieId: movieId) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let trailerURL):
                    self.trailerURL = trailerURL
                case .failure(let error):
                    print("Error fetching trailer: \(error)")
                }
            }
        }
    }
    
    func fetchCast() {
        NetworkManager.shared.fetchMovieCredits(movieId: movieId) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let casts):
                        self.casts = casts
                    case .failure(let error):
                        print("Error fetching cast: \(error)")
                    }
                }
            }
        }
}
