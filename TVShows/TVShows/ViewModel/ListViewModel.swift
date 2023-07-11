//
//  ListViewModel.swift
//  TVShows
//
//  Created by José Damaren on 26/06/23.
//

import Foundation

class ListViewModel {
    
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
    
    // MARK: - FUNCTIONS
    
    public func searchButtonPressed(withSearchText searchText: String) {
        requestTVShows(withSearchText: searchText, andProvider: TVMazeProvider.shared)
    }
    
    public func getShowFor(indexPath: IndexPath) -> TVShow {
        return shows[indexPath.row]
    }
    
    func requestTVShows(withSearchText searchText: String, andProvider provider: Provider, completion: (() -> ())? = nil) {
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
        print("debug")
    }
}
