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
    
    let viewModel: TVShowTableViewCellViewModel = TVShowTableViewCellViewModel()
    let verticalMargin: CGFloat = 8
    let imageAspectRatio: Double = 210/295
    
    // MARK: - COMPONENTS
    
    var image: UIImageView = UIImageView()
    var titleLabel: UILabel = UILabel()
    var genresLabel: UILabel = UILabel()
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

extension TVShowTableViewCell {
    
    // MARK: - FUNCTIONS
    
    func setup() {
        // update
        viewModel.updateView = { [weak self] image in
            self?.updateView(forImage: image)
        }
        
        // image
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "photo.artframe")
        image.tintColor = .label
        image.contentMode = .scaleAspectFit
        image.roundCorners()
        
        // titleLabel
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        titleLabel.text = viewModel.getShowName()
        
        // genresLabel
        genresLabel.translatesAutoresizingMaskIntoConstraints = false
        genresLabel.numberOfLines = 0
        genresLabel.text = viewModel.getGenres()
        
        // containerView
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .secondarySystemBackground
        containerView.applyShadow()
    }
    
    func layout() {
        containerView.addSubview(image)
        containerView.addSubview(titleLabel)
        containerView.addSubview(genresLabel)
        contentView.addSubview(containerView)
        
        // image
        image.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8).isActive = true
        image.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        let imageHeight = TVShowTableViewCell.cellHeight - 4 * verticalMargin // 4 = containerView top and bottom + image top and bottom
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
        
        // containerView
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        containerView.topAnchor.constraint(equalTo: topAnchor, constant: verticalMargin).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -verticalMargin).isActive = true
    }
    
    func configure(forShow show: TVShow) {
        viewModel.configure(forShow: show)
        
        setup()
        layout()
    }
    
    func updateView(forImage image: UIImage?) {
        DispatchQueue.main.async { // update UI
            self.image.image = image
        }
    }
}
