//
//  MockProvider.swift
//  TVShows
//
//  Created by José Damaren on 26/06/23.
//

import Foundation
import UIKit

// class for unit testing with the requests
class MockProvider: Provider {
    
    // MARK: - SINGLETON
    
    static let shared: MockProvider = MockProvider()
    
    // MARK: - FUNCTIONS
    
    func requestTVShows(searchString: String, completion: @escaping ([TVShowResponse]) -> ()) {
    }
    
    func requestEpisodes(showID: Int, completion: @escaping ([Episode]) -> ()) {
    }
    
    func requestImage(forUrl urlString: String?, completion: @escaping (UIImage?) -> ()) {
    }
}
