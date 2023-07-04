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
    var responseError: NetworkError?
    
    // MARK: - Init
    
    init(showResponses: [TVShowResponse] = [], episodes: [Episode] = [], image: UIImage? = nil, responseError: NetworkError? = nil) {
        self.showResponses = showResponses
        self.episodes = episodes
        self.image = image
        self.responseError = responseError
    }
    
    // MARK: - FUNCTIONS
    
    func requestTVShows(searchString: String, completion: @escaping ([TVShowResponse]?, NetworkError?) -> ()) {
        completion(showResponses, nil)
    }
    
    func requestEpisodes(showID: Int, completion: @escaping ([Episode]?, NetworkError?) -> ()) {
        if let responseError = responseError {
            completion(nil, responseError)
        } else {
            completion(episodes, nil)
        }
    }
    
    func requestImage(forUrl urlString: String?, completion: @escaping (UIImage?, NetworkError?) -> ()) {
        completion(image, nil)
    }
}
