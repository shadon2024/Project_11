//
//  ViewController.swift
//  Rest_API_Video
//
//  Created by Admin on 29/05/24.
//

import UIKit
import SnapKit
import Foundation

class DetailViewController: UIViewController {
    
    
    
    lazy var moviePoster: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        return image
    }()
    
    lazy var movieTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    lazy var movieYear: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var movieOverview: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        return label
    }()
    
    lazy var showMoreLabel: UILabel = {
        let label = UILabel()
        //label.numberOfLines = 2
        return label
    }()
    
    private var isExpanded = false
    
    
    lazy var movieRate: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var id: Int?
    
    lazy var textId: UILabel = {
        let text = UILabel()
        text.text = "hello"
        text.textAlignment = .left
        return text
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
        rating.backgroundColor = .white
        return rating
    }()
    
    
    lazy var click: UILabel = {
        let text = UILabel()
        text.text = "click on the photo to see"
        //text.textAlignment = .left
        text.font = .systemFont(ofSize: 12)
        return text
    }()
    
    private var adult: Bool?
    
    lazy var original_language: UILabel = {
        let text = UILabel()
        text.font = .systemFont(ofSize: 18, weight: .semibold)
        return text
    }()
    
    lazy var popularity: UILabel = {
        let text = UILabel()
        text.font = .systemFont(ofSize: 18, weight: .semibold)
        return text
    }()
    
    lazy var vote_count: UILabel = {
        let text = UILabel()
        text.font = .systemFont(ofSize: 18, weight: .semibold)
        return text
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupViewsConstraints()
        setupShowImage()
        setupDescriptionLabel()
        setupShowMoreLabel()
        //view.backgroundColor = .systemGray
    }
    
    private func setupDescriptionLabel() {
        //view.addSubview(descriptionLabel)
            
        movieOverview.numberOfLines = 3 // Initially show only 3 lines
        movieOverview.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                //movieOverview.topAnchor.constraint(equalTo: moviePoster.bottomAnchor, constant: 20),
                //movieOverview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                //movieOverview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            ])
            
            // Set the description text
        movieOverview.text = movies.overview
        }

    private func setupShowMoreLabel() {
            view.addSubview(showMoreLabel)
            
            showMoreLabel.text = "Показать больше"
            showMoreLabel.textColor = .blue
            showMoreLabel.isUserInteractionEnabled = true
            showMoreLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                showMoreLabel.topAnchor.constraint(equalTo: movieOverview.bottomAnchor, constant: 2),
                showMoreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                //showMoreLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            ])
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showMoreTapped))
            showMoreLabel.addGestureRecognizer(tapGesture)
    }
    
    @objc private func showMoreTapped() {
        isExpanded.toggle()
        movieOverview.numberOfLines = isExpanded ? 0 : 3
        showMoreLabel.text = isExpanded ? "Показать меньше" : "Показать больше"
    }
    
    
    
    private func setupShowImage() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
        moviePoster.isUserInteractionEnabled = true
        moviePoster.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func imageTapped(_ sender: UITapGestureRecognizer) {
        let fullScreenImageViewController = FullScreenImageViewController(image: moviePoster.image!)
        fullScreenImageViewController.modalPresentationStyle = .fullScreen
        present(fullScreenImageViewController, animated: true, completion: nil)
    }
    
    
    
    // MARK: - setupViews
    private func setupViews() {
        
        self.title = "Movie"
        
        view.backgroundColor = .white
        view.addSubview(movieTitle)
        view.addSubview(movieYear)
        view.addSubview(moviePoster)
        view.addSubview(movieOverview)
        view.addSubview(movieRate)
        view.addSubview(movieRateIcon)
        view.addSubview(ratingStackView)
        view.addSubview(textId)
        
        moviePoster.translatesAutoresizingMaskIntoConstraints = false
        moviePoster.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            //make.top.equalTo(view.safeAreaLayoutGuide).offset(-50)
            make.width.equalTo(150)
            make.height.equalTo(150)
            make.centerX.equalToSuperview()
        }
        
        
        movieTitle.translatesAutoresizingMaskIntoConstraints = false
        movieTitle.snp.makeConstraints { make in
            make.top.equalTo(moviePoster.snp.bottom).offset(26)
            make.centerX.equalToSuperview()
            //make.height.equalTo(40)
            make.width.equalToSuperview()
        }
        
        movieOverview.snp.makeConstraints { make in
            make.top.equalTo(movieTitle.snp.bottom).offset(15)
            make.width.equalTo(340)
            //make.centerX.equalToSuperview()
            make.leading.equalTo(16)
        }
        
        movieYear.snp.makeConstraints { make in
            make.top.equalTo(movieOverview.snp.bottom).offset(40)
            make.width.equalTo(340)
            //make.height.equalTo(40)
            //make.centerX.equalToSuperview()
            make.leading.equalTo(16)
        }
        
        movieRate.snp.makeConstraints { make in
            make.top.equalTo(movieYear.snp.bottom).offset(10)
            make.width.equalTo(340)
            //make.leading.equalTo(22)
            //make.height.equalTo(40)
            //make.centerX.equalToSuperview()
            make.leading.equalTo(16)
        }
        
        textId.snp.makeConstraints { make in
            make.top.equalTo(movieRate.snp.bottom).offset(10)
            make.width.equalTo(340)
            //make.centerX.equalToSuperview()
            make.leading.equalTo(16)
        }
        
        view.addSubview(click)
        click.translatesAutoresizingMaskIntoConstraints = false
        click.snp.makeConstraints { make in
            make.top.equalTo(moviePoster.snp.bottom).offset(3)
            make.width.equalTo(150)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(original_language)
        original_language.translatesAutoresizingMaskIntoConstraints = false
        original_language.snp.makeConstraints {make in
            make.top.equalTo(textId.snp.bottom).offset(10)
            make.leading.equalTo(16)
        }
        
        view.addSubview(popularity)
        popularity.translatesAutoresizingMaskIntoConstraints = false
        popularity.snp.makeConstraints { make in
            make.top.equalTo(original_language.snp.bottom).offset(10)
            make.leading.equalTo(16)
        }
        
        view.addSubview(vote_count)
        vote_count.translatesAutoresizingMaskIntoConstraints = false
        vote_count.snp.makeConstraints { make in
            make.top.equalTo(popularity.snp.bottom).offset(10)
            make.leading.equalTo(16)
        }
        
    }
    
    
    
    let movies: Movie
    
    init(_ movies: Movie) {
        self.movies = movies
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var urlString: String = ""
    
    
    
    // MARK: - setupViewsConstraints
    private func setupViewsConstraints() {
        
        self.movieTitle.text = movies.title
        
            DispatchQueue.main.async {
                if let posterPath = self.movies.posterImage {
                    let baseURL = "https://image.tmdb.org/t/p/w500"
                    let fullURL = URL(string: baseURL + posterPath)
                    self.moviePoster.sd_setImage(with: fullURL, completed: nil)
                } else {
                    self.moviePoster.image = UIImage(named: "noImageAvailable")
                }
            }
        
        self.movieOverview.text = movies.overview
        self.movieOverview.numberOfLines = 0
        
        
        self.movieYear.text = "Production date:  \(movies.year ?? "nil" )"
        self.movieYear.textAlignment = .left
        self.movieYear.font = .systemFont(ofSize: 20, weight: .medium)
        
        self.movieRate.text = "Rating:  \(movies.rate ?? 0)"
        ratingStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        let maxStars = 8
        let starImage = UIImage(named: "ratedStar") // название изображения звезды
        let raitingStars = min(Int(((movies.rate ?? 0) + 8 ) / 2.0),  maxStars )
        
        for _ in 0..<raitingStars {
            let starImageView = UIImageView(image: starImage)
            starImageView.contentMode = .scaleAspectFit
            starImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
            starImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
            ratingStackView.addArrangedSubview(starImageView)
        }
        ratingStackView.snp.makeConstraints { make in
            make.top.equalTo(movieYear.snp.bottom).offset(15)
            make.leading.equalTo(movieRate.snp.trailing).offset(-200)

            self.movieRate.textAlignment = .left
            self.movieRate.font = .systemFont(ofSize: 20, weight: .medium)
        }
        
        //self.id = movies.id
        self.textId.text = "Id film: \(movies.id ?? 0)"
        self.textId.font = .systemFont(ofSize: 16, weight: .bold)
        
        self.original_language.text = "Original language:  \(movies.original_language ?? "not")"
        
        //self.popularity.text = "\(movies.popularity ?? 0)"
        self.vote_count.text = "Vote count: \(movies.vote_count ?? 0)"
        

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
        
        
    }

