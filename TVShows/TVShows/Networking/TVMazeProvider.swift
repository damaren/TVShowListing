//
//  TVMazeProvider.swift
//  TVShows
//
//  Created by José Damaren on 24/06/23.
//

import Foundation

class TVMazeProvider {
    
    // MARK: - SINGLETON
    
    static let shared: TVMazeProvider = TVMazeProvider()
    
    // MARK: - PROPERTIES
    
    let baseURL: String = "https://api.tvmaze.com"
    
    // MARK: - FUNCTIONS
    
    func requestTVShows(searchString: String, completion: @escaping ([TVShowResponse]) -> ()) {
        guard let urlQueryAllowedString = searchString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("Could not generate an URL query allowed string from: \(searchString)")
            return
        }
        
        let urlString = "\(baseURL)/search/shows?q=\(urlQueryAllowedString)"
        
        guard let url = URL(string: urlString) else {
            print("Could not create an URL object from string: \(urlString)")
            return
        }

        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            let tvShowResponses: [TVShowResponse] = try! JSONDecoder().decode([TVShowResponse].self, from: data)
            completion(tvShowResponses)
        }

        task.resume()
    }
    
    func requestEpisodes(showID: Int, completion: @escaping ([Episode]) -> ()) {
        let urlString = "\(baseURL)/shows/\(showID)/episodes"
        
        guard let url = URL(string: urlString) else {
            print("Could not create an URL object from string: \(urlString)")
            return
        }

        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            let episodes: [Episode] = try! JSONDecoder().decode([Episode].self, from: data)
            completion(episodes)
        }

        task.resume()
    }
}
