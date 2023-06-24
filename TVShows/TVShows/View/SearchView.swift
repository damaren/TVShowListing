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
    
    var searchTextField: UITextField = UITextField()
    var searchButton: UIButton = UIButton()
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 300, height: 200)
    }
    
    // MARK: - INIT
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        // not going to be used since we're not using storyboards
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchView {
    
    // MARK: - STYLE
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        
        // searchTextField
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.placeholder = "Search"
        searchTextField.backgroundColor = .systemFill
        
        // searchButton
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.setTitle("Search", for: .normal)
        searchButton.setTitleColor(.label, for: .normal)
        searchButton.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
    }
    
    // MARK: - LAYOUT
    
    func layout() {
        addSubview(searchTextField)
        addSubview(searchButton)
        
        // searchTextField
        searchTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        searchTextField.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        searchTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
        searchTextField.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor, constant: -16).isActive = true
        
        // searchButton
        searchButton.widthAnchor.constraint(equalToConstant: 160).isActive = true
        searchButton.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        searchButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
        searchButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
    }
    
    // MARK: - ACTIONS
    
    @objc func searchButtonPressed() {
        guard let text = searchTextField.text else {
            setupWithError()
            return
        }
        
        delegate?.searchViewSearchButtonPressed(withSearchText: text)
    }
    
    // MARK: - FUNCTIONS
    
    func setupWithError() {
        
    }
}
