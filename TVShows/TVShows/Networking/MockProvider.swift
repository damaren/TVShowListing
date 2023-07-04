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
    
    var showResponses: [TVShowResponse]
    var episodes: [Episode]
    var image: UIImage?
    
    // MARK: - Init
    
    init(showResponses: [TVShowResponse] = [], episodes: [Episode] = [], image: UIImage? = nil) {
        self.showResponses = showResponses
        self.episodes = episodes
        self.image = image
    }
    
    // MARK: - FUNCTIONS
    
    func requestTVShows(searchString: String, completion: @escaping ([TVShowResponse]) -> ()) {
        completion(showResponses)
    }
    
    func requestEpisodes(showID: Int, completion: @escaping ([Episode]) -> ()) {
        completion(episodes)
    }
    
    func requestImage(forUrl urlString: String?, completion: @escaping (UIImage?) -> ()) {
        completion(image)
    }
}
