//
//  TVShowTableViewCell.swift
//  TVShows
//
//  Created by José Damaren on 24/06/23.
//

import Foundation
import UIKit

protocol TVShowTableViewCellViewModelProtocol: AnyObject {
    func configure(forShow show: TVShow?, withProvider provider: Provider)
    func getShowName() -> String
    func getGenres() -> String
}

class TVShowTableViewCell: UITableViewCell {
    
    // MARK: - STATIC PROPERTIES
    
    static let reuseIdentifier: String = "TVShowTableViewCell"
    static let cellHeight: CGFloat = 240
    static let verticalMargin: CGFloat = 8
    static let horizontalMargin: CGFloat = 8
    static let imageAspectRatio: Double = 210/295
    
    // MARK: - PROPERTIES
    
    var viewModel: TVShowTableViewCellViewModelProtocol?
    
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
        guard let viewModel = viewModel else { return }
        
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
        image.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: TVShowTableViewCell.horizontalMargin).isActive = true
        image.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        let imageHeight = TVShowTableViewCell.cellHeight - 4 * TVShowTableViewCell.verticalMargin // 4 = containerView top and bottom + image top and bottom
        let imageWidh = imageHeight*TVShowTableViewCell.imageAspectRatio
        image.widthAnchor.constraint(equalToConstant: imageWidh).isActive = true
        image.heightAnchor.constraint(equalToConstant: imageHeight).isActive = true
        
        // titleLabel
        titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -2 * TVShowTableViewCell.horizontalMargin).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 2 * TVShowTableViewCell.horizontalMargin).isActive = true
        titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 2 * TVShowTableViewCell.verticalMargin).isActive = true
        
        // genresLabel
        genresLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -2 * TVShowTableViewCell.horizontalMargin).isActive = true
        genresLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 2 * TVShowTableViewCell.horizontalMargin).isActive = true
        genresLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2 * TVShowTableViewCell.verticalMargin).isActive = true
        
        // containerView
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: TVShowTableViewCell.horizontalMargin).isActive = true
        containerView.topAnchor.constraint(equalTo: topAnchor, constant: TVShowTableViewCell.verticalMargin).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -TVShowTableViewCell.horizontalMargin).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -TVShowTableViewCell.verticalMargin).isActive = true
    }
    
    func configure(forShow show: TVShow, andViewModel viewModel: TVShowTableViewCellViewModelProtocol, withProvider provider: Provider) {
        self.viewModel = viewModel
        self.viewModel?.configure(forShow: show, withProvider: provider)
        
        setup()
        layout()
    }
}

// MARK: - TVShowTableViewCellViewProtocol
extension TVShowTableViewCell: TVShowTableViewCellViewProtocol {
    func updateView(forImage image: UIImage?, completion: (() -> ())?) {
        DispatchQueue.main.async { // update UI
            self.image.image = image
            completion?()
        }
    }
    
    func updateViewForError() {}
    
}
