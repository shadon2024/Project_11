//
//  SecondViewController.swift
//  Rest_API_Video
//
//  Created by Admin on 01/06/24.
//

import UIKit
import SnapKit
import SDWebImage

class SecondViewController: UIViewController {

    
    private let searchController = UISearchController(searchResultsController: nil)
    private var viewModel = SecondMovieViewModel()
    private  var collectionView: UICollectionView!
    private var people: [Result] = []
    var filteredPeople: [Result] = []
    var isSearchActive: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupFetchData()

        setupSearchController()
        setupLayoutCollection()
    
    }
    
    
    // MARK: - setupFetchData
    private func setupFetchData() {
        
        let dispachGroup = DispatchGroup()
        
        for page in 1...2 {
            dispachGroup.enter()
            
            let url = URL(string: "https://api.themoviedb.org/3/person/popular")!
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
            let queryItems: [URLQueryItem] = [
                URLQueryItem(name: "language", value: "en-US"),
                URLQueryItem(name: "page", value: "\(page)"),
            ]
            components.queryItems = queryItems
            
            var request = URLRequest(url: components.url!)
            request.httpMethod = "GET"
            request.timeoutInterval = 10
            request.allHTTPHeaderFields = [
                "accept": "application/json",
                "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkZTczNGM1MjIzMGIxYmM0NjQyOTkzOGMxNWRmNDkzZSIsInN1YiI6IjY2NTViZDZlMjcyM2UzMWNkNGEzNmI0MCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Kvnpetmvxzgf_TzdI_925pVKKQ-mQOftvsHYQvxAPIM"
            ]
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                defer { dispachGroup.leave() }
                
                
                guard let data = data else {
                    print("Error: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                
                do {
                    let response = try JSONDecoder().decode(PopularPersonResponse.self, from: data)
                    self.people.append(contentsOf: response.results)
//                    DispatchQueue.main.async {
//                        self.collectionView.reloadData()
//                    }
                    
                    for movie in self.people {
                        if let posterURL = movie.profileImageUrl {
                            SDWebImagePrefetcher.shared.prefetchURLs([posterURL])
                        }
                    }
                } catch {
                    print("Failed to decode JSON: \(error)")
                }
                
                
            }.resume()
            

            
            dispachGroup.notify(queue: .main) {
                self.collectionView.reloadData()
            }
        }
        
        

    }
    
    
    
    
    
    // MARK: - setupSearchController
    private func setupSearchController() {
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search People"
        
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = true
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
        self.searchController.searchBar.delegate = self
        self.searchController.searchBar.showsBookmarkButton = true
        
        self.searchController.searchBar.setImage(UIImage(systemName: "line.horizontal.3.decrease"), for: .bookmark, state: .normal)
    }
    
    
    
    
    // MARK: - setupLayoutCollection
    private func setupLayoutCollection() {
        
        // Настройка layout для коллекционного вида
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: -30, right: 20)
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        layout.itemSize = CGSize(width: 166, height: 200)

        
        // Инициализация UICollectionView
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCell")
        collectionView.backgroundColor = .white
        
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            //make.top.equalTo()
        }

    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredPeople = people.filter { (person: Result) -> Bool in
            return person.name.lowercased().contains(searchText.lowercased())
        }
        collectionView.reloadData()
    }
    

}




// MARK: - Search Controller Functions
extension SecondViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        viewModel.clearSearch()
//        collectionView.reloadData()
//    }
    
    func updateSearchResults(for searchController: UISearchController) {
        //        guard let query = searchController.searchBar.text, !query.isEmpty else {
        //            viewModel.clearSearch()
        //            collectionView.reloadData()
        //            return
        //        }
        //        viewModel.isSearching = true
        //        viewModel.filterMovies(for: query)
        //        collectionView.reloadData()
        //    }
        
        let searchBar = searchController.searchBar
        let searchText = searchBar.text ?? ""
        isSearchActive = !searchText.isEmpty
        filterContentForSearchText(searchText)
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        print("DEBUG PRINT:", "button clicked")
    }
    
}








extension SecondViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    // количество элементов в секции
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return 20 // количество ячеек
        return isSearchActive ? filteredPeople.count : people.count
    }
    
    
    // настройка ячейки
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCollectionViewCell
//        cell.backgroundColor = UIColor.systemRed
//        cell.imageView.image = UIImage(named: "ratedStar")
//        cell.textLabel.text = "Rizoev Shodon"
//        return cell
        let person = isSearchActive ? filteredPeople[indexPath.row] : people[indexPath.row]
        cell.textLabel.text = person.name
        cell.backgroundColor = .systemGray4
        cell.layer.cornerRadius = 8
        
        
        DispatchQueue.main.async {
            if let url = person.profileImageUrl {
                cell.imageView.sd_setImage(with: url, placeholderImage: UIImage(systemName: "photo"), options: .highPriority, completed: nil)
            } else {
                cell.imageView.image = UIImage(systemName: "photo") // Показать заменяющее изображение
            }
        }
        
        return cell
    }
    
    
    // Обработка нажатий на ячейки
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Выбрана ячейка \(indexPath.row)")
    }
    
}






/*
 
 let url = URL(string: "https://api.themoviedb.org/3/person/popular")!
 var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
 let queryItems: [URLQueryItem] = [
     URLQueryItem(name: "language", value: "en-US"),
     URLQueryItem(name: "page", value: "1"),
 ]
 components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
 
 var request = URLRequest(url: components.url!)
 request.httpMethod = "GET"
 request.timeoutInterval = 10
 request.allHTTPHeaderFields = [
     "accept": "application/json",
     "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkZTczNGM1MjIzMGIxYmM0NjQyOTkzOGMxNWRmNDkzZSIsInN1YiI6IjY2NTViZDZlMjcyM2UzMWNkNGEzNmI0MCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Kvnpetmvxzgf_TzdI_925pVKKQ-mQOftvsHYQvxAPIM"
 ]
 
 let task = URLSession.shared.dataTask(with: request) { data, response, error in
     guard let data = data else {
         print("Error: \(error?.localizedDescription ?? "Unknown error")")
         return
     }
     
     do {
         let response = try JSONDecoder().decode(PopularPersonResponse.self, from: data)
         self.people = response.results
         
         DispatchQueue.main.async {
             self.collectionView.reloadData()
         }
     } catch {
         print("Failed to decode JSON: \(error)")
     }
     
     
 }
 
 task.resume()
 
 
 //                    if let posterPath = person.profilePath {
 //                        let baseURL = "https://image.tmdb.org/t/p/w500"
 //                        let fullURL = URL(string: baseURL + posterPath)
 //                        cell.imageView.sd_setImage(with: fullURL, completed: nil)
 //
 //                    } else {
 //                        cell.imageView.image = UIImage(named: "noImageAvailable")
 //                    }
 //                    cell.imageView.image = UIImage(data: data)
 
 
 
 
 
 
 if let url = person.profileImageUrl {
     URLSession.shared.dataTask(with: url) { data, response, error in
         
         guard let data = data, error == nil else {
             print("Failed to load image: \(error?.localizedDescription ?? "Unknown error")")
             DispatchQueue.main.async {
                 cell.imageView.image = UIImage(systemName: "photo") // Показать заменяющее изображение
             }
             return
         }
         
         DispatchQueue.main.async {
             if let url = person.profileImageUrl {
                 cell.imageView.sd_setImage(with: url, placeholderImage: UIImage(systemName: "photo"), options: .highPriority, completed: nil)
             } else {
                 cell.imageView.image = UIImage(systemName: "photo") // Показать заменяющее изображение
             }
         }
         
     }.resume()
 
 
 
 */
