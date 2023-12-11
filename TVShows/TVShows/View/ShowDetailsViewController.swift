//
//  ShowDetailsViewController.swift
//  TVShows
//
//  Created by José Damaren on 24/06/23.
//

import UIKit

protocol ShowDetailsViewModelProtocol: AnyObject {
    var showName: String { get }
    var numberOfSections: Int { get }
    var showSummary: String { get }
    
    func configure(forShow show: TVShow, withProvider provider: Provider)
    func getNumberOfRows(inSection section: Int) -> Int
    func getEpisode(forIndexPath indexPath: IndexPath) -> Episode
}

class ShowDetailsViewController: UIViewController {
    
    // MARK: - PROPERTIES
    
    weak var delegate: ShowDetailsViewControllerDelegate?
    var viewModel: ShowDetailsViewModelProtocol?
    
    // MARK: - COMPONENTS
    
    var summaryView: UIView?
    var episodesTableView: UITableView = UITableView()
    
    // MARK: - LIFECYCLE

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - FUNCTIONS
    
    func setup() {
        guard let viewModel = viewModel, let summaryView = summaryView else { return }
        
        self.title = viewModel.showName
        view.backgroundColor = .systemBackground
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonPressed))
        navigationItem.leftBarButtonItem?.tintColor = .label
        
        // summaryView
        summaryView.translatesAutoresizingMaskIntoConstraints = false
        summaryView.backgroundColor = .systemBackground
        
        // episodesTableView
        episodesTableView.translatesAutoresizingMaskIntoConstraints = false
        episodesTableView.dataSource = self
        episodesTableView.delegate = self
        episodesTableView.register(EpisodeTableViewCell.self, forCellReuseIdentifier: EpisodeTableViewCell.reuseIdentifier)
        episodesTableView.backgroundColor = .systemBackground
    }
    
    func layoutViews() {
        guard let summaryView = summaryView else { return }
        
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
    
    func configure(show: TVShow, viewModel: ShowDetailsViewModelProtocol, summaryView: UIView, delegate: ShowDetailsViewControllerDelegate) {
        self.delegate = delegate
        self.summaryView = summaryView
        self.viewModel = viewModel
        self.viewModel?.configure(forShow: show, withProvider: TVMazeProvider())
        setup()
        layoutViews()
    }
    
    // MARK: - ACTIONS
    
    @objc func backButtonPressed() {
        delegate?.backButtonPressed(in: self, withAnimation: true)
    }
}

// MARK: - UITableViewDataSource

extension ShowDetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.numberOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getNumberOfRows(inSection: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeTableViewCell.reuseIdentifier, for: indexPath) as? EpisodeTableViewCell, let viewModel = viewModel else {
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
        guard let viewModel = viewModel else {
            tableView.deselectRow(at: indexPath, animated: true)
            return
        }
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
    func backButtonPressed(in viewController: ShowDetailsViewController, withAnimation: Bool)
    func seeMoreButtonPressed(in viewController: ShowDetailsViewController, forShowSummary summary: String?)
}

// MARK: - ShowDetailsSummaryViewDelegate
extension ShowDetailsViewController: ShowDetailsSummaryViewDelegate {
    func seeMoreButtonPressed() {
        delegate?.seeMoreButtonPressed(in: self, forShowSummary: viewModel?.showSummary)
    }
}

// MARK: - ShowDetailsViewProtocol
extension ShowDetailsViewController: ShowDetailsViewProtocol {
    func updateView(completion: (() -> ())?) {
        DispatchQueue.main.async { // update UI
            self.episodesTableView.reloadData()
            completion?()
        }
    }
}
