//
//  MovieTrailorModel.swift
//  NewTMDbApp
//
//  Created by manukant tyagi on 30/10/24.
//

import Foundation

// MARK: - MovieTrailorResponse
struct MovieTrailorResponse: Codable {
    let id: Int
    let results: [MovieTrailor]
}

// MARK: - Result
struct MovieTrailor: Codable {
    let name, key: String
    let site: String?
    let size: Int?
    let type: String?
    let official: Bool
    let publishedAt: String?
    let id: String

    enum CodingKeys: String, CodingKey {
        case name, key, site, size, type, official
        case publishedAt = "published_at"
        case id
    }
}
