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
    
    var numberOfRows: Int {
        return shows.count
    }
    
    // the view will set this variable so that it will update itself when this function is called
    var updateView: () -> () = {}
    
    // MARK: - FUNCTIONS
    
    public func searchButtonPressed(withSearchText searchText: String) {
        requestTVShows(withSearchText: searchText, andProvider: TVMazeProvider.shared)
    }
    
    public func getShowFor(indexPath: IndexPath) -> TVShow {
        return shows[indexPath.row]
    }
    
    func requestTVShows(withSearchText searchText: String, andProvider provider: Provider) {
        provider.requestTVShows(searchString: searchText, completion: { tvShowResponses, error in
            guard let tvShowResponses = tvShowResponses else { return }
            self.updateShows(forTVShowResponses: tvShowResponses)
        })
    }
    
    func updateShows(forTVShowResponses tvShowResponses: [TVShowResponse]) {
        shows = tvShowResponses.map({ response in return response.show })
    }
}
