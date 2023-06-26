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
    var showTitle: String?
    let horizontalMargin: CGFloat = 16
    let imageAspectRatio: Double = 250/140
    weak var delegate: EpisodeInformationViewControllerDelegate?
    
    
    // MARK: - COMPONENTS
    
    var imageView: UIImageView = UIImageView()
    var seasonAndNumberLabel: UILabel = UILabel()
    var episodeNameLabel: UILabel = UILabel()
    var summaryLabel: UILabel = UILabel()
    
    // MARK: - LIFECYCLE

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - FUNCTIONS
    
    func setup() {
        self.title = showTitle ?? ""
        view.backgroundColor = .systemBackground
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonPressed))
        navigationItem.leftBarButtonItem?.tintColor = .label
        
        // imageView
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "photo.artframe")
        imageView.tintColor = .label
        imageView.contentMode = .scaleAspectFit
        TVMazeProvider.shared.requestImage(forUrl: episode?.image?.medium, completion: { imageData in
            DispatchQueue.main.async { // update UI
                if let imageData = imageData {
                    self.imageView.image = UIImage(data: imageData)
                }
            }
        })
        imageView.roundCorners()
        
        // seasonAndNumberLabel
        seasonAndNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        if let season = episode?.season, let number = episode?.number {
            seasonAndNumberLabel.text = "S\(season)E\(number):"
        }
        
        // episodeNameLabel
        episodeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        episodeNameLabel.textAlignment = .left
        episodeNameLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        episodeNameLabel.numberOfLines = 0
        if let name = episode?.name {
            episodeNameLabel.text = name
        }
        
        // summaryLabel
        summaryLabel.translatesAutoresizingMaskIntoConstraints = false
        summaryLabel.numberOfLines = 0
        if let summary = episode?.summary {
            summaryLabel.text = summary.htmlToString
        }
    }
    
    func layoutViews() {
        view.addSubview(imageView)
        view.addSubview(seasonAndNumberLabel)
        view.addSubview(episodeNameLabel)
        view.addSubview(summaryLabel)
        
        let episodeNameTopAnchor = imageView.image == nil ? view.safeAreaLayoutGuide.topAnchor : imageView.bottomAnchor
        
        // imageView
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        let imagewidth = view.frame.width - 2 * horizontalMargin
        let imageHeigh = imagewidth / imageAspectRatio
        imageView.widthAnchor.constraint(equalToConstant: imagewidth).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: imageHeigh).isActive = true
        
        // seasonAndNumberLabel
        seasonAndNumberLabel.lastBaselineAnchor.constraint(equalTo: episodeNameLabel.firstBaselineAnchor).isActive = true
        seasonAndNumberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalMargin).isActive = true
        seasonAndNumberLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        // episodeNameLabel
        episodeNameLabel.topAnchor.constraint(equalTo: episodeNameTopAnchor, constant: 16).isActive = true
        episodeNameLabel.leadingAnchor.constraint(equalTo: seasonAndNumberLabel.trailingAnchor, constant: 16).isActive = true
        episodeNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalMargin).isActive = true
        episodeNameLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        // summaryLabel
        summaryLabel.topAnchor.constraint(equalTo: episodeNameLabel.bottomAnchor, constant: 16).isActive = true
        summaryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalMargin).isActive = true
        summaryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalMargin).isActive = true
    }
    
    func configure(forEpisode episode: Episode, andShowTitle showTitle: String) {
        self.episode = episode
        self.showTitle = showTitle
        setup()
        layoutViews()
    }
    
    // MARK: - ACTIONS
    
    @objc func backButtonPressed() {
        delegate?.backButtonPressed(inViewcontroller: self)
    }
}

// MARK: - ShowDetailsViewControllerDelegate
protocol EpisodeInformationViewControllerDelegate: AnyObject {
    func backButtonPressed(inViewcontroller: EpisodeInformationViewController)
}
