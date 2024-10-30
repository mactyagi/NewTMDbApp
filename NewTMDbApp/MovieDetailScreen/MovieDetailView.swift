//
//  MovieDetailView.swift
//  NewTMDbApp
//
//  Created by manukant tyagi on 29/10/24.
//

import SwiftUI
import AVFoundation
import AVKit

struct MovieDetailView: View {
    @StateObject var viewModel: MovieDetailViewModel
    
    init(viewModel: MovieDetailViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Trailer Link Button
                if let trailerURL = viewModel.trailerURL {
                    Link("Watch Trailer", destination: trailerURL)
                        .font(.headline)
                        .foregroundColor(.blue)
                        .padding()
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(8)
                }
                
                // Movie Backdrop
                if let backdropURL = viewModel.movieDetail?.backdropURL {
                    AsyncImage(url: backdropURL) { image in
                        image
                            .resizable()
                    } placeholder: {
                        Color.gray.opacity(0.3)
                    }
                    .frame(height: 250)
                    .cornerRadius(12)
                    .shadow(radius: 6)
                }

                // Title and Tagline
                Text(viewModel.movieDetail?.title ?? "")
                    .font(.largeTitle)
                    .bold()
                if let tagline = viewModel.movieDetail?.tagline, !tagline.isEmpty {
                    Text(tagline)
                        .font(.headline)
                        .foregroundColor(.gray)
                }

                // Rating and Runtime
                HStack {
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text(String(format: "%.1f", viewModel.movieDetail?.voteAverage ?? 0))
                            .font(.subheadline)
                            .bold()
                        Text("(\(viewModel.movieDetail?.voteCount ?? 0) votes)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    Text("\(viewModel.movieDetail?.runtime ?? 0) mins")
                    Spacer()
                    Text(viewModel.movieDetail?.releaseDate ?? "")
                }
                .font(.subheadline)
                .foregroundColor(.secondary)

                // Genres
                if let genres = viewModel.movieDetail?.genres {
                    Text(genres.map { $0.name }.joined(separator: ", "))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                // Overview
                if let overview = viewModel.movieDetail?.overview {
                    Text("Overview")
                        .font(.title2)
                        .bold()
                        .padding(.top)
                    Text(overview)
                        .font(.body)
                        .foregroundColor(.primary)
                }
                
                // Cast
                if !viewModel.casts.isEmpty {
                    Text("Cast")
                        .font(.title2)
                        .bold()
                        .padding(.top)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            
                            ForEach(viewModel.casts) { castMember in
                                VStack {
                                    if let profileURL = castMember.profileURL {
                                        AsyncImage(url: profileURL) { image in
                                            image
                                                .resizable()
                                                .scaledToFill()
                                        } placeholder: {
                                            Color.gray.opacity(0.3)
                                        }
                                        .frame(width: 80, height: 80)
                                        .clipShape(Circle())
                                        .shadow(radius: 3)
                                    }
                                    Text(castMember.name)
                                        .font(.caption)
                                        .bold()
                                        .lineLimit(1)
                                    Text(castMember.character ?? "")
                                        .font(.caption2)
                                        .foregroundColor(.secondary)
                                }
                                .frame(width: 100)
                            }
                        }
                    }
                }

                // Production Companies
                if let companies = viewModel.movieDetail?.productionCompanies {
                    Text("Production Companies")
                        .font(.title2)
                        .bold()
                        .padding(.top)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(companies, id: \.id) { company in
                                VStack {
                                    if let logoURL = company.logoURL {
                                        AsyncImage(url: logoURL) { image in
                                            image
                                                .resizable()
                                                .scaledToFit()
                                        } placeholder: {
                                            Color.gray.opacity(0.3)
                                        }
                                        .frame(width: 80, height: 40)
                                        .cornerRadius(8)
                                        .shadow(radius: 3)
                                    }
                                    Text(company.name)
                                        .font(.caption)
                                }
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Movie Detail View")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.fetchMovieDetails()
            viewModel.fetchTrailer()
            viewModel.fetchCast()
        }
    }
}


#Preview {
    MovieDetailView(viewModel: MovieDetailViewModel(movieId: 912649))
}
