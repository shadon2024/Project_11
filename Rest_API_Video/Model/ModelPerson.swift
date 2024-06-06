//
//  ModelPerson.swift
//  Rest_API_Video
//
//  Created by Admin on 02/06/24.
//


import Foundation

// MARK: - PopularPersonResponse
struct PopularPersonResponse: Codable {
    let page: Int
    let results: [Result]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}


// MARK: - Result
struct Result: Codable {
    let adult: Bool
    let gender, id: Int
    let knownForDepartment: KnownForDepartment
    let name, originalName: String
    let popularity: Double
    let profilePath: String?
    
    var profileImageUrl: URL? {
//        if let path = profilePath {
//
//            return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
//        }
//        return nil
        guard let profilePath = profilePath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(profilePath)")
    }
    
    let knownFor: [KnownFor]

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case knownFor = "known_for"
    }
}

// MARK: - KnownFor
struct KnownFor: Codable {
    let backdropPath: String?
    let id: Int
    let originalName: String?
    let overview, posterPath: String
    let mediaType: MediaType
    let adult: Bool
    let name: String?
    let originalLanguage: OriginalLanguage
    let genreIDS: [Int]
    let popularity: Double
    let firstAirDate: String?
    let voteAverage: Double
    let voteCount: Int
    let originCountry: [String]?
    let originalTitle, title, releaseDate: String?
    let video: Bool?

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id
        case originalName = "original_name"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case adult, name
        case originalLanguage = "original_language"
        case genreIDS = "genre_ids"
        case popularity
        case firstAirDate = "first_air_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case originCountry = "origin_country"
        case originalTitle = "original_title"
        case title
        case releaseDate = "release_date"
        case video
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
    case tv = "tv"
}

enum OriginalLanguage: String, Codable {
    case en = "en"
    case es = "es"
    case fr = "fr"
    case it = "it"
    case ja = "ja"
    case ko = "ko"
    case zh = "zh"
    case other
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let language = try container.decode(String.self)
        self = OriginalLanguage(rawValue: language) ?? .other
    }
}

enum KnownForDepartment: String, Codable {
    case acting = "Acting"
    case directing = "Directing"
    case production = "Production"
    case other

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let department = try container.decode(String.self)
        self = KnownForDepartment(rawValue: department) ?? .other
    }
}


