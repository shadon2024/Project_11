//
//  MovieTableViewCell.swift
//  Rest_API_Video
//
//  Created by Admin on 28/05/24.
//

import UIKit
import SnapKit
import SDWebImage

class MovieTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    private var adult: Bool?
    
//    init(adult: Bool) {
//        self.adult = adult
//        super.init(nibName: nil, bundle: nil)
//    }


    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var reuseIdentifier: String? {
        return "cell"
    }
    

    
    lazy var moviePoster: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    
    lazy var movieTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 19, weight: .bold)
        return label
    }()
    
    
    lazy var movieYear: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19, weight: .semibold)
        return label
    }()
    
    lazy var movieOverview: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        return label
    }()
    
    lazy var movieRate: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    

    
    lazy var views: UIStackView = {
        let view = UIStackView()
        view.backgroundColor = .cyan
        return view
    }()
    
    
    lazy var movieRateIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "ratedStar")
        return image
    }()
    
    lazy var ratingStackView: UIStackView = {
        let rating = UIStackView()
        return rating
    }()
    
    private var urlString: String = ""
    
    
    

    
    private func setupViews() {
        
        views.axis = .vertical
        
        contentView.addSubview(views)
        views.translatesAutoresizingMaskIntoConstraints = false

        
        views.addSubview(moviePoster)
        moviePoster.translatesAutoresizingMaskIntoConstraints = false
        
        views.addSubview(movieTitle)
        movieTitle.translatesAutoresizingMaskIntoConstraints = false
        
        views.addSubview(movieYear)
        movieYear.translatesAutoresizingMaskIntoConstraints = false
        
        views.addSubview(movieRate)
        movieRate.translatesAutoresizingMaskIntoConstraints = false
        
        
        views.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(200)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
        }
        
        
        moviePoster.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(10)
            make.height.equalTo(130)
            make.width.equalTo(100)
        }
        
        movieTitle.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(moviePoster.snp.trailing).offset(10)
            make.width.equalTo(200)
        }
        
        movieYear.snp.makeConstraints { make in
            make.top.equalTo(movieTitle.snp.bottom).offset(20)
            make.leading.equalTo(moviePoster.snp.trailing).offset(10)
        }
        
        movieRate.snp.makeConstraints { make in
            make.top.equalTo(movieYear.snp.bottom).offset(16)
            make.leading.equalTo(moviePoster.snp.trailing).offset(10)
        }
    }
    
    
    private(set) var coin: Movie!
    
    
    
    // MARK: - setup movies values
    func setCellWithValuesOf(_ movie: Movie) {
        self.coin = movie
        
        if let url = movie.fullPosterURL {
            loadImage(from: url)
        }
        
        updateUI(title: movie.title, releaseDate: movie.year, rating: movie.rate, overview: movie.overview, poster: movie.fullPosterURL?.absoluteString, id: movie.id, adult: movie.adult )
        
        // movie.fullPosterURL?.absoluteString
        // movie.posterImage
        

    }
    
    //let url = "https://image.tmdb.org/t/p/w300"
    

    
    
    // MARK: - update the Views
    private func updateUI(title: String?, releaseDate: String?, rating: Double?, overview: String?, poster: String?, id: Int?, adult: Bool) {
        self.movieTitle.text = title
        self.movieYear.text = convertDateFormater(releaseDate)
        
        
        guard let rate = rating else { return }
        //self.movieRate.text = String(rate)
        self.movieRate.text = String(format: "%.1f", rate)
        
        // add movie raiting star
        ratingStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        let maxStars = 8
        let starImage = UIImage(named: "ratedStar") // название изображения звезды
        let raitingStars = min(Int(((rate) + 8 ) / 2.0),  maxStars )
        
        for _ in 0..<raitingStars {
            let starImageView = UIImageView(image: starImage)
            starImageView.contentMode = .scaleAspectFit
            starImageView.snp.makeConstraints { make in
                make.width.equalTo(20)
                make.height.equalTo(20)
                
            }

            ratingStackView.addArrangedSubview(starImageView)
        }

        views.addSubview(ratingStackView)
        ratingStackView.translatesAutoresizingMaskIntoConstraints = false
        ratingStackView.snp.makeConstraints { make in
            make.top.equalTo(movieYear.snp.bottom).offset(16)
            make.leading.equalTo(movieRate.snp.trailing).offset(15)

        }
        
        self.movieOverview.text = overview
        
            DispatchQueue.main.async {
                if let posterPath = poster {
                    let baseURL = "https://image.tmdb.org/t/p/w500"
                    let fullURL = URL(string: baseURL + posterPath)
                    self.moviePoster.sd_setImage(with: fullURL, completed: nil)
                } else {
                    self.moviePoster.image = UIImage(named: "noImageAvailable")
                }
            }
            
        self.adult = adult
        
    }
    
    
    private func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Failed to load image: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            DispatchQueue.main.async {
                self.moviePoster.image = UIImage(data: data)
            }
        }.resume()
    }
    
    
    
    // MARK: - get image data
    func getDataImageFrom(url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            // handle error
            if let error = error {
                print("DataTask error: \(error.localizedDescription)")
            }
            
            guard let data = data else {
                // handle empty data
                print("empty data")
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self.moviePoster.image = image
                }
            }
            
        }.resume()
    }
    
    
    
    // MARK: - convert date format
    func convertDateFormater(_ date: String?) -> String {
        var fixDate = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let originalDate = date {
            if let newDate = dateFormatter.date(from: originalDate) {
                dateFormatter.dateFormat = "dd.MM.yyyy"
                fixDate = dateFormatter.string(from: newDate)
            }

        }
        return fixDate
    }
    

}





/*

//        guard let posterString = poster else { return }
//        urlString = "https://image.tmdb.org/t/p/w300" + posterString
//
//        guard let posterImageUrl = URL(string: urlString) else {
//            self.moviePoster.image = UIImage(named: "noImageAvailable")
//            return
//        }
//        // before we download the image we clear out the old one
//        self.moviePoster.image = nil
//        getDataImageFrom(url: posterImageUrl)
        
//        guard let posterString = poster else { return }
 //       urlString = "https://image.tmdb.org/t/p/w500" + posterString
//        guard let posterImageUrl = URL(string: urlString) else {
//            self.moviePoster.image = UIImage(named: "noImageAvailable")
//            return
//        }
        
        if let posterURLString = poster, let posterURL = URL(string: posterURLString) {
            moviePoster.sd_setImage(with: posterURL, placeholderImage: UIImage(named: "noImageAvailable"), completed: nil)
        } else {
            moviePoster.image = UIImage(named: "noImageAvailable")
        }
        //getDataImageFrom(url: posterImageUrl)
        
//        if let posterURLSting = poster, let url = URL(string: posterURLSting) {
//            loadImage(from: url)
//        }
        
*/
