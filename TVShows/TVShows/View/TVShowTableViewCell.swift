//
//  TVShowTableViewCell.swift
//  TVShows
//
//  Created by José Damaren on 24/06/23.
//

import Foundation
import UIKit

class TVShowTableViewCell: UITableViewCell {
    
    // MARK: - STATIC PROPERTIES
    
    static let reuseIdentifier: String = "TVShowTableViewCell"
    static let cellHeight: CGFloat = 240
    
    // MARK: - PROPERTIES
    
    var show: TVShow?
    let verticalMargin: CGFloat = 8
    let imageAspectRatio: Double = 210/295
    
    // MARK: - COMPONENTS
    
    var image: UIImageView = UIImageView()
    var titleLabel: UILabel = UILabel()
    var genresLabel: UILabel = UILabel()
    var containerView: UIView = UIView()
    var shadowView: UIView = UIView()
    
    // MARK: - INIT
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
         // not going to be used since we're not using storyboards
         fatalError("init(coder:) has not been implemented")
    }
}

extension TVShowTableViewCell {
    
    // MARK: - FUNCTIONS
    
    func setup() {
        // image
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "photo.artframe")
        image.tintColor = .label
        image.contentMode = .scaleAspectFit
        if let imageURL = show?.image?.medium, let url = URL(string: imageURL ), let data = try? Data(contentsOf: url) {
            image.image = UIImage(data: data)
        }
        image.roundCorners()
        
        // titleLabel
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        if let text = show?.name {
            titleLabel.text = text
        }
        
        // genresLabel
        genresLabel.translatesAutoresizingMaskIntoConstraints = false
        genresLabel.numberOfLines = 0
        if let genres = show?.genres, !genres.isEmpty {
            let genresString = genres[1..<genres.count].reduce(genres.first ?? "", { partialResult, nextString in return "\(partialResult), \(nextString)"})
            genresLabel.text = "Genres: \(genresString)"
        }
        
        // containerView
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .secondarySystemBackground
        containerView.roundCorners()
        
        // shadowView
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.backgroundColor = .secondarySystemBackground
        shadowView.applyShadow()
    }
    
    func layout() {
        containerView.addSubview(image)
        containerView.addSubview(titleLabel)
        containerView.addSubview(genresLabel)
        contentView.addSubview(shadowView)
        contentView.addSubview(containerView)
        
        // image
        image.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        image.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        let imageHeight = TVShowTableViewCell.cellHeight - 2 * verticalMargin
        let imageWidh = imageHeight*imageAspectRatio
        image.widthAnchor.constraint(equalToConstant: imageWidh).isActive = true
        image.heightAnchor.constraint(equalToConstant: imageHeight).isActive = true
        
        // titleLabel
        titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 16).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 16).isActive = true
        titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16).isActive = true
        
        // genresLabel
        genresLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 16).isActive = true
        genresLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 16).isActive = true
        genresLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16).isActive = true
        
        // shadowView
        shadowView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        shadowView.topAnchor.constraint(equalTo: topAnchor, constant: verticalMargin).isActive = true
        shadowView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        shadowView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -verticalMargin).isActive = true
        
        // containerView
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        containerView.topAnchor.constraint(equalTo: topAnchor, constant: verticalMargin).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -verticalMargin).isActive = true
    }
    
    func configure(forShow show: TVShow) {
        self.show = show
        
        setup()
        layout()
    }
}

extension UIView {
    func roundCorners() {
        layer.cornerRadius = 8.0
        layer.masksToBounds = true
    }
    
    func applyShadow() {
        layer.cornerRadius = 8.0
        layer.shadowRadius = 4.0
        layer.shadowOpacity = 0.4
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 1, height: 1)
    }
}
