//
//  EpisodeInformationViewModel.swift
//  TVShows
//
//  Created by José Damaren on 26/06/23.
//

import Foundation
import UIKit

class EpisodeInformationViewModel {
    
    // MARK: - PROPERTIES
    
    var episode: Episode?
    var showTitle: String = ""
    
    var image: UIImage? {
        didSet {
            updateView(image)
        }
    }
    
    // the view will set this variable so that it will update itself when this function is called
    var updateView: (UIImage?) -> () = {image in}
    
    // MARK: - FUNCTIONS
    
    func requestImage(withProvider provider: Provider) {
        provider.requestImage(forUrl: episode?.image?.medium, completion: { image in
            self.image = image
        })
    }
    
    public func configure(forEpisode episode: Episode?, andShowTitle showTitle: String) {
        self.episode = episode
        self.showTitle = showTitle
        requestImage(withProvider: TVMazeProvider.shared)
    }
    
    public func getSeasonAndNumberText() -> String {
        if let season = episode?.season, let number = episode?.number {
            return "S\(season)E\(number):"
        } else {
            return ""
        }
    }
    
    public func getEpisodeNameText() -> String {
        if let name = episode?.name {
            return name
        } else {
            return ""
        }
    }
    
    public func getSummaryText() -> String {
        if let summary = episode?.summary {
            return summary.htmlToString
        } else {
            return ""
        }
    }
}
