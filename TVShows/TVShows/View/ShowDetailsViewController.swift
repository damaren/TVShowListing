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
    
    // MARK: - COMPONENTS
    
    var summaryView: UIView = UIView()
    var imageView: UIImageView = UIImageView()
    var timeLabel: UILabel = UILabel()
    var daysLabel: UILabel = UILabel()
    var genresLabel: UILabel = UILabel()
    var summaryLabel: UILabel = UILabel()
    var episodesTableView: UITableView = UITableView()
    
    // MARK: - LIFECYCLE

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - FUNCTIONS
    
    func setup() {
        self.title = show?.name ?? ""
        
        // summaryView
        summaryView.translatesAutoresizingMaskIntoConstraints = false
        summaryView.backgroundColor = .systemBackground
        
        // imageView
        imageView.translatesAutoresizingMaskIntoConstraints = false
        if let url = URL(string: show?.image?.medium ?? ""), let data = try? Data(contentsOf: url) {
            imageView.image = UIImage(data: data)
        }
        
        // genresLabel
        genresLabel.translatesAutoresizingMaskIntoConstraints = false
        genresLabel.numberOfLines = 0
        if let genres = show?.genres {
            let genresString = genres[1..<genres.count].reduce(genres.first ?? "", { partialResult, nextString in return "\(partialResult), \(nextString)"})
            genresLabel.text = "Genres: \(genresString)"
        }
        
        // timeLabel
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.numberOfLines = 0
        if let time = show?.schedule?.time, !time.isEmpty {
            timeLabel.text = "Time: \(time)"
        }
        
        // daysLabel
        daysLabel.translatesAutoresizingMaskIntoConstraints = false
        daysLabel.numberOfLines = 0
        if let days = show?.schedule?.days, !days.isEmpty {
            let daysString = days[1..<days.count].reduce(days.first ?? "", { partialResult, nextString in return "\(partialResult), \(nextString)"})
            daysLabel.text = "Days: \(daysString)"
        }
        
        // summaryLabel
        summaryLabel.translatesAutoresizingMaskIntoConstraints = false
        summaryLabel.numberOfLines = 0
        if let summary = show?.summary {
            summaryLabel.text = summary
        }
        
        // episodesTableView
        episodesTableView.translatesAutoresizingMaskIntoConstraints = false
        episodesTableView.dataSource = self
        episodesTableView.delegate = self
        episodesTableView.register(EpisodeTableViewCell.self, forCellReuseIdentifier: EpisodeTableViewCell.reuseIdentifier)
        episodesTableView.backgroundColor = .systemBackground
    }
    
    func layoutViews() {
        summaryView.addSubview(imageView)
        summaryView.addSubview(timeLabel)
        summaryView.addSubview(daysLabel)
        summaryView.addSubview(genresLabel)
        summaryView.addSubview(summaryLabel)
        view.addSubview(summaryView)
        view.addSubview(episodesTableView)
        
        // summaryView
        summaryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        summaryView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        summaryView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        summaryView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        
        // imageView
        imageView.topAnchor.constraint(equalTo: summaryView.topAnchor, constant: 16).isActive = true
        imageView.leadingAnchor.constraint(equalTo: summaryView.leadingAnchor, constant: 16).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 210).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 295).isActive = true
        
        // genresLabel
        genresLabel.topAnchor.constraint(equalTo: summaryView.topAnchor, constant: 16).isActive = true
        genresLabel.trailingAnchor.constraint(equalTo: summaryView.trailingAnchor, constant: -16).isActive = true
        genresLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16).isActive = true
        
        // timeLabel
        timeLabel.topAnchor.constraint(equalTo: genresLabel.bottomAnchor, constant: 16).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16).isActive = true
        timeLabel.trailingAnchor.constraint(equalTo: summaryView.trailingAnchor, constant: -16).isActive = true
        
        // daysLabel
        daysLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 16).isActive = true
        daysLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16).isActive = true
        daysLabel.trailingAnchor.constraint(equalTo: summaryView.trailingAnchor, constant: -16).isActive = true
        
        // summaryLabel
        summaryLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16).isActive = true
        summaryLabel.leadingAnchor.constraint(equalTo: summaryView.leadingAnchor, constant: 16).isActive = true
        summaryLabel.trailingAnchor.constraint(equalTo: summaryView.trailingAnchor, constant: -16).isActive = true
        summaryLabel.bottomAnchor.constraint(equalTo: summaryView.bottomAnchor, constant: -16).isActive = true
        
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
//        let vc = ShowDetailsViewController()
//        vc.configure(show: episodes[indexPath.row])
//        self.navigationController?.pushViewController(vc, animated: true)
    }
}
