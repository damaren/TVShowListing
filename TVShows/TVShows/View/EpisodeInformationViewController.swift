//
//  EpisodeInformationViewController.swift
//  TVShows
//
//  Created by José Damaren on 25/06/23.
//

import UIKit

class EpisodeInformationViewController: UIViewController {
    
    // MARK: - PROPERTIES
    
    let horizontalMargin: CGFloat = 16
    let imageAspectRatio: Double = 250/140
    weak var delegate: EpisodeInformationViewControllerDelegate?
    var viewModel: EpisodeInformationViewModel = EpisodeInformationViewModel()
    
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
        self.title = viewModel.showTitle
        view.backgroundColor = .systemBackground
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonPressed))
        navigationItem.leftBarButtonItem?.tintColor = .label
        
        // update
        viewModel.updateView = { [weak self] image in
            self?.updateView(forImage: image)
        }
        
        // imageView
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "photo.artframe")
        imageView.tintColor = .label
        imageView.contentMode = .scaleAspectFit
        imageView.roundCorners()
        
        // seasonAndNumberLabel
        seasonAndNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        seasonAndNumberLabel.text = viewModel.getSeasonAndNumberText()
        
        // episodeNameLabel
        episodeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        episodeNameLabel.textAlignment = .left
        episodeNameLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        episodeNameLabel.numberOfLines = 0
        episodeNameLabel.text = viewModel.getEpisodeNameText()
        
        // summaryLabel
        summaryLabel.translatesAutoresizingMaskIntoConstraints = false
        summaryLabel.numberOfLines = 0
        summaryLabel.attributedText = viewModel.getSummaryText().htmlToAttributedString(withSize: Int(summaryLabel.font.pointSize))
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
        viewModel.configure(forEpisode: episode, andShowTitle: showTitle)
        setup()
        layoutViews()
    }
    
    func updateView(forImage image: UIImage?) {
        DispatchQueue.main.async { // update UI
            self.imageView.image = image
        }
    }
    
    // MARK: - ACTIONS
    
    @objc func backButtonPressed() {
        delegate?.backButtonPressed(inViewcontroller: self, withAnimation: true)
    }
}

// MARK: - ShowDetailsViewControllerDelegate
protocol EpisodeInformationViewControllerDelegate: AnyObject {
    func backButtonPressed(inViewcontroller: EpisodeInformationViewController, withAnimation: Bool)
}
