//
//  MockProvider.swift
//  TVShows
//
//  Created by José Damaren on 26/06/23.
//

import Foundation
import UIKit

// class for unit testing the functions that depend on requests (dependency injection)
class MockProvider: Provider {
    
    // MARK: - PROPERTIES
    
    var showResponses: [TVShowResponse]
    var episodes: [Episode]
    var image: UIImage?
    var responseError: NetworkError?
    var queryAllowedStringError: NetworkError?
    var urlCreationError: NetworkError?
    var JSONDecodeError: NetworkError?
    
    // MARK: - Init
    
    init(showResponses: [TVShowResponse] = [], episodes: [Episode] = [], image: UIImage? = nil, responseError: NetworkError? = nil, queryAllowedStringError: NetworkError? = nil, urlCreationError: NetworkError? = nil, JSONDecodeError: NetworkError? = nil) {
        self.showResponses = showResponses
        self.episodes = episodes
        self.image = image
        self.responseError = responseError
        self.queryAllowedStringError = queryAllowedStringError
        self.urlCreationError = urlCreationError
        self.JSONDecodeError = JSONDecodeError
    }
    
    // MARK: - FUNCTIONS
    
    func requestTVShows(searchString: String, completion: @escaping ([TVShowResponse]?, NetworkError?) -> ()) {
        if let queryAllowedStringError = queryAllowedStringError {
            completion(nil, queryAllowedStringError)
        } else if let responseError = responseError {
            completion(nil, responseError)
        } else if let urlCreationError = urlCreationError {
            completion(nil, urlCreationError)
        } else if let JSONDecodeError = JSONDecodeError {
            completion(nil, JSONDecodeError)
        } else {
            completion(showResponses, nil)
        }
    }
    
    func requestEpisodes(showID: Int, completion: @escaping ([Episode]?, NetworkError?) -> ()) {
        if let responseError = responseError {
            completion(nil, responseError)
        } else if let urlCreationError = urlCreationError {
            completion(nil, urlCreationError)
        } else if let JSONDecodeError = JSONDecodeError {
            completion(nil, JSONDecodeError)
        } else {
            completion(episodes, nil)
        }
    }
    
    func requestImage(forUrl urlString: String?, completion: @escaping (UIImage?, NetworkError?) -> ()) {
        if let responseError = responseError {
            completion(nil, responseError)
        } else if let urlCreationError = urlCreationError {
            completion(nil, urlCreationError)
        } else {
            completion(image, nil)
        }
    }
}
