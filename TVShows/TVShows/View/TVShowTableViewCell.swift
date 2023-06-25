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
    
    // MARK: - PROPERTIES
    
    var show: TVShow?
    
    // MARK: - COMPONENTS
    
    var image: UIImageView = UIImageView()
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

extension TVShowTableViewCell {
    
    // MARK: - FUNCTIONS
    
    func setup() {
        // image
        image.translatesAutoresizingMaskIntoConstraints = false
        if let imageURL = show?.image?.medium, let url = URL(string: imageURL ), let data = try? Data(contentsOf: url) {
            image.image = UIImage(data: data)
        }
        
        // titleLabel
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        if let text = show?.name {
            titleLabel.text = text
        }
    }
    
    func layout() {
        contentView.addSubview(image)
        contentView.addSubview(titleLabel)
        
        // image
        image.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        image.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        image.widthAnchor.constraint(equalToConstant: 210).isActive = true
        image.heightAnchor.constraint(equalToConstant: 295).isActive = true
        
        // titleLabel
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 16).isActive = true
    }
    
    func configure(forShow show: TVShow) {
        self.show = show
        
        setup()
        layout()
    }
}
