//
//  ViewController.swift
//  TVShows
//
//  Created by José Damaren on 23/06/23.
//

import UIKit

class ListViewController: UIViewController {
    
    // MARK: - PROPERTIES
    
    var shows: [TVShow] = []
    weak var delegate: ListViewControllerDelegate?
    
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
    
    func updateView(forTVShowResponses tvShowResponses: [TVShowResponse]) {
        shows = tvShowResponses.map({ response in return response.show })
        showsTableView.reloadData()
    }
}

// MARK: - SearchViewDelegate

extension ListViewController: SearchViewDelegate {
    func searchViewSearchButtonPressed(withSearchText searchText: String) {
        TVMazeProvider.shared.requestTVShows(searchString: searchText, completion: { tvShowResponses in
            DispatchQueue.main.async { // update UI
                self.updateView(forTVShowResponses: tvShowResponses)
            }
        })
    }
}

// MARK: - UITableViewDataSource

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TVShowTableViewCell.reuseIdentifier, for: indexPath) as? TVShowTableViewCell else {
            return UITableViewCell()
        }
        
        let show = shows[indexPath.row]
        cell.configure(forShow: show)
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selectedShow(show: shows[indexPath.row])
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

