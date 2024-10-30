//
//  MoviesListView.swift
//  NewTMDbApp
//
//  Created by manukant tyagi on 29/10/24.
//




import SwiftUI

struct MoviesListView: View {
    @StateObject private var viewModel = MoviesViewModel()
    
    let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(viewModel.movies) { movie in
                        let movieDetailViewModel = MovieDetailViewModel(movieId: movie.id)
                        NavigationLink(destination: MovieDetailView(viewModel: movieDetailViewModel)) {
                            MovieGridItemView(movie: movie)
                                .frame(height: 280)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Popular Movies")
            .onAppear {
                viewModel.fetchPopularMovies()
            }
        }
    }
}

struct MovieGridItemView: View {
    let movie: Movie
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Movie Poster
            AsyncImage(url: movie.posterURL) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(height: 180)
            .cornerRadius(12)
            .shadow(radius: 6)

            // Movie Title and Info
            Text(movie.title ?? "No Title Found")
                .font(.headline)
                .foregroundColor(.primary)
                .lineLimit(0)
//                .padding(.horizontal, 4)

            
            VStack {
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text(String(format: "%.1f", movie.voteAverage ?? 0))
                        .font(.subheadline)
                        .bold()
                    Text("(\(movie.voteCount ?? 0) votes)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Text("Released: \(movie.releaseDate ?? "Not released yet")")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 4)
    }
}


#Preview {
    MoviesListView()
}
