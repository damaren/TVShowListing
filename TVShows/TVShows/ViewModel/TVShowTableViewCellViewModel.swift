//
//  TVShowTableViewCellViewModel.swift
//  TVShows
//
//  Created by José Damaren on 26/06/23.
//

import Foundation
import UIKit

protocol TVShowTableViewCellViewProtocol: AnyObject {
    func updateView(forImage image: UIImage?, completion: (() -> ())?) -> ()
    func updateViewForError() -> ()
}

class TVShowTableViewCellViewModel {
    
    // MARK: - STATIC PROPERTIES
    
    static let noShowNameMessage: String = "No show title provided"
    static let noGenresMessage: String = "No genres info provided"
    
    // MARK: - PROPERTIES
    
    var show: TVShow?
    
    weak var showSearchView: TVShowTableViewCellViewProtocol?
    
    var networkError: NetworkError? {
        didSet {
            showSearchView?.updateViewForError()
        }
    }
    
    var image: UIImage? {
        didSet {
            showSearchView?.updateView(forImage: image, completion: nil)
        }
    }
    
    // MARK: - INIT
    init(showSearchView: TVShowTableViewCellViewProtocol?) {
        self.showSearchView = showSearchView
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

// MARK: - TVShowTableViewCellViewModelProtocol
extension TVShowTableViewCellViewModel: TVShowTableViewCellViewModelProtocol {
    public func configure(forShow show: TVShow?, withProvider provider: Provider) {
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
