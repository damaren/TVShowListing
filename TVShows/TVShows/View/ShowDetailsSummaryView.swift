//
//  ShowDetailsSummaryView.swift
//  TVShows
//
//  Created by José Damaren on 26/06/23.
//
import Foundation
import UIKit

class ShowDetailsSummaryView: UIView {
    
    // MARK: - STATIC PROPERTIES
    static let horizontalMargin: CGFloat = 8
    static let verticalMargin: CGFloat = 8
    
    // MARK: - PROPERTIES
    
    weak var delegate: ShowDetailsSummaryViewDelegate?
    var viewModel: ShowDetailsSummaryViewModel = ShowDetailsSummaryViewModel()
    
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
        // update
        viewModel.updateView = { [weak self] image in
            self?.updateView(forImage: image)
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        // imageView
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.roundCorners()
        imageView.image = UIImage(systemName: "photo.artframe")
        imageView.tintColor = .label
        imageView.contentMode = .scaleAspectFit
        
        // genresLabel
        genresLabel.translatesAutoresizingMaskIntoConstraints = false
        genresLabel.numberOfLines = 0
        genresLabel.text = viewModel.getGenres()
        
        // timeLabel
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.numberOfLines = 0
        timeLabel.text = viewModel.getTime()
        
        // daysLabel
        daysLabel.translatesAutoresizingMaskIntoConstraints = false
        daysLabel.numberOfLines = 0
        daysLabel.text =  viewModel.getDays()
        
        // summaryLabel
        summaryLabel.translatesAutoresizingMaskIntoConstraints = false
        summaryLabel.numberOfLines = 0
        summaryLabel.attributedText = viewModel.getSummary().htmlToAttributedString(withSize: Int(summaryLabel.font.pointSize))
        
        // seeMoreButton
        seeMoreButton.translatesAutoresizingMaskIntoConstraints = false
        seeMoreButton.setTitle("more", for: .normal)
        seeMoreButton.setTitleColor(.secondaryLabel, for: .normal)
        seeMoreButton.addTarget(self, action: #selector(seeMoreButtonPressed), for: .touchUpInside)
    }
    
    func layout() {
        
        addSubview(imageView)
        addSubview(timeLabel)
        addSubview(daysLabel)
        addSubview(genresLabel)
        addSubview(summaryLabel)
        addSubview(seeMoreButton)
        
        // imageView
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 2*ShowDetailsSummaryView.verticalMargin).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2*ShowDetailsSummaryView.horizontalMargin).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 210).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 295).isActive = true
        
        // genresLabel
        genresLabel.topAnchor.constraint(equalTo: topAnchor, constant: 2*ShowDetailsSummaryView.verticalMargin).isActive = true
        genresLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2*ShowDetailsSummaryView.horizontalMargin).isActive = true
        genresLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 2*ShowDetailsSummaryView.horizontalMargin).isActive = true
        
        // timeLabel
        timeLabel.topAnchor.constraint(equalTo: genresLabel.bottomAnchor, constant: 2*ShowDetailsSummaryView.verticalMargin).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 2*ShowDetailsSummaryView.horizontalMargin).isActive = true
        timeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2*ShowDetailsSummaryView.horizontalMargin).isActive = true
        
        // daysLabel
        daysLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 2*ShowDetailsSummaryView.verticalMargin).isActive = true
        daysLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 2*ShowDetailsSummaryView.horizontalMargin).isActive = true
        daysLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2*ShowDetailsSummaryView.horizontalMargin).isActive = true
        
        // summaryLabel
        summaryLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 2*ShowDetailsSummaryView.verticalMargin).isActive = true
        summaryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2*ShowDetailsSummaryView.horizontalMargin).isActive = true
        summaryLabel.trailingAnchor.constraint(equalTo: seeMoreButton.leadingAnchor, constant: -ShowDetailsSummaryView.horizontalMargin).isActive = true
        summaryLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2*ShowDetailsSummaryView.verticalMargin).isActive = true
        summaryLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        // seeMoreButton
        seeMoreButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2*ShowDetailsSummaryView.horizontalMargin).isActive = true
        seeMoreButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2*ShowDetailsSummaryView.verticalMargin).isActive = true
        seeMoreButton.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    }
    
    func configure(forShow show: TVShow?, andDelegate delegate: ShowDetailsSummaryViewDelegate) {
        self.delegate = delegate
        viewModel.configure(forShow: show)
        
        setup()
        layout()
    }
    
    func updateView(forImage image: UIImage?, completion: (() -> ())? = nil) {
        DispatchQueue.main.async { // update UI
            self.imageView.image = image
            completion?()
        }
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
