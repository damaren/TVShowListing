//
//  ShowDescriptionViewControllerTests.swift
//  TVShowsUnitTests
//
//  Created by José Damaren on 30/07/23.
//

import XCTest

@testable import TVShows

final class ShowDescriptionViewControllerTests: XCTestCase {
    var vc: ShowDescriptionViewController!
    
    override func setUp() {
        super.setUp()

        vc = ShowDescriptionViewController()
    }

    override func tearDown() {
        super.tearDown()
        vc = nil
    }
    
    func testSetup() {
        // Given the instantiated view controller
        // The show description set
        let showDescription = "Show description"
        vc.tvShowDescription = showDescription
        
        // When setup is called
        vc.setup()
        
        // Then
        // All the components should have translatesAutoresizingMaskIntoConstraints equal false
        XCTAssertEqual(vc.descriptionLabel.translatesAutoresizingMaskIntoConstraints, false, "The descriptionLabel translatesAutoresizingMaskIntoConstraints should be false, but it is \(vc.descriptionLabel.translatesAutoresizingMaskIntoConstraints)")
        XCTAssertEqual(vc.closeButton.translatesAutoresizingMaskIntoConstraints, false, "The closeButton translatesAutoresizingMaskIntoConstraints should be false, but it is \(vc.closeButton.translatesAutoresizingMaskIntoConstraints)")
        
        // The view's background color should be .systemBackground
        XCTAssertEqual(vc.view.backgroundColor, .systemBackground, "The view's background color should be .systemBackground but it is \(String(describing: vc.view.backgroundColor))")

        // The descriptionLabel's number of lines should be 0
        XCTAssertEqual(vc.descriptionLabel.numberOfLines, 0, "The descriptionLabel's number of lines should be 0, but it is \(vc.descriptionLabel.numberOfLines)")
        
        // The descriptionLabel's text should be the show description
        XCTAssertEqual(vc.descriptionLabel.attributedText?.string, showDescription, "The descriptionLabel's text should be the show description, but it is \(String(describing: vc.descriptionLabel.attributedText?.string))")
        
        // The closeButton's image should be UIImage(systemName: "xmark")
        XCTAssertEqual(vc.closeButton.image(for: .normal), UIImage(systemName: "xmark"), "The closeButton's image should be UIImage(systemName: \"xmark\"), but it is \(String(describing: vc.closeButton.image(for: .normal)))")
        
        // The closeButton's tintColor should be .secondaryLabel
        XCTAssertEqual(vc.closeButton.tintColor, .secondaryLabel, "The closeButton's tintColor should be .secondaryLabel, but it is \(String(describing: vc.closeButton.tintColor))")
    }
    
    func testLayoutViews() throws {
        // Given the view controller not yet laid out
        
        // When layout is called
        vc.layoutViews()

        // Then
        // The view contains the descriptionLabel
        XCTAssertTrue(vc.view.subviews.contains(vc.descriptionLabel), "The vc's view should contain the descriptionLabel")
        // The view contains the closeButton
        XCTAssertTrue(vc.view.subviews.contains(vc.closeButton), "The vc's view should contain the closeButton")

        // The descriptionLabel's topAnchor should be equal to the closeButton's bottomAnchor
        XCTAssertTrue(vc.view.constraints.contains(where: { constraint in
            (constraint.firstItem as? UILabel) == vc.descriptionLabel &&
            constraint.firstAnchor == vc.descriptionLabel.topAnchor &&
            (constraint.secondItem as? UIButton) == vc.closeButton &&
            constraint.secondAnchor == vc.closeButton.bottomAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == 16 &&
            constraint.isActive == true
        }), "The view should have the constraint descriptionLabel.topAnchor == closeButton.bottomAnchor, but it wasn't found")

        // The descriptionLabel's leadingAnchor should be equal to the view's leadingAnchor + 16
        XCTAssertTrue(vc.view.constraints.contains(where: { constraint in
            (constraint.firstItem as? UILabel) == vc.descriptionLabel &&
            constraint.firstAnchor == vc.descriptionLabel.leadingAnchor &&
            (constraint.secondItem as? UIView) == vc.view &&
            constraint.secondAnchor == vc.view.leadingAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == 16 &&
            constraint.isActive == true
        }), "The view should have the constraint descriptionLabel.leadingAnchor == view.leadingAnchor + 16, but it wasn't found")

        // The descriptionLabel's trailingAnchor should be equal to the view's trailingAnchor - 16
        XCTAssertTrue(vc.view.constraints.contains(where: { constraint in
            (constraint.firstItem as? UILabel) == vc.descriptionLabel &&
            constraint.firstAnchor == vc.descriptionLabel.trailingAnchor &&
            (constraint.secondItem as? UIView) == vc.view &&
            constraint.secondAnchor == vc.view.trailingAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == -16 &&
            constraint.isActive == true
        }), "The view should have the constraint descriptionLabel.trailingAnchor == view.trailingAnchor - 16, but it wasn't found")
        
        // The closeButton's topAnchor should be equal to the view's topAnchor + 16
        XCTAssertTrue(vc.view.constraints.contains(where: { constraint in
            (constraint.firstItem as? UIButton) == vc.closeButton &&
            constraint.firstAnchor == vc.closeButton.topAnchor &&
            (constraint.secondItem as? UIView) == vc.view &&
            constraint.secondAnchor == vc.view.topAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == 16 &&
            constraint.isActive == true
        }), "The view should have the constraint closeButton.topAnchor == view.topAnchor + 16, but it wasn't found")
        
        // The closeButton's trailingAnchor should be equal to the view's trailingAnchor - 16
        XCTAssertTrue(vc.view.constraints.contains(where: { constraint in
            (constraint.firstItem as? UIButton) == vc.closeButton &&
            constraint.firstAnchor == vc.closeButton.trailingAnchor &&
            (constraint.secondItem as? UIView) == vc.view &&
            constraint.secondAnchor == vc.view.trailingAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == -16 &&
            constraint.isActive == true
        }), "The view should have the constraint closeButton.trailingAnchor == view.trailingAnchor - 16, but it wasn't found")
    }
    
    func testConfigure() throws {
        // Given the view controller with no description set
        vc.tvShowDescription = nil

        // When configure is called with a description
        let description = "Show description"
        vc.configure(description: description)
        
        // Then the view controller should contain the description
        XCTAssertEqual(vc.tvShowDescription, description, "The view controller should contain the description (\(description)), but it contained \(String(describing: vc.tvShowDescription))")
    }
    
    func testCloseButtonPressed() {
        class MockDescriptionVC: ShowDescriptionViewController {
            var dismissWasCalled: Bool = false
            override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
                dismissWasCalled = true
            }
        }
        
        // Given an instantiated vc
        let mockDescriptionVC = MockDescriptionVC()
        
        // When close button pressed is called
        mockDescriptionVC.closeButtonPressed()
        
        // Then dismiss should get called
        XCTAssertTrue(mockDescriptionVC.dismissWasCalled, "Dismiss should get called, mockDescriptionVC.dismissWasCalled should be true")
    }
}

