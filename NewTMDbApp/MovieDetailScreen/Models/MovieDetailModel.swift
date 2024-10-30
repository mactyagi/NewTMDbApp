//
//  MovieDetailModel.swift
//  NewTMDbApp
//
//  Created by manukant tyagi on 29/10/24.
//

import Foundation
// MARK: - MovieDetail
struct MovieDetail: Codable {
    let runtime: Int
    let status, backdropPath, overview, title: String?
    let voteCount: Int
    let tagline: String?
    let originalTitle, originalLanguage, posterPath: String?
    let originCountry: [String]
    let productionCountries: [ProductionCountry]
    let homepage: String?
    let revenue: Int?
    let imdbID: String?
    let video: Bool
    let id: Int
    let releaseDate: String?
    let budget: Int?
    let popularity: Double?
    let genres: [Genre]
    let productionCompanies: [ProductionCompany]
    let adult: Bool
    let spokenLanguages: [SpokenLanguage]
    let voteAverage: Double?

    enum CodingKeys: String, CodingKey {
        case runtime, status
        case backdropPath = "backdrop_path"
        case overview, title
        case voteCount = "vote_count"
        case tagline
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case posterPath = "poster_path"
        case originCountry = "origin_country"
        case productionCountries = "production_countries"
        case homepage, revenue
        case imdbID = "imdb_id"
        case video, id
        case releaseDate = "release_date"
        case budget, popularity, genres
        case productionCompanies = "production_companies"
        case adult
        case spokenLanguages = "spoken_languages"
        case voteAverage = "vote_average"
    }
}


// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}

// MARK: - ProductionCompany
struct ProductionCompany: Codable {
    let logoPath: String?
    let id: Int
    let originCountry, name: String

    enum CodingKeys: String, CodingKey {
        case logoPath = "logo_path"
        case id
        case originCountry = "origin_country"
        case name
    }
}

// MARK: - ProductionCountry
struct ProductionCountry: Codable {
    let name, iso3166_1: String

    enum CodingKeys: String, CodingKey {
        case name
        case iso3166_1 = "iso_3166_1"
    }
}

// MARK: - SpokenLanguage
struct SpokenLanguage: Codable {
    let englishName, name, iso639_1: String

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case name
        case iso639_1 = "iso_639_1"
    }
}


extension MovieDetail {
    var backdropURL: URL? {
        URL(string: NetworkManager.imageBaseUrl + (backdropPath ?? ""))
    }
    
    var posterURL: URL? {
        URL(string: NetworkManager.imageBaseUrl + (posterPath ?? ""))
    }
}

extension ProductionCompany {
    var logoURL: URL? {
        guard let logoPath = logoPath else { return nil }
        return URL(string: NetworkManager.imageBaseUrl + logoPath)
    }
}

