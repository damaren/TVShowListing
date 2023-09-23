//
//  ShowDetailsSummaryViewModel.swift
//  TVShows
//
//  Created by José Damaren on 26/06/23.
//

import Foundation
import UIKit

protocol ShowDetailsSummaryViewProtocol: AnyObject {
    func updateView(forImage image: UIImage?, completion: (() -> ())?) -> ()
}

class ShowDetailsSummaryViewModel {
    
    // MARK: - STATIC PROPERTIES
    
    static let noGenresMessage: String = "No genres info provided"
    static let noTimeMessage: String = "No air time info provided"
    static let noDaysMessage: String = "No air days info provided"
    static let noSummaryMessage: String = "No summary provided"
    
    // MARK: - PROPERTIES
    
    weak var view: ShowDetailsSummaryViewProtocol?
    
    var show: TVShow?
    var image: UIImage? {
        didSet {
            view?.updateView(forImage: image, completion: nil)
        }
    }
    
    var networkError: NetworkError?
    
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

extension ShowDetailsSummaryViewModel: ShowDetailsSummaryViewModelProtocol {
    public func configure(forShow show: TVShow?, withProvider provider: Provider = TVMazeProvider.shared) {
        self.show = show
        requestImage(forUrl: show?.image?.medium, withProvider: provider)
    }
    
    public func getGenres() -> String {
        if let genres = show?.genres, let firstElement = genres.first {
            let genresString = genres[1..<genres.count].reduce(firstElement, { partialResult, nextString in return "\(partialResult), \(nextString)"})
            return "Genres: \(genresString)"
        } else {
            return ShowDetailsSummaryViewModel.noGenresMessage
        }
    }
    
    public func getTime() -> String {
        if let time = show?.schedule?.time, !time.isEmpty {
            return "Time: \(time)"
        } else {
            return ShowDetailsSummaryViewModel.noTimeMessage
        }
    }
    
    public func getDays() -> String {
        if let days = show?.schedule?.days, let firstElement = days.first {
            let daysString = days[1..<days.count].reduce(firstElement, { partialResult, nextString in return "\(partialResult), \(nextString)"})
            return "Days: \(daysString)"
        } else {
            return ShowDetailsSummaryViewModel.noDaysMessage
        }
    }
    
    public func getSummary() -> String {
        if let summary = show?.summary {
            return summary
        } else {
            return ShowDetailsSummaryViewModel.noSummaryMessage
        }
    }
}
