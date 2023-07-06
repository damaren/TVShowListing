//
//  TVShowTableViewCellViewModel.swift
//  TVShows
//
//  Created by José Damaren on 26/06/23.
//

import Foundation
import UIKit

class TVShowTableViewCellViewModel {
    
    // MARK: - PROPERTIES
    
    var show: TVShow?
    
    // the view will set this variable so that it will update itself when this function is called
    var updateView: (UIImage?) -> () = {image in}
    
    var error: NetworkError?
    
    var image: UIImage? {
        didSet {
            updateView(image)
        }
    }
    
    // MARK: - FUNCTIONS
    
    func requestImage(forUrl url: String?, withProvider provider: Provider) {
        provider.requestImage(forUrl: url, completion: { image, error in
            guard error == nil else {
                self.error = error
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
    
    public func getShowName() -> String {
        if let text = show?.name {
            return text
        } else {
            return ""
        }
    }
    
    public func getGenres() -> String {
        if let genres = show?.genres, !genres.isEmpty {
            let genresString = genres[1..<genres.count].reduce(genres.first ?? "", { partialResult, nextString in return "\(partialResult), \(nextString)"})
            return "Genres: \(genresString)"
        } else {
            return ""
        }
    }
}
