//
//  TVShowModel.swift
//  TVShows
//
//  Created by José Damaren on 23/06/23.
//

import Foundation

struct TVShowResponse: Codable {
    var score: Float?
    var show: TVShow
}

struct TVShow: Codable {
    var id: Int?
    var url: String?
    var name: String?
    var type: String?
}
