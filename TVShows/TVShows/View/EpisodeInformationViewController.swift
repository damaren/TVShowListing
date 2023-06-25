//
//  EpisodeInformationViewController.swift
//  TVShows
//
//  Created by José Damaren on 25/06/23.
//

import UIKit

class EpisodeInformationViewController: UIViewController {
    
    // MARK: - PROPERTIES
    
    var episode: Episode?
    
    // MARK: - COMPONENTS
    
    var imageView: UIImageView = UIImageView()
    var seasonLabel: UILabel = UILabel()
    var numberLabel: UILabel = UILabel()
    var summaryLabel: UILabel = UILabel()
    
    // MARK: - LIFECYCLE

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - FUNCTIONS
    
    func setup() {
        self.title = episode?.name ?? ""
        
        // imageView
        imageView.translatesAutoresizingMaskIntoConstraints = false
        if let imageURL = episode?.image?.medium, let url = URL(string: imageURL ), let data = try? Data(contentsOf: url) {
            imageView.image = UIImage(data: data)
        }
        
        // seasonLabel:
        seasonLabel.translatesAutoresizingMaskIntoConstraints = false
        if let season = episode?.season {
            seasonLabel.text = "Season \(season)"
        }
        
        // numberLabel
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        if let number = episode?.number {
            numberLabel.text = "Episode \(number)"
        }
        
        // summaryLabel
        summaryLabel.translatesAutoresizingMaskIntoConstraints = false
        summaryLabel.numberOfLines = 0
        if let summary = episode?.summary {
            summaryLabel.text = summary
        }
    }
    
    func layoutViews() {
        view.addSubview(imageView)
        view.addSubview(seasonLabel)
        view.addSubview(numberLabel)
        view.addSubview(summaryLabel)
        
        // imageView
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        
        // seasonLabel
        seasonLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        seasonLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16).isActive = true
        seasonLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        // numberLabel
        numberLabel.topAnchor.constraint(equalTo: seasonLabel.bottomAnchor, constant: 16).isActive = true
        numberLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16).isActive = true
        numberLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        // summaryLabel
        summaryLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16).isActive = true
        summaryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        summaryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
    }
    
    func configure(forEpisode episode: Episode) {
        self.episode = episode
        setup()
        layoutViews()
    }
}
