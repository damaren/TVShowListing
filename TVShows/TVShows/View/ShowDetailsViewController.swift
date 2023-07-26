//
//  ShowDetailsViewController.swift
//  TVShows
//
//  Created by José Damaren on 24/06/23.
//

import UIKit

class ShowDetailsViewController: UIViewController {
    
    // MARK: - PROPERTIES
    
    weak var delegate: ShowDetailsViewControllerDelegate?
    var viewModel: ShowDetailsViewModel = ShowDetailsViewModel()
    var showDescriptionVC: ShowDescriptionViewController? // storing the value here for unit testing
    
    // MARK: - COMPONENTS
    
    var summaryView: ShowDetailsSummaryView = ShowDetailsSummaryView()
    var episodesTableView: UITableView = UITableView()
    
    // MARK: - LIFECYCLE

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - FUNCTIONS
    
    func setup() {
        self.title = viewModel.showName
        view.backgroundColor = .systemBackground
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonPressed))
        navigationItem.leftBarButtonItem?.tintColor = .label
        
        // update
        viewModel.updateView = { [weak self] in
            self?.updateView()
        }
        
        // summaryView
        summaryView.translatesAutoresizingMaskIntoConstraints = false
        summaryView.backgroundColor = .systemBackground
        summaryView.configure(forShow: viewModel.show)
        summaryView.delegate = self
        
        // episodesTableView
        episodesTableView.translatesAutoresizingMaskIntoConstraints = false
        episodesTableView.dataSource = self
        episodesTableView.delegate = self
        episodesTableView.register(EpisodeTableViewCell.self, forCellReuseIdentifier: EpisodeTableViewCell.reuseIdentifier)
        episodesTableView.backgroundColor = .systemBackground
    }
    
    func layoutViews() {
        view.addSubview(summaryView)
        view.addSubview(episodesTableView)
        
        // summaryView
        summaryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        summaryView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        summaryView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        summaryView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        
        // episodesTableView
        episodesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        episodesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        episodesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        episodesTableView.topAnchor.constraint(equalTo: summaryView.bottomAnchor).isActive = true
    }
    
    func configure(show: TVShow) {
        viewModel.configure(forShow: show)
        setup()
        layoutViews()
    }
    
    func updateView(completion: (() -> ())? = nil) {
        DispatchQueue.main.async { // update UI
            self.episodesTableView.reloadData()
            completion?()
        }
    }
    
    // MARK: - ACTIONS
    
    @objc func backButtonPressed() {
        delegate?.backButtonPressed(inViewcontroller: self, withAnimation: true)
    }
}

// MARK: - UITableViewDataSource

extension ShowDetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeTableViewCell.reuseIdentifier, for: indexPath) as? EpisodeTableViewCell else {
            return UITableViewCell()
        }
        
        let episode = viewModel.getEpisode(forIndexPath: indexPath)
        cell.configure(forEpisode: episode)
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ShowDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selectedEpisode(episode: viewModel.getEpisode(forIndexPath: indexPath), withShowTitle: viewModel.showName, withAnimation: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView: UIView = UIView()
        let seasonLabel: UILabel = UILabel()
        
        // the view
        headerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        headerView.backgroundColor = .systemGray4
        
        // seasonLabel
        headerView.addSubview(seasonLabel)
        seasonLabel.translatesAutoresizingMaskIntoConstraints = false
        seasonLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        seasonLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 8).isActive = true
        seasonLabel.text = "Season \(section + 1)"
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return EpisodeTableViewCell.cellHeight
    }
}

// MARK: - ShowDetailsViewControllerDelegate
protocol ShowDetailsViewControllerDelegate: AnyObject {
    func selectedEpisode(episode: Episode, withShowTitle showTitle: String, withAnimation: Bool)
    func backButtonPressed(inViewcontroller: ShowDetailsViewController, withAnimation: Bool)
}

// MARK: - ShowDetailsSummaryViewDelegate
extension ShowDetailsViewController: ShowDetailsSummaryViewDelegate {
    func seeMoreButtonPressed() {
        showDescriptionVC = ShowDescriptionViewController()
        guard let showDescriptionVC = showDescriptionVC else { return }
        showDescriptionVC.configure(description: viewModel.showSummary, delegate: self)
        present(showDescriptionVC, animated: true)
    }
}

// MARK: - ShowDescriptionViewControllerDelegate
extension ShowDetailsViewController: ShowDescriptionViewControllerDelegate {
    func showDescriptionViewControllerDismissed(viewController: ShowDescriptionViewController) {
        showDescriptionVC = nil
    }
}
