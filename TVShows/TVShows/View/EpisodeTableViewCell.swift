//
//  EpisodeTableViewCell.swift
//  TVShows
//
//  Created by José Damaren on 25/06/23.
//

import Foundation
import UIKit

class EpisodeTableViewCell: UITableViewCell {
    
    // MARK: - STATIC PROPERTIES
    
    static let reuseIdentifier: String = "EpisodeTableViewCell"
    
    // MARK: - PROPERTIES
    
    var episode: Episode?
    
    // MARK: - COMPONENTS
    
    var numberLabel: UILabel = UILabel()
    var titleLabel: UILabel = UILabel()
    
    // MARK: - INIT
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
         // not going to be used since we're not using storyboards
         fatalError("init(coder:) has not been implemented")
    }
}

extension EpisodeTableViewCell {
    
    // MARK: - FUNCTIONS
    
    func setup() {
        
        // numberLabel
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        numberLabel.text = generateSeasonAndNumberLabel()
        
        // title
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        if let title = episode?.name {
            titleLabel.text = title
        }
    }
    
    func layout() {
        contentView.addSubview(numberLabel)
        contentView.addSubview(titleLabel)
        
        // numberLabel
        numberLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        numberLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        // titleLabel
        titleLabel.leadingAnchor.constraint(equalTo: numberLabel.trailingAnchor, constant: 16).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    func configure(forEpisode episode: Episode) {
        self.episode = episode
        
        setup()
        layout()
    }
    
    func generateSeasonAndNumberLabel() -> String {
        guard let number = episode?.number else { return "" }
        return "Ep. \(number):"
    }
}
