//
//  ApiService.swift
//  Rest_API_Video
//
//  Created by Admin on 28/05/24.
//

//import Foundation
//
//class ApiService {
//    
//    private var dataTask: URLSessionDataTask?
//    
//    func getPopularMoviesData(completion: @escaping (Result<MoviesData, Error>) -> Void) {
//        let popularMoviesURL = //"https://api.themoviedb.org/3/movie/popular?api_key=d98f58a234c66316a67c83a121fcade7&language=en-US&page=1"
//            //"https://api.themoviedb.org/3/movie/now_playing?api_key=4e0be2c22f7268edffde97481d49064a&language=en-US&page=1"
//        "https://api.themoviedb.org/3/movie/popular?api_key=4e0be2c22f7268edffde97481d49064a&language=en-US&page=1"
//            //"https://api.themoviedb.org/3/trending/person/day?api_key=4e0be2c22f7268edffde97481d49064a&language=en-US&page=1"
//        
//        guard let url = URL(string: popularMoviesURL) else { return }
//        
//        // create URL Session - work on the background
//        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            // handle error
//            if let error = error {
//                completion(.failure(error))
//                print("DataTask Error: \(error.localizedDescription)")
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse else {
//                // handle empty response
//                print("Empty response")
//                return
//            }
//            print("Response status code: \(response.statusCode)")
//            
//            guard let data = data else {
//                // handle empty data
//                print("Empty data")
//                return
//            }
//            
//            do {
//                // parse the data
//                let decoder = JSONDecoder()
//                let jsonData = try decoder.decode(MoviesData.self, from: data)
//                
//                // back to the main thread
//                DispatchQueue.main.async {
//                    completion(.success(jsonData))
//                }
//            } catch let error {
//                completion(.failure(error))
//            }
//            
//            
//        }
//        dataTask?.resume()
//    }
//    
//    
//    
//}
