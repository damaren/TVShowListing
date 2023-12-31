//
//  EpisodeInformationViewController.swift
//  TVShows
//
//  Created by José Damaren on 25/06/23.
//

import UIKit

protocol EpisodeInformationViewModelProtocol: AnyObject {
    var showTitle: String? { get }
    
    func getSeasonAndNumberText() -> String
    func getEpisodeNameText() -> String
    func getSummaryText() -> String
}

class EpisodeInformationViewController: UIViewController {
    
    // MARK: - STATIC PROPERTIES
    static let verticalMargin: CGFloat = 16
    static let horizontalMargin: CGFloat = 16
    
    // MARK: - PROPERTIES
    
    let imageAspectRatio: Double = 250/140
    weak var delegate: EpisodeInformationViewControllerDelegate?
    var viewModel: EpisodeInformationViewModelProtocol?
    
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
        guard let viewModel = self.viewModel else { return }
        
        self.title = viewModel.showTitle
        view.backgroundColor = .systemBackground
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonPressed))
        navigationItem.leftBarButtonItem?.tintColor = .label
        
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
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: EpisodeInformationViewController.verticalMargin).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        let imagewidth = view.frame.width - 2 * EpisodeInformationViewController.horizontalMargin
        let imageHeigh = imagewidth / imageAspectRatio
        imageView.widthAnchor.constraint(equalToConstant: imagewidth).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: imageHeigh).isActive = true
        
        // seasonAndNumberLabel
        seasonAndNumberLabel.lastBaselineAnchor.constraint(equalTo: episodeNameLabel.firstBaselineAnchor).isActive = true
        seasonAndNumberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: EpisodeInformationViewController.horizontalMargin).isActive = true
        seasonAndNumberLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        // episodeNameLabel
        episodeNameLabel.topAnchor.constraint(equalTo: episodeNameTopAnchor, constant: EpisodeInformationViewController.verticalMargin).isActive = true
        episodeNameLabel.leadingAnchor.constraint(equalTo: seasonAndNumberLabel.trailingAnchor, constant: EpisodeInformationViewController.horizontalMargin).isActive = true
        episodeNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -EpisodeInformationViewController.horizontalMargin).isActive = true
        episodeNameLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        // summaryLabel
        summaryLabel.topAnchor.constraint(equalTo: episodeNameLabel.bottomAnchor, constant: EpisodeInformationViewController.verticalMargin).isActive = true
        summaryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: EpisodeInformationViewController.horizontalMargin).isActive = true
        summaryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -EpisodeInformationViewController.horizontalMargin).isActive = true
    }
    
    func configure(delegate: EpisodeInformationViewControllerDelegate, viewModel: EpisodeInformationViewModelProtocol) {
        self.delegate = delegate
        self.viewModel = viewModel
        setup()
        layoutViews()
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

// MARK: - EpisodeInformationViewProtocol
extension EpisodeInformationViewController: EpisodeInformationViewProtocol {
    func updateView(forImage image: UIImage?, completion: (() -> ())? = nil) {
        DispatchQueue.main.async { // update UI
            self.imageView.image = image
            completion?()
        }
    }
    
    func updateViewForError() {}
}
