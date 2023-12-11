//
//  TVMazeProvider.swift
//  TVShows
//
//  Created by José Damaren on 24/06/23.
//

import Foundation
import UIKit

class TVMazeProvider: Provider {
    
    // MARK: - SINGLETON
    
    static let baseURL: String = "https://api.tvmaze.com"
    
    // MARK: - PROPERTIES
    
    private var urlSession: URLSession
    private var baseURL: String
    
    // MARK: - INIT
    init(urlSession: URLSession = .shared, baseURL: String = TVMazeProvider.baseURL) {
        self.urlSession = urlSession
        self.baseURL = baseURL
    }
    
    // MARK: - FUNCTIONS
    
    func requestTVShows(searchString: String, completion: @escaping ([TVShowResponse]?, NetworkError?) -> ()) {
        guard let urlQueryAllowedString = searchString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            completion(nil, .queryAllowedStringError(description: searchString))
            return
        }
        
        let urlString = "\(baseURL)/search/shows?q=\(urlQueryAllowedString)"
        
        guard let url = URL(string: urlString) else {
            completion(nil, .urlCreationError(description: urlString))
            return
        }

        let task = urlSession.dataTask(with: url) {(data, response, error) in
            guard error == nil, let data = data else {
                completion(nil, .responseError(description: error!.localizedDescription))
                return
            }
            if let tvShowResponses: [TVShowResponse] = try? JSONDecoder().decode([TVShowResponse].self, from: data) {
                completion(tvShowResponses, nil)
            } else {
                completion(nil, .JSONDecodeError)
            }
        }

        task.resume()
    }
    
    func requestEpisodes(showID: Int, completion: @escaping ([Episode]?, NetworkError?) -> ()) {
        let urlString = "\(baseURL)/shows/\(showID)/episodes"
        
        guard let url = URL(string: urlString) else {
            completion(nil, .urlCreationError(description: urlString))
            return
        }

        let task = urlSession.dataTask(with: url) {(data, response, error) in
            guard error == nil, let data = data else {
                completion(nil, .responseError(description: error!.localizedDescription))
                return
            }
            if let episodes: [Episode] = try? JSONDecoder().decode([Episode].self, from: data) {
                completion(episodes, nil)
            } else {
                completion(nil, .JSONDecodeError)
            }
        }

        task.resume()
    }
    
    func requestImage(forUrl urlString: String?, completion: @escaping (UIImage?, NetworkError?) -> ()) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            completion(nil, .urlCreationError(description: urlString ?? "The url string was nil"))
            return
        }
        
        let task = urlSession.dataTask(with: url) { (data, response, error) in
            guard error == nil, let data = data else {
                completion(nil, .responseError(description: error!.localizedDescription))
                return
            }
            
            completion(UIImage(data: data), nil)
        }
        task.resume()
    }
}
