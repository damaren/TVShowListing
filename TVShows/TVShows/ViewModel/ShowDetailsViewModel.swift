//
//  ShowDetailsViewModel.swift
//  TVShows
//
//  Created by José Damaren on 26/06/23.
//

import Foundation

class ShowDetailsViewModel {
    
    // MARK: - PROPERTIES
    
    var show: TVShow?
    
    // array of episodes separated by seasons (episodes[i] is the array of episodes in season i+1)
    var episodes: [[Episode]] = [] {
        didSet {
            updateView()
        }
    }
    
    var showName: String {
        return show?.name ?? ""
    }
    
    var showSummary: String {
        return show?.summary ?? ""
    }
    
    var numberOfSections: Int {
        return episodes.count
    }
    
    // the view will set this variable so that it will update itself when this function is called
    var updateView: () -> () = {}
    
    // MARK: - FUNCTIONS
    
    public func getNumberOfRows(inSection section: Int) -> Int {
        return episodes[section].count
    }
    
    public func getEpisode(forIndexPath indexPath: IndexPath) -> Episode {
        return episodes[indexPath.section][indexPath.row]
    }
    
    public func configure(forShow show: TVShow) {
        self.show = show
        requestEpisodes(withProvider: TVMazeProvider.shared)
    }
    
    func requestEpisodes(withProvider provider: Provider) {
        if let id = show?.id {
            provider.requestEpisodes(showID: id, completion: { episodes in
                self.updateEpisodes(withEpisodes: episodes)
            })
        }
    }
    
    func separateEpisodesBySeason(episodes: [Episode]) -> [[Episode]] {
        var season = 1
        var seasonAndEpisodes: [[Episode]] = []
        repeat {
            let seasonEpisodes = episodes.filter({ episode in return episode.season == season })
            seasonAndEpisodes.append(seasonEpisodes)
            season += 1
        } while episodes.contains(where: { episode in episode.season == season})
        return seasonAndEpisodes
    }
    
    func updateEpisodes(withEpisodes episodes: [Episode]) {
        self.episodes = separateEpisodesBySeason(episodes: episodes)
    }
}
