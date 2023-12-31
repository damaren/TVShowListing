//
//  TVShowSearchViewController.swift
//  TVShows
//
//  Created by José Damaren on 23/06/23.
//

import UIKit

protocol TVShowSearchViewModelProtocol: AnyObject {
    var title: String { get set }
    var numberOfRows: Int { get }
    
    func requestTVShows(withSearchText searchText: String, completion: (() -> ())?)
    func getShowFor(indexPath: IndexPath) -> TVShow
}

class TVShowSearchViewController: UIViewController {
    
    // MARK: - PROPERTIES
    
    weak var delegate: TVShowSearchViewControllerDelegate?
    var viewModel: TVShowSearchViewModelProtocol?
    var provider: Provider = TVMazeProvider()
    
    // MARK: - COMPONENTS
    
    var searchView: UIView?
    var showsTableView: UITableView = UITableView()
    
    // MARK: - FUNCTIONS
    
    func configure(viewModel: TVShowSearchViewModelProtocol, searchView: UIView) {
        self.viewModel = viewModel
        self.searchView = searchView
        setup()
        layoutViews()
    }
    
    func setup() {
        self.title = viewModel?.title
        view.backgroundColor = .systemBackground
        
        guard let searchView = searchView else { return }
        
        // searchView
        searchView.translatesAutoresizingMaskIntoConstraints = false
        searchView.backgroundColor = .systemBackground
        
        // tableview
        showsTableView.translatesAutoresizingMaskIntoConstraints = false
        showsTableView.dataSource = self
        showsTableView.delegate = self
        showsTableView.register(TVShowTableViewCell.self, forCellReuseIdentifier: TVShowTableViewCell.reuseIdentifier)
        showsTableView.backgroundColor = .systemBackground
    }
    
    func layoutViews() {
        guard let searchView = searchView else { return }
        
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
}

// MARK: - SearchViewDelegate

extension TVShowSearchViewController: SearchViewDelegate {
    func searchViewSearchButtonPressed(withSearchText searchText: String, completion: (() -> ())?) {
        viewModel?.requestTVShows(withSearchText: searchText, completion: completion)
    }
}

// MARK: - UITableViewDataSource

extension TVShowSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TVShowTableViewCell.reuseIdentifier, for: indexPath) as? TVShowTableViewCell, let show = viewModel?.getShowFor(indexPath: indexPath) else {
            return UITableViewCell()
        }
        
        let cellViewModel = TVShowTableViewCellViewModel(showSearchView: cell)
        
        cell.configure(forShow: show, andViewModel: cellViewModel, withProvider: provider)
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension TVShowSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let show = viewModel?.getShowFor(indexPath: indexPath) {
            delegate?.selectedShow(show: show, withAnimation: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TVShowTableViewCell.cellHeight
    }
}

// MARK: - TVShowSearchViewProtocol
extension TVShowSearchViewController: TVShowSearchViewProtocol {
    func updateView(completion: (() -> ())? = nil) {
        DispatchQueue.main.async { // update UI
            self.showsTableView.reloadData()
            completion?()
        }
    }
}

// MARK: - TVShowSearchViewControllerDelegate
protocol TVShowSearchViewControllerDelegate: AnyObject {
    func selectedShow(show: TVShow, withAnimation: Bool)
}
