//
//  HomeControllerViewModel.swift
//  Rest_API_Video
//
//  Created by Admin on 30/05/24.
//

import Foundation
import UIKit
import SDWebImage
 
class AllPagesMovieViewModel {
    
    private let apiKey = "4e0be2c22f7268edffde97481d49064a"
        //private let apiKey = "d98f58a234c66316a67c83a121fcade7"
    private let baseURL = "https://api.themoviedb.org/3/movie/popular"
        // max pages is 32
    private let totalPages = 2
    private var movies: [Movie] = []
    private var filteredMovies: [Movie] = []
    var isSearching = false
    
    
    
    
    
    

        func fetchAllPages(completion: @escaping () -> Void) {
            
            
            let dispatchGroup = DispatchGroup()

            for page in 1...totalPages {
                dispatchGroup.enter()
                fetchMovies(page: page) { movies in
                    self.movies.append(contentsOf: movies)
                    dispatchGroup.leave()
                }
                
                // это метод отвечает для быстрой загрузкы в detailViewController posterImage
                for movie in movies {
                    if let posterURL = movie.fullPosterURL {
                        SDWebImagePrefetcher.shared.prefetchURLs([posterURL])
                    }
                }
            }

            dispatchGroup.notify(queue: .main) {
                completion()
            }
            

        }

        private func fetchMovies(page: Int, completion: @escaping ([Movie]) -> Void) {
            guard let url = URL(string: "\(baseURL)?api_key=\(apiKey)&language=en-US&page=\(page)") else {
                completion([])
                return
            }

            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    completion([])
                    return
                }

                do {
                    let response = try JSONDecoder().decode(MoviesData.self, from: data)
                    completion(response.movies)
                } catch {
                    completion([])
                }
            }.resume()
        }

        func getMovies() -> [Movie] {
            return isSearching ? filteredMovies : movies
        }

        func filterMovies(for query: String) {
            filteredMovies = movies.filter { $0.title!.lowercased().contains(query.lowercased()) }
        }

        func clearSearch() {
            isSearching = false
            filteredMovies.removeAll()
        }
    }


