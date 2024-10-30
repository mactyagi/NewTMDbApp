//
//  NetworkManager.swift
//  NewTMDbApp
//
//  Created by manukant tyagi on 29/10/24.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    static let imageBaseUrl = "https://image.tmdb.org/t/p/w500"
    
    private let apiKey = "09bbbcd5e38e6978a7c08bf1b838ea0a" /*"YOUR API KEY"*/
    private let baseURL = "https://api.themoviedb.org/3/"
    
    
    private init() {}
    
    func fetchPopularMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: baseURL + "movie/popular?api_key=\(apiKey)") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(MovieListResponse.self, from: data)
                    completion(.success(decodedResponse.results))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func fetchMovieDetails(movieId: Int, completion: @escaping (Result<MovieDetail, Error>) -> Void) {
        guard let url = URL(string: baseURL + "movie/\(movieId)?api_key=\(apiKey)") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                data.printJson()
                do {
                    let decodedResponse = try JSONDecoder().decode(MovieDetail.self, from: data)
                    completion(.success(decodedResponse))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func fetchTrailer(movieId: Int, completion: @escaping (Result<URL?, Error>) -> Void) {
        guard let url = URL(string: baseURL + "movie/\(movieId)/videos?api_key=\(apiKey)") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                data.printJson()
                do {
                    let decodedResponse = try JSONDecoder().decode(MovieTrailorResponse.self, from: data)
                    
                    let officialMovieTrailers = decodedResponse.results.filter({$0.official == true})
                    if let trailer = officialMovieTrailers.first(where: { $0.type == "Trailer" }) {
                        let trailerURL = URL(string: "https://www.youtube.com/watch?v=\(trailer.key)")
                        completion(.success(trailerURL))
                    }else {
                        completion(.success(nil))
                    }
                    
                } catch {
                    print(error)
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func fetchMovieCredits(movieId: Int, completion: @escaping (Result<[Cast], Error>) -> Void) {
        guard let url = URL(string: baseURL + "movie/\(movieId)/credits?api_key=\(apiKey)") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(MovieCreditModel.self, from: data)
                    completion(.success(decodedResponse.cast))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
}



extension Data {
    func printJson() {
        if let json = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers),
           let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            print(String(decoding: jsonData, as: UTF8.self))
        } else {
            print("json data malformed")
        }
        

        
    }
}
