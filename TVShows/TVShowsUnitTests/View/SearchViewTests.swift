//
//  SearchViewTests.swift
//  TVShowsUnitTests
//
//  Created by José Damaren on 07/08/23.
//

import XCTest

@testable import TVShows

final class SearchViewTests: XCTestCase {
    var searchView: SearchView!
    
    override func setUp() {
        super.setUp()

        searchView = SearchView()
    }

    override func tearDown() {
        super.tearDown()
        searchView = nil
    }
    
    func testSetup() throws {
        // Given the instantiated search view not yet set up
        
        // When setup is called
        searchView.setup()
        
        // Then
        
        // All the components have translatesAutoresizingMaskIntoConstraints equal false
        XCTAssertFalse(searchView.translatesAutoresizingMaskIntoConstraints, "The searchView should have translatesAutoresizingMaskIntoConstraints equal false")
        XCTAssertFalse(searchView.searchTextField.translatesAutoresizingMaskIntoConstraints, "The searchTextField should have translatesAutoresizingMaskIntoConstraints equal false")
        XCTAssertFalse(searchView.searchButton.translatesAutoresizingMaskIntoConstraints, "The searchButton should have translatesAutoresizingMaskIntoConstraints equal false")
        XCTAssertFalse(searchView.underlineView.translatesAutoresizingMaskIntoConstraints, "The underlineView should have translatesAutoresizingMaskIntoConstraints equal false")
        
        // The textField's placeHolder should be 'Title Search'
        XCTAssertEqual(searchView.searchTextField.placeholder, "Title Search", "The textField's placeHolder should be 'Title Search', but it is \(String(describing: searchView.searchTextField.placeholder))")
        
        // The searchButton's image for .normal should be UIImage(systemName: "magnifyingglass")
        XCTAssertEqual(searchView.searchButton.image(for: .normal), UIImage(systemName: "magnifyingglass"), "The searchButton's image for .normal should be UIImage(systemName: 'magnifyingglass'), but it is \(String(describing: searchView.searchButton.image(for: .normal)))")

        // The searchButton's titleColor for .normal should be .label
        XCTAssertEqual(searchView.searchButton.titleColor(for: .normal), .label, "The searchButton's titleColor for .normal should be .label, but it is \(String(describing: searchView.searchButton.titleColor(for: .normal)))")
        
        // The searchButton's tintColor should be .secondaryLabel
        XCTAssertEqual(searchView.searchButton.tintColor, .secondaryLabel, "The searchButton's tintColor should be .secondaryLabel, but it is \(String(describing: searchView.searchButton.tintColor))")

        // The underlineView's backgroundColor should be .placeholderText
        XCTAssertEqual(searchView.underlineView.backgroundColor, .placeholderText, "The underlineView's backgroundColor should be .placeholderText, but it is \(String(describing: searchView.underlineView.backgroundColor))")
    }
    
    func testLayout() throws {
        // Given the view not yet laid out
        
        // When layout is called
        searchView.layout()
        
        // Then
        // The searchView contains the searchTextField
        XCTAssertTrue(searchView.subviews.contains(searchView.searchTextField), "The searchView should contain the searchTextField")
        // The searchView contains the searchButton
        XCTAssertTrue(searchView.subviews.contains(searchView.searchButton), "The searchView should contain the searchButton")
        // The searchView contains the underlineView
        XCTAssertTrue(searchView.subviews.contains(searchView.underlineView), "The searchView should contain the underlineView")

        // The searchTextField's leadingAnchor should be equal to the searchView's leadingAnchor + 2*SearchView.horizontalMargin
        XCTAssertTrue(searchView.constraints.contains(where: { constraint in
            (constraint.firstItem as? UITextField) == searchView.searchTextField &&
            constraint.firstAnchor == searchView.searchTextField.leadingAnchor &&
            (constraint.secondItem as? UIView) == searchView &&
            constraint.secondAnchor == searchView.leadingAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == 2*SearchView.horizontalMargin &&
            constraint.isActive == true
        }), "The searchView should have the constraint searchTextField.leadingAnchor == searchView.leadingAnchor + \(2*SearchView.horizontalMargin), but it wasn't found")
        
        // The searchTextField's topAnchor should be equal to the searchView's topAnchor + 2*SearchView.verticalMargin
        XCTAssertTrue(searchView.constraints.contains(where: { constraint in
            (constraint.firstItem as? UITextField) == searchView.searchTextField &&
            constraint.firstAnchor == searchView.searchTextField.topAnchor &&
            (constraint.secondItem as? UIView) == searchView &&
            constraint.secondAnchor == searchView.topAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == 2*SearchView.verticalMargin &&
            constraint.isActive == true
        }), "The searchView should have the constraint searchTextField.topAnchor == searchView.topAnchor + \(2*SearchView.verticalMargin), but it wasn't found")
        
        // The searchTextField's bottomAnchor should be equal to the searchView's bottomAnchor - 2*SearchView.verticalMargin
        XCTAssertTrue(searchView.constraints.contains(where: { constraint in
            (constraint.firstItem as? UITextField) == searchView.searchTextField &&
            constraint.firstAnchor == searchView.searchTextField.bottomAnchor &&
            (constraint.secondItem as? UIView) == searchView &&
            constraint.secondAnchor == searchView.bottomAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == -2*SearchView.verticalMargin &&
            constraint.isActive == true
        }), "The searchView should have the constraint searchTextField.bottomAnchor == searchView.bottomAnchor - \(2*SearchView.verticalMargin), but it wasn't found")
        
        // The searchTextField's trailingAnchor should be equal to the searchButton's leadingAnchor - 2*SearchView.horizontalMargin
        XCTAssertTrue(searchView.constraints.contains(where: { constraint in
            (constraint.firstItem as? UITextField) == searchView.searchTextField &&
            constraint.firstAnchor == searchView.searchTextField.trailingAnchor &&
            (constraint.secondItem as? UIButton) == searchView.searchButton &&
            constraint.secondAnchor == searchView.searchButton.leadingAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == -2*SearchView.horizontalMargin &&
            constraint.isActive == true
        }), "The searchView should have the constraint searchTextField.trailingAnchor == searchButton.leadingAnchor - \(2*SearchView.horizontalMargin), but it wasn't found")

        // The searchButton's widthAnchor should be equal to 60
        XCTAssertTrue(searchView.searchButton.constraints.contains(where: { constraint in
            (constraint.firstItem as? UIButton) == searchView.searchButton &&
            constraint.firstAnchor == searchView.searchButton.widthAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == 60 &&
            constraint.isActive == true
        }), "The searchButton should have the constraint searchButton.widthAnchor == 60, but it wasn't found")

        // The searchButton's topAnchor should be equal to the searchView's topAnchor
        XCTAssertTrue(searchView.constraints.contains(where: { constraint in
            (constraint.firstItem as? UIButton) == searchView.searchButton &&
            constraint.firstAnchor == searchView.searchButton.topAnchor &&
            (constraint.secondItem as? UIView) == searchView &&
            constraint.secondAnchor == searchView.topAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == 0 &&
            constraint.isActive == true
        }), "The searchView should have the constraint searchButton.topAnchor == searchView.topAnchor, but it wasn't found")
        
        // The searchButton's bottomAnchor should be equal to the searchView's bottomAnchor
        XCTAssertTrue(searchView.constraints.contains(where: { constraint in
            (constraint.firstItem as? UIButton) == searchView.searchButton &&
            constraint.firstAnchor == searchView.searchButton.bottomAnchor &&
            (constraint.secondItem as? UIView) == searchView &&
            constraint.secondAnchor == searchView.bottomAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == 0 &&
            constraint.isActive == true
        }), "The searchView should have the constraint searchButton.bottomAnchor == searchView.bottomAnchor, but it wasn't found")
        
        // The searchButton's trailingAnchor should be equal to the searchView's trailingAnchor
        XCTAssertTrue(searchView.constraints.contains(where: { constraint in
            (constraint.firstItem as? UIButton) == searchView.searchButton &&
            constraint.firstAnchor == searchView.searchButton.trailingAnchor &&
            (constraint.secondItem as? UIView) == searchView &&
            constraint.secondAnchor == searchView.trailingAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == 0 &&
            constraint.isActive == true
        }), "The searchView should have the constraint searchButton.trailingAnchor == searchView.trailingAnchor, but it wasn't found")

        // The underlineView's heightAnchor should be equal to 2
        XCTAssertTrue(searchView.underlineView.constraints.contains(where: { constraint in
            (constraint.firstItem as? UIView) == searchView.underlineView &&
            constraint.firstAnchor == searchView.underlineView.heightAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == 2 &&
            constraint.isActive == true
        }), "The underlineView should have the constraint underlineView.heightAnchor == 2, but it wasn't found")

        // The underlineView's leadingAnchor should be equal to the searchView's leadingAnchor + 2*SearchView.horizontalMargin
        XCTAssertTrue(searchView.constraints.contains(where: { constraint in
            (constraint.firstItem as? UIView) == searchView.underlineView &&
            constraint.firstAnchor == searchView.underlineView.leadingAnchor &&
            (constraint.secondItem as? UIView) == searchView &&
            constraint.secondAnchor == searchView.leadingAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == 2*SearchView.horizontalMargin &&
            constraint.isActive == true
        }), "The searchView should have the constraint underlineView.leadingAnchor == searchView.leadingAnchor + \(2*SearchView.horizontalMargin), but it wasn't found")

        // The underlineView's trailingAnchor should be equal to the searchView's trailingAnchor - 2*SearchView.horizontalMargin
        XCTAssertTrue(searchView.constraints.contains(where: { constraint in
            (constraint.firstItem as? UIView) == searchView.underlineView &&
            constraint.firstAnchor == searchView.underlineView.trailingAnchor &&
            (constraint.secondItem as? UIView) == searchView &&
            constraint.secondAnchor == searchView.trailingAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == -2*SearchView.horizontalMargin &&
            constraint.isActive == true
        }), "The searchView should have the constraint underlineView.trailingAnchor == searchView.trailingAnchor - \(2*SearchView.horizontalMargin), but it wasn't found")

        // The underlineView's topAnchor should be equal to the searchTextField's bottomAnchor
        XCTAssertTrue(searchView.constraints.contains(where: { constraint in
            (constraint.firstItem as? UIView) == searchView.underlineView &&
            constraint.firstAnchor == searchView.underlineView.topAnchor &&
            (constraint.secondItem as? UITextField) == searchView.searchTextField &&
            constraint.secondAnchor == searchView.searchTextField.bottomAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == 0 &&
            constraint.isActive == true
        }), "The searchView should have the constraint underlineView.topAnchor == searchTextField.bottomAnchor, but it wasn't found")
    }
    
    func testSearchButtonPressed() throws {
        // Given the instantiated view
        // With the delegate set
        class MockDelegate: SearchViewDelegate {
            func searchViewSearchButtonPressed(withSearchText searchText: String, completion: (() -> ())?) {
                wasSearchButtonPressedCalled = true
            }
            
            var wasSearchButtonPressedCalled = false
        }
        let mockDelegate = MockDelegate()
        searchView.delegate = mockDelegate
        
        // When searchButtonPressed is called
        searchView.searchButtonPressed()
        
        // Then the delegate's searchViewSearchButtonPressed should get called
        XCTAssertTrue(mockDelegate.wasSearchButtonPressedCalled, "The delegate's searchViewSearchButtonPressed should get called, wasSearchButtonPressedCalled should be true")
    }
}

