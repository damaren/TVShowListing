//
//  Provider.swift
//  TVShows
//
//  Created by José Damaren on 26/06/23.
//

import Foundation
import UIKit

protocol Provider: AnyObject {
    func requestTVShows(searchString: String, completion: @escaping ([TVShowResponse]?, NetworkError?) -> ())
    
    func requestEpisodes(showID: Int, completion: @escaping ([Episode]?, NetworkError?) -> ())
    
    func requestImage(forUrl urlString: String?, completion: @escaping (UIImage?, NetworkError?) -> ())
}
