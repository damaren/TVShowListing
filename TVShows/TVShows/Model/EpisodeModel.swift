//
//  EpisodeModel.swift
//  TVShows
//
//  Created by José Damaren on 25/06/23.
//

import Foundation

struct Episode: Decodable, Equatable {
    static func == (lhs: Episode, rhs: Episode) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id: Int?
    var url: String?
    var name: String?
    var season: Int?
    var number: Int?
    var type: String?
    var airdate: String?
    var airtime: String?
    var airstamp: String?
    var runtime: Int?
    var rating: Rating?
    var image: Image?
    var summary: String?
}
