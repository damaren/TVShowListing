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
    var error: NetworkError?
    // the view will set this variable so that it will update itself when this function is called
    var updateView: (UIImage?) -> () = {image in}
    
    var image: UIImage? {
        didSet {
            updateView(image)
        }
    }
    
    // MARK: - FUNCTIONS
    
    func requestImage(forUrl url: String?, withProvider provider: Provider) {
        guard let imageUrl = url else {
            // TODO: deal with this
            print("The image url was nil")
            return
        }
        
        provider.requestImage(forUrl: imageUrl, completion: { image, error in
            guard error == nil else {
                self.error = error
                self.image = nil
                return
            }
            self.image = image
        })
    }
    
    public func configure(forEpisode episode: Episode?, andShowTitle showTitle: String) {
        self.episode = episode
        self.showTitle = showTitle
        requestImage(forUrl: episode?.image?.medium, withProvider: TVMazeProvider.shared)
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
