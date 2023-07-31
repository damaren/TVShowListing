//
//  ShowDescriptionViewController.swift
//  TVShows
//
//  Created by José Damaren on 26/06/23.
//

import UIKit

class ShowDescriptionViewController: UIViewController {
    
    // MARK: - PROPERTIES
    
    var tvShowDescription: String?
    weak var delegate: ShowDescriptionViewControllerDelegate?
    
    // MARK: - COMPONENTS
    
    var descriptionLabel: UILabel = UILabel()
    var closeButton: UIButton = UIButton()
    
    // MARK: - LIFECYCLE

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.showDescriptionViewControllerDismissed(viewController: self)
    }
    
    // MARK: - FUNCTIONS
    
    func setup() {
        view.backgroundColor = .systemBackground
        
        // descriptionLabel
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.numberOfLines = 0
        descriptionLabel.attributedText = tvShowDescription?.htmlToAttributedString(withSize: Int(descriptionLabel.font.pointSize))
        
        // closeButton
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = .secondaryLabel
        closeButton.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
    }
    
    func layoutViews() {
        view.addSubview(descriptionLabel)
        view.addSubview(closeButton)
        
        // descriptionLabel
        descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 16).isActive = true
        
        // closeButton
        closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
    }
    
    func configure(description: String, delegate: ShowDescriptionViewControllerDelegate?) {
        self.tvShowDescription = description
        self.delegate = delegate
        setup()
        layoutViews()
    }
    
    // MARK: - ACTIONS
    
    @objc func closeButtonPressed() {
        self.dismiss(animated: true)
    }
}

// MARK: - ShowDescriptionViewControllerDelegate
protocol ShowDescriptionViewControllerDelegate: AnyObject {
    func showDescriptionViewControllerDismissed(viewController: ShowDescriptionViewController)
}
