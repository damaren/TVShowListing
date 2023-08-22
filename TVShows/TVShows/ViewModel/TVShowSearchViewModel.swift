//
//  TVShowSearchViewModel.swift
//  TVShows
//
//  Created by José Damaren on 26/06/23.
//

import Foundation

protocol TVShowSearchViewProtocol: AnyObject {
    func updateView(completion: (() -> ())?)
}

class TVShowSearchViewModel {
    
    // MARK: - STATIC PROPERTIES
    
    static var tvShowSearchTitle: String = "TV Show Search"
    
    // MARK: - PROPERTIES
    
    weak var showSearchView: TVShowSearchViewProtocol?
    
    var shows: [TVShow] = [] {
        didSet {
            showSearchView?.updateView(completion: nil)
        }
    }
    
    var error: NetworkError?
    
    var numberOfRows: Int {
        return shows.count
    }
    
    var title: String = TVShowSearchViewModel.tvShowSearchTitle
    
    var provider: Provider
    
    // MARK: - INIT
    
    init(showSearchView: TVShowSearchViewProtocol, provider: Provider) {
        self.showSearchView = showSearchView
        self.provider = provider
    }
    
    // MARK: - FUNCTIONS
    
    public func getShowFor(indexPath: IndexPath) -> TVShow {
        return shows[indexPath.row]
    }
    
    func updateShows(forTVShowResponses tvShowResponses: [TVShowResponse]) {
        shows = tvShowResponses.map({ response in return response.show })
    }
}

// MARK: - TVShowSearchViewModelProtocol
extension TVShowSearchViewModel: TVShowSearchViewModelProtocol {
    func requestTVShows(withSearchText searchText: String, completion: (() -> ())?) {
        provider.requestTVShows(searchString: searchText, completion: { tvShowResponses, error in
            guard error == nil, let tvShowResponses = tvShowResponses else {
                self.shows = []
                self.error = error
                completion?()
                return
            }
            self.updateShows(forTVShowResponses: tvShowResponses)
            completion?()
        })
    }
}
