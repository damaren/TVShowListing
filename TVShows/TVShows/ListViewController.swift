//
//  ViewController.swift
//  TVShows
//
//  Created by José Damaren on 23/06/23.
//

import UIKit

class ListViewController: UIViewController {
    
    // MARK: - PROPERTIES
    
    var label: UILabel = UILabel()
    var textField: UITextField = UITextField()
    var button: UIButton = UIButton()
    var listLabel: UILabel = UILabel()
    var searchView: UIView = UIView()
    
    // MARK: - LIFECYCLE

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layoutViews()
    }
    
    // MARK: - FUNCTIONS
    
    func setup() {
        // label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Search Here!"
        label.textColor = .label
        
        // textfield
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Type here!"
        textField.backgroundColor = .systemFill
        
        // button
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Search", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        
        // listLabel
        listLabel.translatesAutoresizingMaskIntoConstraints = false
        listLabel.text = ""
        listLabel.textColor = .label
        listLabel.numberOfLines = 0
        
        // searchView
        searchView.translatesAutoresizingMaskIntoConstraints = false
        searchView.backgroundColor = .yellow
    }
    
    func layoutViews() {
        view.addSubview(label)
        view.addSubview(textField)
        view.addSubview(button)
        view.addSubview(listLabel)
        view.addSubview(searchView)
        
        // label
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: -20).isActive = true
        
        // textfield
        textField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        // button
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20).isActive = true
        
        // listlabel
        listLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        listLabel.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 20).isActive = true
        
        // searchView
        searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        searchView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    func updateView(forTVShowResponses tvShowResponses: [TVShowResponse]) {
        self.listLabel.text = ""
        for tvShow in tvShowResponses {
            if let id = tvShow.show.id, let name = tvShow.show.name, let listLabelText = self.listLabel.text {
                print(id)
                print(name)
                self.listLabel.text = "\(listLabelText)\n\(id)   \(name)"
            }
        }
    }
    
    // MARK: - ACTIONS

    @objc func pressed() {
        TVMazeProvider.shared.requestTVShows(searchTitle: textField.text ?? "", completion: { tvShowResponses in
            DispatchQueue.main.async { // update UI
                self.updateView(forTVShowResponses: tvShowResponses)
            }
        })
    }
}

