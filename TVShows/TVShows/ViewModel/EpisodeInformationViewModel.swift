//
//  EpisodeInformationViewModel.swift
//  TVShows
//
//  Created by José Damaren on 26/06/23.
//

import Foundation
import UIKit

protocol EpisodeInformationViewProtocol: AnyObject {
    func updateView(forImage image: UIImage?, completion: (() -> ())?) -> ()
    func updateViewForError() -> ()
}

class EpisodeInformationViewModel {
    
    // MARK: - STATIC PROPERTIES
    
    static let noSeasonAndNumberMessage: String = "No season and episode number provided"
    static let noEpisodeNameMessage: String = "No episode name provided"
    static let noSummaryMessage: String = "No summary provided"
    static let noShowTitleMessage: String = "No show title provided"
    
    // MARK: - PROPERTIES
    
    weak var view: EpisodeInformationViewProtocol?
    
    var _showTitle: String?
    
    var episode: Episode?
    
    var image: UIImage? {
        didSet {
            view?.updateView(forImage: image, completion: nil)
        }
    }
    
    var networkError: NetworkError? {
        didSet {
            view?.updateViewForError()
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
}

// MARK: - EpisodeInformationViewModelProtocol
extension EpisodeInformationViewModel: EpisodeInformationViewModelProtocol {
    public func configure(view: EpisodeInformationViewProtocol, forEpisode episode: Episode?, andShowTitle showTitle: String, withProvider provider: Provider) {
        self.view = view
        self.episode = episode
        self._showTitle = showTitle
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
    
    var showTitle: String? {
        return _showTitle
    }
}
