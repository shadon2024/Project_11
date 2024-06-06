//
//  Model.swift
//  Rest_API_Video
//
//  Created by Admin on 28/05/24.
//

import Foundation

struct MoviesData: Decodable {
    let movies: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}

struct Movie: Decodable {
    
    let title: String?
    let year: String?
    let rate: Double?
    let posterImage: String?
    let overview: String?
    let id: Int?
    let original_language: String?
    var adult: Bool = false // значение по умолчанию
//    let original_language: String?
    //let popularity: Int?
//    let video: Bool?
    let vote_count: Int?
    
    var fullPosterURL: URL? {
        guard let posterImage = posterImage else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterImage)")
        //return URL(string: "https://image.tmdb.org/t/p/w500" + (posterImage ?? ""))
    }
    
    init(title: String?, year: String?, rate: Double?, posterImage: String?, overview: String?, id: Int, adult: Bool, original_language: String?, vote_count: Int?
         //, video: Bool?, popularity: Int?
                                                                                        ) {
        self.title = title
        self.year = year
        self.rate = rate
        self.posterImage = posterImage
        self.overview = overview
        self.id = id
        self.adult = adult
        self.original_language = original_language
        //self.popularity = popularity
//        self.video = video
        self.vote_count = vote_count
    }
    
    private enum CodingKeys: String, CodingKey {
        case title, overview
        case year = "release_date"
        case rate = "vote_average"
        case posterImage = "poster_path"
        case id = "id"
        case adult = "adult"
        case original_language = "original_language"
        //case popularity = "popularity"
//        case video = "video"
        case vote_count = "vote_count"
    }
}
