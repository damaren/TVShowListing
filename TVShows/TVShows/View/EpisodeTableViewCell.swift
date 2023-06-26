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
    static let cellHeight: CGFloat = 60
    
    // MARK: - PROPERTIES
    
    var episode: Episode?
    let verticalMargin: CGFloat = 8
    
    // MARK: - COMPONENTS
    
    var numberLabel: UILabel = UILabel()
    var titleLabel: UILabel = UILabel()
    var containerView: UIView = UIView()
    
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
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.8
        titleLabel.textAlignment = .right
        if let title = episode?.name {
            titleLabel.text = title
        }
        
        // containerView
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .secondarySystemBackground
        containerView.applyShadow()
    }
    
    func layout() {
        containerView.addSubview(numberLabel)
        containerView.addSubview(titleLabel)
        contentView.addSubview(containerView)
        
        // numberLabel
        numberLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16).isActive = true
        numberLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        numberLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        // titleLabel
        titleLabel.leadingAnchor.constraint(equalTo: numberLabel.trailingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        // containerView
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        containerView.topAnchor.constraint(equalTo: topAnchor, constant: verticalMargin).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -verticalMargin).isActive = true
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
