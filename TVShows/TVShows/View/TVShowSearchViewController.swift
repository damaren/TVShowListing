//
//  TVShowSearchViewController.swift
//  TVShows
//
//  Created by José Damaren on 23/06/23.
//

import UIKit

class TVShowSearchViewController: UIViewController {
    
    // MARK: - PROPERTIES
    
    weak var delegate: TVShowSearchViewControllerDelegate?
    var viewModel: TVShowSearchViewModel = TVShowSearchViewModel()
    
    // MARK: - COMPONENTS
    
    var searchView: SearchView = SearchView()
    var showsTableView: UITableView = UITableView()
    
    // MARK: - LIFECYCLE

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layoutViews()
    }
    
    // MARK: - FUNCTIONS
    
    func setup() {
        self.title = viewModel.title
        view.backgroundColor = .systemBackground
        
        // update
        viewModel.updateView = { [weak self] in
            self?.updateView()
        }
        
        // searchView
        searchView.translatesAutoresizingMaskIntoConstraints = false
        searchView.backgroundColor = .systemBackground
        searchView.delegate = self
        
        // tableview
        showsTableView.translatesAutoresizingMaskIntoConstraints = false
        showsTableView.dataSource = self
        showsTableView.delegate = self
        showsTableView.register(TVShowTableViewCell.self, forCellReuseIdentifier: TVShowTableViewCell.reuseIdentifier)
        showsTableView.backgroundColor = .systemBackground
    }
    
    func layoutViews() {
        view.addSubview(searchView)
        view.addSubview(showsTableView)
        
        // searchView
        searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        searchView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        // tableview
        showsTableView.topAnchor.constraint(equalTo: searchView.bottomAnchor).isActive = true
        showsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        showsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        showsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func updateView(completion: (() -> ())? = nil) {
        DispatchQueue.main.async { // update UI
            self.showsTableView.reloadData()
            completion?()
        }
    }
}

// MARK: - SearchViewDelegate

extension TVShowSearchViewController: SearchViewDelegate {
    func searchViewSearchButtonPressed(withSearchText searchText: String, completion: (() -> ())?) {
        viewModel.requestTVShows(withSearchText: searchText, completion: completion)
    }
}

// MARK: - UITableViewDataSource

extension TVShowSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TVShowTableViewCell.reuseIdentifier, for: indexPath) as? TVShowTableViewCell else {
            return UITableViewCell()
        }
        
        let show = viewModel.getShowFor(indexPath: indexPath)
        cell.configure(forShow: show)
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension TVShowSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selectedShow(show: viewModel.getShowFor(indexPath: indexPath), withAnimation: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TVShowTableViewCell.cellHeight
    }
}

// MARK: - TVShowSearchViewControllerDelegate
protocol TVShowSearchViewControllerDelegate: AnyObject {
    func selectedShow(show: TVShow, withAnimation: Bool)
}

