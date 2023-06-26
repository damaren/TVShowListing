//
//  ShowDetailsSummaryView.swift
//  TVShows
//
//  Created by José Damaren on 26/06/23.
//
import Foundation
import UIKit

class ShowDetailsSummaryView: UIView {
    
    // MARK: - PROPERTIES
    
    var show: TVShow?
    weak var delegate: ShowDetailsSummaryViewDelegate?
    
    // MARK: - COMPONENTS
    
    var imageView: UIImageView = UIImageView()
    var timeLabel: UILabel = UILabel()
    var daysLabel: UILabel = UILabel()
    var genresLabel: UILabel = UILabel()
    var summaryLabel: UILabel = UILabel()
    var seeMoreButton: UIButton = UIButton()
    
    // MARK: - INIT
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        // not going to be used since we're not using storyboards
        fatalError("init(coder:) has not been implemented")
    }
}

extension ShowDetailsSummaryView {
    
    // MARK: - FUNCTIONS
    
    func setup() {
        // imageView
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.roundCorners()
        imageView.image = UIImage(systemName: "photo.artframe")
        imageView.tintColor = .label
        imageView.contentMode = .scaleAspectFit
        TVMazeProvider.shared.requestImage(forUrl: show?.image?.medium, completion: { imageData in
            DispatchQueue.main.async { // update UI
                if let imageData = imageData {
                    self.imageView.image = UIImage(data: imageData)
                }
            }
        })
        
        // genresLabel
        genresLabel.translatesAutoresizingMaskIntoConstraints = false
        genresLabel.numberOfLines = 0
        if let genres = show?.genres, !genres.isEmpty {
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
            summaryLabel.text = summary.htmlToString
        }
        
        // seeMoreButton
        seeMoreButton.translatesAutoresizingMaskIntoConstraints = false
        seeMoreButton.setTitle("more", for: .normal)
        seeMoreButton.setTitleColor(.secondaryLabel, for: .normal)
        seeMoreButton.addTarget(self, action: #selector(seeMoreButtonPressed), for: .touchUpInside)
    }
    
    func layout() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(imageView)
        addSubview(timeLabel)
        addSubview(daysLabel)
        addSubview(genresLabel)
        addSubview(summaryLabel)
        addSubview(seeMoreButton)
        
        // imageView
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 210).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 295).isActive = true
        
        // genresLabel
        genresLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        genresLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        genresLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16).isActive = true
        
        // timeLabel
        timeLabel.topAnchor.constraint(equalTo: genresLabel.bottomAnchor, constant: 16).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16).isActive = true
        timeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        
        // daysLabel
        daysLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 16).isActive = true
        daysLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16).isActive = true
        daysLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        
        // summaryLabel
        summaryLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16).isActive = true
        summaryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        summaryLabel.trailingAnchor.constraint(equalTo: seeMoreButton.leadingAnchor, constant: -8).isActive = true
        summaryLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
        summaryLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        // seeMoreButton
        seeMoreButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        seeMoreButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
        seeMoreButton.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    }
    
    func configure(forShow show: TVShow?) {
        self.show = show
        
        setup()
        layout()
    }
    
    // MARK: - ACTIONS
    
    @objc func seeMoreButtonPressed() {
        delegate?.seeMoreButtonPressed()
    }
}

// MARK: - ShowDetailsSummaryViewDelegate

protocol ShowDetailsSummaryViewDelegate: AnyObject {
    func seeMoreButtonPressed()
}
