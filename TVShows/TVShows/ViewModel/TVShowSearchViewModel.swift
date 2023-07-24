//
//  TVShowSearchViewModel.swift
//  TVShows
//
//  Created by José Damaren on 26/06/23.
//

import Foundation

class TVShowSearchViewModel {
    
    // MARK: - STATIC PROPERTIES
    
    static var tvShowSearchTitle: String = "TV Show Search"
    
    // MARK: - PROPERTIES
    
    var shows: [TVShow] = [] {
        didSet {
            updateView()
        }
    }
    
    // the view will set this variable so that it will update itself when this function is called
    var updateView: () -> () = {}
    
    var error: NetworkError?
    
    var numberOfRows: Int {
        return shows.count
    }
    
    var title: String = TVShowSearchViewModel.tvShowSearchTitle
    
    // MARK: - FUNCTIONS
    
    public func getShowFor(indexPath: IndexPath) -> TVShow {
        return shows[indexPath.row]
    }
    
    func requestTVShows(withSearchText searchText: String, andProvider provider: Provider = TVMazeProvider.shared, completion: (() -> ())? = nil) {
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
    
    func updateShows(forTVShowResponses tvShowResponses: [TVShowResponse]) {
        shows = tvShowResponses.map({ response in return response.show })
    }
}
