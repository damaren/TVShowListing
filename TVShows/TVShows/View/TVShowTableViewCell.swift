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
    
    var imageURL: String?
    var titleText: String?
    
    // MARK: - COMPONENTS
    
    var image: UIImageView = UIImageView()
    var title: UILabel = UILabel()
    
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
    
    // MARK: - STYLE
    
    func setup() {
        // image
        image.translatesAutoresizingMaskIntoConstraints = false
        if let url = URL(string: imageURL ?? ""), let data = try? Data(contentsOf: url) {
            image.image = UIImage(data: data)
        }
        
        // title
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = titleText
    }
    
    // MARK: - LAYOUT
    
    func layout() {
        contentView.addSubview(image)
        contentView.addSubview(title)
        
        // image
        image.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        image.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
//        image.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 16).isActive = true
        image.widthAnchor.constraint(equalToConstant: 210).isActive = true
        image.heightAnchor.constraint(equalToConstant: 295).isActive = true
        
        title.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16).isActive = true
        title.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 16).isActive = true
    }
    
    // MARK: - FUNCTIONS
    
    func configure(imageURL: String?, titleText: String) {
        self.imageURL = imageURL
        self.titleText = titleText
        
        setup()
        layout()
    }
}
