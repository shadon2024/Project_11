//
//  ViewController.swift
//  Rest_API_Video
//
//  Created by Admin on 28/05/24.
//

import UIKit
import SnapKit

class MovieViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        return table
    }()
    
    
    lazy var labelContainer: UIView = {
        let label = UIView()
        label.backgroundColor = .white
        return label
    }()
    
    
    lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = .red
        return indicator
    }()
    
    //private var viewModel = MovieViewModel()
    private var viewModel = AllPagesMovieViewModel()
    
 
    private let searchController = UISearchController(searchResultsController: nil)
    
    
    private let refrechControl = UIRefreshControl() // update tableView

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        view.addSubview(labelContainer)
        view.addSubview(indicator)
        //view.addSubview(refrechControl)
        loadPopularMoviesData()

        setupSearchController()
    }
    
   
    
    private func loadPopularMoviesData() {
        indicator.startAnimating()
        labelContainer.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.translatesAutoresizingMaskIntoConstraints = false

        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        
        
//        viewModel.fetchPopularMoviesData { [weak self] in
//            self?.tableView.reloadData()
//
//        }
        
        DispatchQueue.main.async {
            self.viewModel.fetchAllPages { [weak self] in
                self?.indicator.stopAnimating()
                self?.tableView.reloadData()
            }
        }
        

        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            
        }
        
        
        labelContainer.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(-80)
            make.height.equalTo(80)
            make.width.equalToSuperview()
        }
        
        indicator.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(5)
            make.centerX.equalToSuperview()
        }
        
        lazy var titleFilm: UILabel = {
            let label = UILabel()
            label.text = "Popular Films"
            label.textAlignment = .center
            label.backgroundColor = .black
            return label
        }()
        //self.title = titleFilm.text
        
        // обнавления таблиц при скроле вниз
        refrechControl.addTarget(self, action: #selector(refrechMoviesData), for: .valueChanged)
        tableView.refreshControl = refrechControl // add refrechControl in tableView
    }
    
    @objc func refrechMoviesData() {
        viewModel.fetchAllPages { [weak self] in
            DispatchQueue.main.async {
                //self?.tableView.reloadData()
                self?.refrechControl.endRefreshing()
            }
        }
    }
    
    
    // MARK: - setupSearchController
    
    private func setupSearchController() {
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search Films"
        
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
        self.searchController.searchBar.delegate = self
        self.searchController.searchBar.showsBookmarkButton = true
        
        self.searchController.searchBar.setImage(UIImage(systemName: "line.horizontal.3.decrease"), for: .bookmark, state: .normal)
    }
    
    

}


// MARK: - Search Controller Functions

extension MovieViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        //self.viewModel.isFiltering = false
        //tableView.reloadData()
        viewModel.clearSearch()
        tableView.reloadData()
        

    }
    
    func updateSearchResults(for searchController: UISearchController) {
//        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
//            viewModel.isFiltering = false
//            tableView.reloadData()
//            return
//        }
//        viewModel.isFiltering = true
//        viewModel.filterMovies(for: searchText)
//        tableView.reloadData()
        
//        DispatchQueue.main.async {
//            self.viewModel.fetchAllPages { [weak self] in
//                self?.tableView.reloadData()
//            }
//        }
        
        guard let query = searchController.searchBar.text, !query.isEmpty else {
            viewModel.clearSearch()
            tableView.reloadData()
            return
        }
        viewModel.isSearching = true
        viewModel.filterMovies(for: query)
        tableView.reloadData()
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        print("DEBUG PRINT:", "button clicked")
    }
    
    
}




// MARK: - tableView
extension MovieViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //viewModel.numberOfSection(section: section)
        viewModel.getMovies().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableViewCell

        //let moviee = viewModel.cellForRowAt(indexPath: [indexPath.row])
        let moviee = viewModel.getMovies()[indexPath.row]
        cell.setCellWithValuesOf(moviee)
        return cell
    

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        //let moviee = viewModel.cellForRowAt(indexPath: [indexPath.row])
        
        let moviee = viewModel.getMovies()[indexPath.row]
        let vc = DetailViewController(moviee)
        self.navigationController?.pushViewController(vc, animated: true)

    }
}
