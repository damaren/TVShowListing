//
//  ShowDetailsViewModel.swift
//  TVShows
//
//  Created by José Damaren on 26/06/23.
//

import Foundation

protocol ShowDetailsViewProtocol: AnyObject {
    func updateView(completion: (() -> ())?)
}

class ShowDetailsViewModel {

    // MARK: - STATIC PROPERTIES

    static let noShowNameMessage: String = "No show name provided"
    static let noShowSummaryMessage: String = "No show summary provided"

    // MARK: - PROPERTIES

    var show: TVShow?

    weak var view: ShowDetailsViewProtocol?

    // array of episodes separated by seasons (episodes[i] is the array of episodes in season i+1)
    var episodes: [[Episode]] = [] {
        didSet {
            view?.updateView(completion: nil)
        }
    }

    var error: NetworkError?

    // the view will set this variable so that it will update itself when this function is called
    var updateView: () -> () = {}

    // MARK: - INIT
    init(view: ShowDetailsViewProtocol) {
        self.view = view
    }

    // MARK: - FUNCTIONS

    func requestEpisodes(forShowId showId: Int, withProvider provider: Provider) {
        provider.requestEpisodes(showID: showId, completion: { episodes, error in
            guard error == nil, let episodes = episodes else {
                self.error = error
                self.episodes = []
                return
            }
            self.updateEpisodes(withEpisodes: episodes)
        })
    }

    func separateEpisodesBySeason(episodes: [Episode]) -> [[Episode]] {
        guard !episodes.isEmpty else { return [] }
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

// MARK: - ShowDetailsViewModelProtocol
extension ShowDetailsViewModel: ShowDetailsViewModelProtocol {
    var showName: String {
        return show?.name ?? ShowDetailsViewModel.noShowNameMessage
    }

    var numberOfSections: Int {
        return episodes.count
    }

    var showSummary: String {
        return show?.summary ?? ShowDetailsViewModel.noShowSummaryMessage
    }

    public func configure(forShow show: TVShow, withProvider provider: Provider = TVMazeProvider()) {
        self.show = show
        if let id = show.id {
            requestEpisodes(forShowId: id, withProvider: provider)
        }
    }

    public func getNumberOfRows(inSection section: Int) -> Int {
        return episodes[section].count
    }

    public func getEpisode(forIndexPath indexPath: IndexPath) -> Episode {
        return episodes[indexPath.section][indexPath.row]
    }
}
