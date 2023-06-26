//
//  SearchView.swift
//  TVShows
//
//  Created by José Damaren on 24/06/23.
//

import Foundation
import UIKit

protocol SearchViewDelegate: AnyObject {
    func searchViewSearchButtonPressed(withSearchText searchText: String)
}

class SearchView: UIView {
    
    // MARK: - PROPERTIES
    
    weak var delegate: SearchViewDelegate?
    
    // MARK: - COMPONENTS
    
    var searchTextField: UITextField = UITextField()
    var searchButton: UIButton = UIButton()
    var underlineView: UIView = UIView()
    
    // MARK: - INIT
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        // not going to be used since we're not using storyboards
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchView {
    
    // MARK: - FUNCTIONS
    
    func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        
        // searchTextField
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Title Search",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeholderText]
        )

        
        // searchButton
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.setTitleColor(.label, for: .normal)
        searchButton.tintColor = .secondaryLabel
        searchButton.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        
        // underlineView
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        underlineView.backgroundColor = .placeholderText
    }
    
    func layout() {
        addSubview(searchTextField)
        addSubview(searchButton)
        addSubview(underlineView)
        
        // searchTextField
        searchTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        searchTextField.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        searchTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
        searchTextField.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor, constant: -16).isActive = true
        
        // searchButton
        searchButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        searchButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        searchButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        searchButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        // underlineView
        underlineView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        underlineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        underlineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        underlineView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 0).isActive = true
    }
    
    func setupWithError() {
        
    }
    
    // MARK: - ACTIONS
    
    @objc func searchButtonPressed() {
        guard let text = searchTextField.text else {
            setupWithError()
            return
        }
        
        delegate?.searchViewSearchButtonPressed(withSearchText: text)
    }
}
