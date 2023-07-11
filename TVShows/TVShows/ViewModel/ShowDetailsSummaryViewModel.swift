//
//  ShowDetailsSummaryViewModel.swift
//  TVShows
//
//  Created by José Damaren on 26/06/23.
//

import Foundation
import UIKit

class ShowDetailsSummaryViewModel {
    
    // MARK: - PROPERTIES
    
    var show: TVShow?
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
    
    // the view must set this variable so that it will update itself when this function is called
    // TODO: set this in the view
    var updateViewForError: () -> () = {}
    
    // the view will set this variable so that it will update itself when this function is called
    var updateView: (UIImage?) -> () = {image in}
    
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
    
    public func configure(forShow show: TVShow?) {
        self.show = show
        requestImage(forUrl: show?.image?.medium, withProvider: TVMazeProvider.shared)
    }
    
    public func getGenresLabelText() -> String {
        if let genres = show?.genres, !genres.isEmpty {
            let genresString = genres[1..<genres.count].reduce(genres.first ?? "", { partialResult, nextString in return "\(partialResult), \(nextString)"})
            return "Genres: \(genresString)"
        } else {
            return ""
        }
    }
    
    public func getTimesLabelText() -> String {
        if let time = show?.schedule?.time, !time.isEmpty {
            return "Time: \(time)"
        } else {
            return ""
        }
    }
    
    public func getDaysLabelText() -> String {
        if let days = show?.schedule?.days, !days.isEmpty {
            let daysString = days[1..<days.count].reduce(days.first ?? "", { partialResult, nextString in return "\(partialResult), \(nextString)"})
            return "Days: \(daysString)"
        } else {
            return ""
        }
    }
    
    public func getSummaryText() -> String {
        if let summary = show?.summary {
            return summary.htmlToString
        } else {
            return ""
        }
    }
}
