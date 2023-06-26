//
//  TVShowModel.swift
//  TVShows
//
//  Created by José Damaren on 23/06/23.
//

import Foundation

struct TVShowResponse: Decodable {
    var score: Float?
    var show: TVShow
}

struct TVShow: Decodable {
    var id: Int?
    var url: String?
    var name: String?
    var type: String?
    var language: String?
    var genres: [String]?
    var status: String?
    var runtime: Int?
    var averageRuntime: Int?
    var premiered: String?
    var ended: String?
    var officialSite: String?
    var schedule: Schedule?
    var rating: Rating?
    var weight: Int?
    var network: Network?
    var webChannel: WebChannel?
    var dvdCountry: String?
    var externals: Externals?
    var image: Image?
    var summary: String?
    var updated: Int?
}

struct Schedule: Decodable {
    var time: String?
    var days: [String]?
}

struct Rating: Decodable {
    var average: Double?
}

struct Network: Decodable {
    var id: Int?
    var name: String?
    var country: Country?
    var officialSite: String?
}

struct Country: Decodable {
    var name: String?
    var code: String?
    var timezone: String?
}

struct WebChannel: Decodable {
    var id: Int?
    var name: String?
    var country: Country?
    var officialSite: String?
}

struct Externals: Decodable {
    var tvrage: Int?
    var thetvdb: Int?
    var imdb: String?
}

struct Image: Decodable {
    var medium: String?
    var original: String?
}
