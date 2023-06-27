//
//  MockProvider.swift
//  TVShows
//
//  Created by José Damaren on 26/06/23.
//

import Foundation
import UIKit

// class for unit testing with the requests via dependency injection
class MockProvider: Provider {
    
    // MARK: - PROPERTIES
    
    var shouldCompleteWithValue: Bool = true
    
    // MARK: - Init
    
    init(shouldCompleteWithValue: Bool) {
        self.shouldCompleteWithValue = shouldCompleteWithValue
    }
    
    // MARK: - FUNCTIONS
    
    func requestTVShows(searchString: String, completion: @escaping ([TVShowResponse]) -> ()) {
        if shouldCompleteWithValue {
            completion([
                TVShowResponse(show: TVShow(id: 0)),
                TVShowResponse(show: TVShow(id: 1)),
                TVShowResponse(show: TVShow(id: 2)),
                TVShowResponse(show: TVShow(id: 3)),
                TVShowResponse(show: TVShow(id: 4)),
                TVShowResponse(show: TVShow(id: 5))
            ])
        } else {
            completion([])
        }
    }
    
    func requestEpisodes(showID: Int, completion: @escaping ([Episode]) -> ()) {
        if shouldCompleteWithValue {
            completion([
                Episode(id: 0, season: 1),
                Episode(id: 1, season: 1),
                Episode(id: 0, season: 2),
                Episode(id: 1, season: 2),
                Episode(id: 0, season: 3),
                Episode(id: 1, season: 3),
                Episode(id: 0, season: 4),
                Episode(id: 1, season: 4)
            ])
        } else {
            completion([])
        }
    }
    
    func requestImage(forUrl urlString: String?, completion: @escaping (UIImage?) -> ()) {
        if shouldCompleteWithValue {
            completion(UIImage(systemName: "xmark"))
        } else {
            completion(nil)
        }
    }
}
