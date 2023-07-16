//
//  TVShowTableViewCellViewModel.swift
//  TVShows
//
//  Created by José Damaren on 26/06/23.
//

import Foundation
import UIKit

class TVShowTableViewCellViewModel {
    
    // MARK: - STATIC PROPERTIES
    
    static let noShowNameMessage: String = "No show title provided"
    static let noGenresMessage: String = "No genres info provided"
    
    // MARK: - PROPERTIES
    
    var show: TVShow?
    
    // the view will set this variable so that it will update itself when this function is called
    var updateView: (UIImage?) -> () = {image in}
    
    // the view must set this variable so that it will update itself when this function is called
    // TODO: set this in the view
    var updateViewForError: () -> () = {}
    
    var networkError: NetworkError? {
        didSet {
            updateViewForError()
        }
    }
    
    var image: UIImage? {
        didSet {
            updateView(image)
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
    
    public func configure(forShow show: TVShow?, withProvider provider: Provider = TVMazeProvider.shared) {
        self.show = show
        requestImage(forUrl: show?.image?.medium, withProvider: provider)
    }
    
    public func getShowName() -> String {
        if let showName = show?.name {
            return showName
        } else {
            return TVShowTableViewCellViewModel.noShowNameMessage
        }
    }
    
    public func getGenres() -> String {
        if let genres = show?.genres, let firstElement = genres.first {
            let genresString = genres[1..<genres.count].reduce(firstElement, { partialResult, nextString in return "\(partialResult), \(nextString)"})
            return "Genres: \(genresString)"
        } else {
            return TVShowTableViewCellViewModel.noGenresMessage
        }
    }
}
