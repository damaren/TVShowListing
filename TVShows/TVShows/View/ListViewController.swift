//
//  ViewController.swift
//  TVShows
//
//  Created by José Damaren on 23/06/23.
//

import UIKit

class ListViewController: UIViewController {
    
    // MARK: - PROPERTIES
    
    weak var delegate: ListViewControllerDelegate?
    var viewModel: ListViewModel = ListViewModel()
    
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
        self.title = "TV Show Listing"
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
    
    func updateView() {
        DispatchQueue.main.async { // update UI
            self.showsTableView.reloadData()
        }
    }
}

// MARK: - SearchViewDelegate

extension ListViewController: SearchViewDelegate {
    func searchViewSearchButtonPressed(withSearchText searchText: String) {
        viewModel.requestTVShows(withSearchText: searchText)
    }
}

// MARK: - UITableViewDataSource

extension ListViewController: UITableViewDataSource {
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

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selectedShow(show: viewModel.getShowFor(indexPath: indexPath))
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TVShowTableViewCell.cellHeight
    }
}

// MARK: - ListViewControllerDelegate
protocol ListViewControllerDelegate: AnyObject {
    func selectedShow(show: TVShow)
}

