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
    
    // MARK: - FUNCTIONS
    
    func requestTVShows(searchTitle: String, completion: @escaping ([TVShowResponse]) -> ()) {
        let url = URL(string: "https://api.tvmaze.com/search/shows?q=\(searchTitle)")!

        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            let tvShowResponses: [TVShowResponse] = try! JSONDecoder().decode([TVShowResponse].self, from: data)
            completion(tvShowResponses)
        }

        task.resume()
    }
    
}
