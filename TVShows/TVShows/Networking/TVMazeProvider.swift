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
    
    static let shared: TVMazeProvider = TVMazeProvider()
    
    // MARK: - PROPERTIES
    
    let baseURL: String = "https://api.tvmaze.com"
    
    // MARK: - FUNCTIONS
    
    func requestTVShows(searchString: String, completion: @escaping ([TVShowResponse]?, NetworkError?) -> ()) {
        guard let urlQueryAllowedString = searchString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            completion(nil, .queryAllowedStringError(searchString))
            return
        }
        
        let urlString = "\(baseURL)/search/shows?q=\(urlQueryAllowedString)"
        
        guard let url = URL(string: urlString) else {
            completion(nil, .urlCreationError(urlString))
            return
        }

        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard error == nil, let data = data else {
                completion(nil, .responseError(error?.localizedDescription))
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
            completion(nil, .urlCreationError(urlString))
            return
        }

        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard error == nil, let data = data else {
                completion(nil, .responseError(error?.localizedDescription))
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
        guard let imageUrl = urlString, let url = URL(string: imageUrl) else {
            completion(nil, .urlCreationError(urlString))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil, let data = data else {
                completion(nil, .responseError(error?.localizedDescription))
                return
            }
            
            completion(UIImage(data: data), nil)
        }
        task.resume()
    }
}
