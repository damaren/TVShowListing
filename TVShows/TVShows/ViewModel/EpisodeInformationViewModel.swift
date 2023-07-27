//
//  EpisodeInformationViewModel.swift
//  TVShows
//
//  Created by José Damaren on 26/06/23.
//

import Foundation
import UIKit

class EpisodeInformationViewModel {
    
    // MARK: - STATIC PROPERTIES
    
    static let noSeasonAndNumberMessage: String = "No season and episode number provided"
    static let noEpisodeNameMessage: String = "No episode name provided"
    static let noSummaryMessage: String = "No summary provided"
    static let noShowTitleMessage: String = "No show title provided"
    
    // MARK: - PROPERTIES
    
    var episode: Episode?
    var showTitle: String?
    
    // the view must set this variable so that it will update itself when this function is called
    var updateView: (UIImage?) -> () = {image in}
    
    // the view must set this variable so that it will update itself when this function is called
    // TODO: set this in the view
    var updateViewForError: () -> () = {}
    
    var image: UIImage? {
        didSet {
            updateView(image)
        }
    }
    
    var networkError: NetworkError? {
        didSet {
            updateViewForError()
        }
    }
    
    // MARK: - FUNCTIONS
    
    func requestImage(forUrl url: String?, withProvider provider: Provider) {
        provider.requestImage(forUrl: url, completion: { image, error in
            guard error == nil else {
                self.networkError = error
                self.image = nil
                return
            }
            self.image = image
        })
    }
    
    public func configure(forEpisode episode: Episode?, andShowTitle showTitle: String, withProvider provider: Provider = TVMazeProvider.shared) {
        self.episode = episode
        self.showTitle = showTitle
        requestImage(forUrl: episode?.image?.medium, withProvider: provider)
    }
    
    public func getSeasonAndNumberText() -> String {
        if let season = episode?.season, let number = episode?.number {
            return "S\(season)E\(number):"
        } else {
            return EpisodeInformationViewModel.noSeasonAndNumberMessage
        }
    }
    
    public func getEpisodeNameText() -> String {
        if let name = episode?.name {
            return name
        } else {
            return EpisodeInformationViewModel.noEpisodeNameMessage
        }
    }
    
    public func getSummaryText() -> String {
        if let summary = episode?.summary {
            return summary
        } else {
            return EpisodeInformationViewModel.noSummaryMessage
        }
    }
}
