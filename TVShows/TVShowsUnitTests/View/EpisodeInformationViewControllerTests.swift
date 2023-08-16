//
//  EpisodeInformationViewControllerTests.swift
//  TVShowsUnitTests
//
//  Created by José Damaren on 10/08/23.
//

import XCTest

@testable import TVShows

final class EpisodeInformationViewControllerTests: XCTestCase {

    var vc: EpisodeInformationViewController!
    
    override func setUp() {
        super.setUp()

        vc = EpisodeInformationViewController()
    }

    override func tearDown() {
        super.tearDown()
        vc = nil
    }
    
    func testSetup() throws {
        // Given the instantiated vc not yet set up
        // The configured view model
        vc.viewModel = EpisodeInformationViewModel()
        let season = 2
        let number = 3
        let episodeName = "Episode Name"
        let summary = "Episode summary"
        let episode = Episode(id: 1, name: episodeName, season: season, number: number, summary: summary)
        let showTitle = "Show title"
        vc.configure(forEpisode: episode, andShowTitle: showTitle)
        
        // When setup is called
        vc.setup()
        
        // Then
        // The vc's title should be the show title
        XCTAssertEqual(vc.title, showTitle, "The vc's title should be the show title (\(showTitle)), but it is \(String(describing: vc.title))")
        
        // The backgroundColor should be .systemBackground
        XCTAssertEqual(vc.view.backgroundColor, .systemBackground, "The backgroundColor should be .systemBackground, but it is \(String(describing: vc.view.backgroundColor))")
        
        // The leftBarButtonItem's image should be UIImage(systemName: "chevron.left")
        XCTAssertEqual(vc.navigationItem.leftBarButtonItem?.image, UIImage(systemName: "chevron.left"), "The leftBarButtonItem's image should be UIImage(systemName: 'chevron.left'), but it is \(String(describing: vc.navigationItem.leftBarButtonItem?.image))")
        
        // The leftBarButtonItem's tintColor should be .label
        XCTAssertEqual(vc.navigationItem.leftBarButtonItem?.tintColor, .label, "The leftBarButtonItem's tintColor should be .label, but it is \(String(describing: vc.navigationItem.leftBarButtonItem?.tintColor))")

        // The imageView's translatesAutoresizingMaskIntoConstraints should be false
        XCTAssertFalse(vc.imageView.translatesAutoresizingMaskIntoConstraints, "The imageView's translatesAutoresizingMaskIntoConstraints should be false")

        // The imageView's image should be UIImage(systemName: "photo.artframe")
        XCTAssertEqual(vc.imageView.image, UIImage(systemName: "photo.artframe"), "The imageView's image should be UIImage(systemName: 'photo.artframe'), but it is \(String(describing: vc.imageView.image))")

        // The imageView's tintColor should be .label
        XCTAssertEqual(vc.imageView.tintColor, .label, "The imageView's tintColor should be .label, but it is \(String(describing: vc.imageView.tintColor))")
        
        // The imageView's contentMode should be .scaleAspectFit
        XCTAssertEqual(vc.imageView.contentMode, .scaleAspectFit, "The imageView's contentMode should be .scaleAspectFit, but it is \(String(describing: vc.imageView.contentMode))")
        
        // The seasonAndNumberLabel's translatesAutoresizingMaskIntoConstraints should be false
        XCTAssertFalse(vc.seasonAndNumberLabel.translatesAutoresizingMaskIntoConstraints, "The seasonAndNumberLabel's translatesAutoresizingMaskIntoConstraints should be false")
        
        // The seasonAndNumberLabel's text should be "S<season>E<number>:"
        XCTAssertEqual(vc.seasonAndNumberLabel.text, "S\(season)E\(number):", "The seasonAndNumberLabel's text should be S\(season)E\(number):, but it is \(String(describing: vc.seasonAndNumberLabel.text))")
        
        // The episodeNameLabel's translatesAutoresizingMaskIntoConstraints should be false
        XCTAssertFalse(vc.episodeNameLabel.translatesAutoresizingMaskIntoConstraints, "The episodeNameLabel's translatesAutoresizingMaskIntoConstraints should be false")
        
        // The episodeNameLabel's textAlignment should be .left
        XCTAssertEqual(vc.episodeNameLabel.textAlignment, .left, "The episodeNameLabel's textAlignment should be .left, but it is \(vc.episodeNameLabel.textAlignment)")
        
        // The episodeNameLabel's font should be .systemFont(ofSize: 20, weight: .semibold)
        XCTAssertEqual(vc.episodeNameLabel.font, .systemFont(ofSize: 20, weight: .semibold), "The episodeNameLabel's font should be .systemFont(ofSize: 20, weight: .semibold), but it is \(String(describing: vc.episodeNameLabel.font))")
        
        // The episodeNameLabel's numberOfLines should be 0
        XCTAssertEqual(vc.episodeNameLabel.numberOfLines, 0, "The episodeNameLabel's numberOfLines should be 0, but it is \(vc.episodeNameLabel.numberOfLines)")
        
        // The episodeNameLabel's text should be the episode's name
        XCTAssertEqual(vc.episodeNameLabel.text, episodeName, "The episodeNameLabel's text should be the episode's name, but it is \(String(describing: vc.episodeNameLabel.text))")

        // The summaryLabel's translatesAutoresizingMaskIntoConstraints should be false
        XCTAssertFalse(vc.summaryLabel.translatesAutoresizingMaskIntoConstraints, "The summaryLabel's translatesAutoresizingMaskIntoConstraints should be false")
        
        // The summaryLabe's numberOfLines should be 0
        XCTAssertEqual(vc.summaryLabel.numberOfLines, 0, "The summaryLabe's numberOfLines should be 0, but it is \(vc.summaryLabel.numberOfLines)")
        
        // The summaryLabel's text should be <summary>
        XCTAssertEqual(vc.summaryLabel.text, summary, "The summaryLabel's text should be \(summary), but it is \(String(describing: vc.summaryLabel.text))")
    }
    
    func testLayoutViews() throws {
        // Given the instantiated view controller not yet laid out
        
        // The imageView's image equal to nil
        vc.imageView.image = nil
        
        // When layoutViews is called
        vc.layoutViews()
        
        // Then
        
        // The view should contain the imageView
        XCTAssertTrue(vc.view.subviews.contains(vc.imageView), "The view should contain the imageView")
        
        // The view should contain the seasonAndNumberLabel
        XCTAssertTrue(vc.view.subviews.contains(vc.seasonAndNumberLabel), "The view should contain the seasonAndNumberLabel")
        
        // The view should contain the episodeNameLabel
        XCTAssertTrue(vc.view.subviews.contains(vc.episodeNameLabel), "The view should contain the episodeNameLabel")
        
        // The view should contain the summaryLabel
        XCTAssertTrue(vc.view.subviews.contains(vc.summaryLabel), "The view should contain the summaryLabel")

        // The imageView's topAnchor should be equal to the safeAreaLayoutGuide's topAnchor + EpisodeInformationViewController.verticalMargin
        XCTAssertTrue(vc.view.constraints.contains(where: { constraint in
            (constraint.firstItem as? UIImageView) == vc.imageView &&
            constraint.firstAnchor == vc.imageView.topAnchor &&
            (constraint.secondItem as? UILayoutGuide) == vc.view.safeAreaLayoutGuide &&
            constraint.secondAnchor == vc.view.safeAreaLayoutGuide.topAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == EpisodeInformationViewController.verticalMargin &&
            constraint.isActive == true
        }), "The view should have the constraint imageView.topAnchor == safeAreaLayoutGuide.topAnchor + \(EpisodeInformationViewController.verticalMargin), but it wasn't found")
        
        // The imageView's centerXAnchor should be equal to the view's centerXAnchor
        XCTAssertTrue(vc.view.constraints.contains(where: { constraint in
            (constraint.firstItem as? UIImageView) == vc.imageView &&
            constraint.firstAnchor == vc.imageView.centerXAnchor &&
            (constraint.secondItem as? UIView) == vc.view &&
            constraint.secondAnchor == vc.view.centerXAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == 0 &&
            constraint.isActive == true
        }), "The view should have the constraint imageView.centerXAnchor == view.centerXAnchor, but it wasn't found")
        
        // The imageView's widthAnchor should be equal to view.frame.width - 2 * horizontalMargin
        XCTAssertTrue(vc.imageView.constraints.contains(where: { constraint in
            (constraint.firstItem as? UIImageView) == vc.imageView &&
            constraint.firstAnchor == vc.imageView.widthAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == (vc.view.frame.width) + (-2*EpisodeInformationViewController.horizontalMargin) &&
            constraint.isActive == true
        }), "The imageView should have the constraint imageView.widthAnchor == view.frame.width - 2 * horizontalMargin, but it wasn't found")
        
        // The imageView's heightAnchor should be equal to (view.frame.width - 2 * horizontalMargin) / imageAspectRatio
        XCTAssertTrue(vc.imageView.constraints.contains(where: { constraint in
            (constraint.firstItem as? UIImageView) == vc.imageView &&
            constraint.firstAnchor == vc.imageView.heightAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == ((vc.view.frame.width) + (-2*EpisodeInformationViewController.horizontalMargin)) / vc.imageAspectRatio &&
            constraint.isActive == true
        }), "The imageView should have the constraint imageView.heightAnchor == (view.frame.width - 2 * horizontalMargin) / imageAspectRatio, but it wasn't found")
        
        // The seasonAndNumberLabel's lastBaselineAnchor should be equal to the episodeNameLabel's firstBaselineAnchor
        XCTAssertTrue(vc.view.constraints.contains(where: { constraint in
            (constraint.firstItem as? UILabel) == vc.seasonAndNumberLabel &&
            constraint.firstAnchor == vc.seasonAndNumberLabel.lastBaselineAnchor &&
            (constraint.secondItem as? UILabel) == vc.episodeNameLabel &&
            constraint.secondAnchor == vc.episodeNameLabel.firstBaselineAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == 0 &&
            constraint.isActive == true
        }), "The view should have the constraint seasonAndNumberLabel.lastBaselineAnchor == episodeNameLabel.firstBaselineAnchor, but it wasn't found")
        
        // The seasonAndNumberLabel's leadingAnchor should be equal to the view's leadingAnchor + EpisodeInformationViewController.horizontalMargin
        XCTAssertTrue(vc.view.constraints.contains(where: { constraint in
            (constraint.firstItem as? UILabel) == vc.seasonAndNumberLabel &&
            constraint.firstAnchor == vc.seasonAndNumberLabel.leadingAnchor &&
            (constraint.secondItem as? UIView) == vc.view &&
            constraint.secondAnchor == vc.view.leadingAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == EpisodeInformationViewController.horizontalMargin &&
            constraint.isActive == true
        }), "The view should have the constraint seasonAndNumberLabel.leadingAnchor == view.leadingAnchor + \(EpisodeInformationViewController.horizontalMargin), but it wasn't found")
        
        // The seasonAndNumberLabel's contentHuggingPriority for .horizontal should be .defaultHigh
        XCTAssertEqual(vc.seasonAndNumberLabel.contentHuggingPriority(for: .horizontal), .defaultHigh, "The seasonAndNumberLabel's contentHuggingPriority for .horizontal should be .defaultHigh, but it is \(vc.seasonAndNumberLabel.contentHuggingPriority(for: .horizontal))")
        
        // The episodeNameLabel's topAnchor should be equal to the safeAreaLayoutGuide.topAnchor + EpisodeInformationViewController.verticalMargin
        XCTAssertTrue(vc.view.constraints.contains(where: { constraint in
            (constraint.firstItem as? UILabel) == vc.episodeNameLabel &&
            constraint.firstAnchor == vc.episodeNameLabel.topAnchor &&
            (constraint.secondItem as? UILayoutGuide) == vc.view.safeAreaLayoutGuide &&
            constraint.secondAnchor == vc.view.safeAreaLayoutGuide.topAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == EpisodeInformationViewController.verticalMargin &&
            constraint.isActive == true
        }), "The view should have the constraint episodeNameLabel.topAnchor == safeAreaLayoutGuide.topAnchor + \(EpisodeInformationViewController.verticalMargin), but it wasn't found")
        
        // The episodeNameLabel's leadingAnchor should be equal to the seasonAndNumberLabel.trailingAnchor + horizontalMargin
        XCTAssertTrue(vc.view.constraints.contains(where: { constraint in
            (constraint.firstItem as? UILabel) == vc.episodeNameLabel &&
            constraint.firstAnchor == vc.episodeNameLabel.leadingAnchor &&
            (constraint.secondItem as? UILabel) == vc.seasonAndNumberLabel &&
            constraint.secondAnchor == vc.seasonAndNumberLabel.trailingAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == EpisodeInformationViewController.horizontalMargin &&
            constraint.isActive == true
        }), "The view should have the constraint episodeNameLabel.leadingAnchor == seasonAndNumberLabel.trailingAnchor + \(EpisodeInformationViewController.horizontalMargin), but it wasn't found")

        // The episodeNameLabel's trailingAnchor should be equal to the view.trailingAnchor - horizontalMargin
        XCTAssertTrue(vc.view.constraints.contains(where: { constraint in
            (constraint.firstItem as? UILabel) == vc.episodeNameLabel &&
            constraint.firstAnchor == vc.episodeNameLabel.trailingAnchor &&
            (constraint.secondItem as? UIView) == vc.view &&
            constraint.secondAnchor == vc.view.trailingAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == -EpisodeInformationViewController.horizontalMargin &&
            constraint.isActive == true
        }), "The view should have the constraint episodeNameLabel.trailingAnchor == view.trailingAnchor - \(EpisodeInformationViewController.horizontalMargin), but it wasn't found")
        
        // The episodeNameLabel's contentHuggingPriority for .horizontal should be .defaultLow
        XCTAssertEqual(vc.episodeNameLabel.contentHuggingPriority(for: .horizontal), .defaultLow, "The episodeNameLabel's contentHuggingPriority for .horizontal should be .defaultLow, but it is \(vc.episodeNameLabel.contentHuggingPriority(for: .horizontal))")
        
        // The summaryLabel's topAnchor should be equal to the episodeNameLabel.bottomAnchor + verticalMargin
        XCTAssertTrue(vc.view.constraints.contains(where: { constraint in
            (constraint.firstItem as? UILabel) == vc.summaryLabel &&
            constraint.firstAnchor == vc.summaryLabel.topAnchor &&
            (constraint.secondItem as? UILabel) == vc.episodeNameLabel &&
            constraint.secondAnchor == vc.episodeNameLabel.bottomAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == EpisodeInformationViewController.verticalMargin &&
            constraint.isActive == true
        }), "The view should have the constraint summaryLabel.topAnchor == episodeNameLabel.bottomAnchor + \(EpisodeInformationViewController.verticalMargin), but it wasn't found")
        
        // The summaryLabel's leadingAnchor should be equal to the view.leadingAnchor + horizontalMargin
        XCTAssertTrue(vc.view.constraints.contains(where: { constraint in
            (constraint.firstItem as? UILabel) == vc.summaryLabel &&
            constraint.firstAnchor == vc.summaryLabel.leadingAnchor &&
            (constraint.secondItem as? UIView) == vc.view &&
            constraint.secondAnchor == vc.view.leadingAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == EpisodeInformationViewController.horizontalMargin &&
            constraint.isActive == true
        }), "The view should have the constraint summaryLabel.leadingAnchor == view.leadingAnchor + \(EpisodeInformationViewController.horizontalMargin), but it wasn't found")
        
        // The summaryLabel's trailingAnchor should be equal to the view.trailingAnchor - horizontalMargin
        XCTAssertTrue(vc.view.constraints.contains(where: { constraint in
            (constraint.firstItem as? UILabel) == vc.summaryLabel &&
            constraint.firstAnchor == vc.summaryLabel.trailingAnchor &&
            (constraint.secondItem as? UIView) == vc.view &&
            constraint.secondAnchor == vc.view.trailingAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == -EpisodeInformationViewController.horizontalMargin &&
            constraint.isActive == true
        }), "The view should have the constraint summaryLabel.trailingAnchor == view.trailingAnchor - \(EpisodeInformationViewController.horizontalMargin), but it wasn't found")
    }
    
    func testConfigure() throws {
        // Given the instantiated view controller
        
        // The viewModel with no episode nor title set
        vc.viewModel.episode = nil
        vc.viewModel.showTitle = nil
        
        // When configure is called
        let episode = Episode(id: 1)
        let showTitle = "Show title"
        vc.configure(forEpisode: episode, andShowTitle: showTitle)
        
        // Then
        // The viewModel should contain the episode
        XCTAssertEqual(vc.viewModel.episode, episode, "The viewModel should contain the episode \(episode), but it contains \(String(describing: vc.viewModel.episode))")
        // The viewModel should contain the showTitle
        XCTAssertEqual(vc.viewModel.showTitle, showTitle, "The viewModel should contain the showTitle \(showTitle), but it contains \(String(describing: vc.viewModel.showTitle))")
    }
    
    func testUpdateView() throws {
        // Given the imageView with no image
        vc.imageView.image = nil
        
        let expectation = self.expectation(description: "EpisodeInformationViewController updateView expectation")

        // When updateView is called with a given image
        let image = UIImage(systemName: "xmark")
        vc.updateView(forImage: image, completion: {
            // Then the imageView contains the given image
            XCTAssertEqual(self.vc.imageView.image, image, "The vc should contain the image \(String(describing: UIImage(systemName: "xmark"))) but it contains \(String(describing: self.vc.imageView.image))")
            expectation.fulfill()
        })

        self.wait(for: [expectation], timeout: 5)
    }

    func testBackButtonPressed() throws {
        // Given the instantiated viewController
        
        // With the delegate set
        class MockDelegate: EpisodeInformationViewControllerDelegate {
            func backButtonPressed(inViewcontroller: TVShows.EpisodeInformationViewController, withAnimation: Bool) {
                wasBackButtonPressedCalled = true
            }
            
            var wasBackButtonPressedCalled = false
        }
        let mockDelegate = MockDelegate()
        vc.delegate = mockDelegate
        
        // When backButtonPressed is called
        vc.backButtonPressed()
        
        // Then the delegate's backButtonPressed method should get called
        XCTAssertTrue(mockDelegate.wasBackButtonPressedCalled, "The delegate's backButtonPressed method should get called, mockDelegate.wasBackButtonPressedCalled should be true")
    }
}
