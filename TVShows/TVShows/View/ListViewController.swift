//
//  ViewController.swift
//  TVShows
//
//  Created by José Damaren on 23/06/23.
//

import UIKit

class ListViewController: UIViewController {
    
    // MARK: - PROPERTIES
    
    var listLabel: UILabel = UILabel()
    var searchView: SearchView = SearchView()
    
    // MARK: - LIFECYCLE

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layoutViews()
    }
    
    // MARK: - FUNCTIONS
    
    func setup() {
        
        // listLabel
        listLabel.translatesAutoresizingMaskIntoConstraints = false
        listLabel.text = ""
        listLabel.textColor = .label
        listLabel.numberOfLines = 0
        
        // searchView
        searchView.translatesAutoresizingMaskIntoConstraints = false
        searchView.backgroundColor = .secondarySystemBackground
        searchView.delegate = self
    }
    
    func layoutViews() {
        view.addSubview(listLabel)
        view.addSubview(searchView)
        
        // listlabel
        listLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        listLabel.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 20).isActive = true
        
        // searchView
        searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        searchView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    func updateView(forTVShowResponses tvShowResponses: [TVShowResponse]) {
        self.listLabel.text = ""
        for tvShow in tvShowResponses {
            if let id = tvShow.show.id, let name = tvShow.show.name, let listLabelText = self.listLabel.text {
                print(id)
                print(name)
                self.listLabel.text = "\(listLabelText)\n\(id)   \(name)"
            }
        }
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
