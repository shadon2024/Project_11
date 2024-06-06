//
//  MovieViewModel.swift
//  Rest_API_Video
//
//  Created by Admin on 28/05/24.
//


import Foundation
import UIKit
import SDWebImage
 
class SecondMovieViewModel {
    
    private let apiKey = "4e0be2c22f7268edffde97481d49064a"
        //private let apiKey = "d98f58a234c66316a67c83a121fcade7"
    private let baseURL = "https://api.themoviedb.org/3/movie/popular"
        // max pages is 32
    private let totalPages = 2
    
    private var movies: [Result] = []
    private var filteredMovies: [Result] = []
    var isSearching = false
    
    
    
    
        func getMovies() -> [Result] {
            return isSearching ? filteredMovies : movies
        }

        func filterMovies(for query: String) {
            filteredMovies = movies.filter { $0.name.lowercased().contains(query.lowercased()) }
        }

        func clearSearch() {
            isSearching = false
            filteredMovies.removeAll()
        }
    }




























//import Foundation

//class MovieViewModel {
    
    //private var apiService = ApiService()
    //private var popularMovies = [Movie]()
    
    
    
//    func fetchPopularMoviesData(comletion: @escaping () -> ()) {
//        // weak self - prevent retain cucles
//        apiService.getPopularMoviesData { [weak self] (result) in
//
//            switch result {
//            case .success(let success):
//                self?.popularMovies = success.movies
//                comletion()
//            case .failure(let failure):
//                // something is wrong with the JSON file or model
//                print("Error prosseing json data: \(failure)")
//            }
//        }
//    }
    
    
    
//    // settings func SearchBar
//    private var allMovies: [Movie] = []
//    private var filterdMovies: [Movie] = []
//    var isFiltering: Bool = false
//
//
//
//    func numberOfSection(section: Int) -> Int {
//        if popularMovies.count != 0 {
//            return isFiltering ? filterdMovies.count : popularMovies.count
//        }
//        return 0
//    }
//
//    func cellForRowAt (indexPath: IndexPath) -> Movie {
//        return isFiltering ? filterdMovies[indexPath.section] : popularMovies[indexPath.section]
//    }
//
//    func filterMovies(for searchText: String) {
//        filterdMovies = popularMovies.filter { $0.title!.lowercased().contains(searchText.lowercased())}
//    }
//
//}
