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
        TVMazeProvider.shared.requestTVShows(searchString: searchText, completion: { tvShowResponses in
            self.updateShows(forTVShowResponses: tvShowResponses)
        })
    }
    
    public func getShowFor(indexPath: IndexPath) -> TVShow {
        return shows[indexPath.row]
    }
    
    func updateShows(forTVShowResponses tvShowResponses: [TVShowResponse]) {
        shows = tvShowResponses.map({ response in return response.show })
    }
}