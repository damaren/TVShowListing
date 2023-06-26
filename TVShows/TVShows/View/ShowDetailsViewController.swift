//
//  ShowDetailsViewController.swift
//  TVShows
//
//  Created by José Damaren on 24/06/23.
//

import UIKit

class ShowDetailsViewController: UIViewController {
    
    // MARK: - PROPERTIES
    
    var show: TVShow?
    var episodes: [[Episode]] = [] // array of episodes separated by seasons (episodes[i] is the array of episodes in season i+1)
    weak var delegate: ShowDetailsViewControllerDelegate?
    
    // MARK: - COMPONENTS
    
    var summaryView: ShowDetailsSummaryView = ShowDetailsSummaryView()
    var episodesTableView: UITableView = UITableView()
    
    // MARK: - LIFECYCLE

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - FUNCTIONS
    
    func setup() {
        self.title = show?.name ?? ""
        view.backgroundColor = .systemBackground
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonPressed))
        navigationItem.leftBarButtonItem?.tintColor = .label
        
        // summaryView
        summaryView.translatesAutoresizingMaskIntoConstraints = false
        summaryView.backgroundColor = .systemBackground
        summaryView.configure(forShow: show)
        
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
        self.show = show
        requestEpisodes()
        setup()
        layoutViews()
    }
    
    func requestEpisodes() {
        if let id = show?.id {
            TVMazeProvider.shared.requestEpisodes(showID: id, completion: { episodes in
                DispatchQueue.main.async { // update UI
                    self.updateView(forEpisodes: episodes)
                }
            })
        }
    }
    
    func updateView(forEpisodes episodes: [Episode]) {
        self.episodes = separateEpisodesBySeason(episodes: episodes)
        episodesTableView.reloadData()
    }
    
    func separateEpisodesBySeason(episodes: [Episode]) -> [[Episode]] {
        var season = 1
        var seasonAndEpisodes: [[Episode]] = []
        repeat {
            let seasonEpisodes = episodes.filter({ episode in return episode.season == season })
            seasonAndEpisodes.append(seasonEpisodes)
            season += 1
        } while episodes.contains(where: { episode in episode.season == season})
        return seasonAndEpisodes
    }
    
    // MARK: - ACTIONS
    
    @objc func backButtonPressed() {
        delegate?.backButtonPressed(inViewcontroller: self)
    }
}

// MARK: - UITableViewDataSource

extension ShowDetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeTableViewCell.reuseIdentifier, for: indexPath) as? EpisodeTableViewCell else {
            return UITableViewCell()
        }
        
        let episode = episodes[indexPath.section][indexPath.row]
        cell.configure(forEpisode: episode)
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ShowDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selectedEpisode(episode: episodes[indexPath.section][indexPath.row], withShowTitle: show?.name ?? "")
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
    func selectedEpisode(episode: Episode, withShowTitle showTitle: String)
    func backButtonPressed(inViewcontroller: ShowDetailsViewController)
}
