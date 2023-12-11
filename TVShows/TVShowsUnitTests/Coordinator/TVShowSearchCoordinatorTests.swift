//
//  TVShowSearchCoordinatorTests.swift
//  TVShowsUnitTests
//
//  Created by José Damaren on 04/10/23.
//

import XCTest

@testable import TVShows

final class TVShowSearchCoordinatorTests: XCTestCase {
    var coordinator: TVShowSearchCoordinator!

    override func setUp() {
        super.setUp()

        coordinator = TVShowSearchCoordinator()
    }

    override func tearDown() {
        super.tearDown()
        coordinator = nil
    }

    func testSelectedShow() throws {
        // Given the navigation controller with a TVShowSearchViewController
        coordinator.navigationController.setViewControllers([TVShowSearchViewController()], animated: false)
        
        // When selectedShow is called
        coordinator.selectedShow(show: TVShow(), withAnimation: false)
        
        // Then the navigation controller should have a ShowDetailsViewController on top of the TVShowSearchViewController
        XCTAssertTrue(coordinator.navigationController.viewControllers[0] is TVShowSearchViewController, "The navigation controller's first view controller should be a TVShowSearchViewController, but it was \(coordinator.navigationController.viewControllers[0])")
        XCTAssertTrue(coordinator.navigationController.viewControllers[1] is ShowDetailsViewController, "The navigation controller's second view controller should be a ShowDetailsViewController, but it was \(coordinator.navigationController.viewControllers[1])")
    }
    
    func testSelectedEpisode() throws {
        // Given the navigation controller with a TVShowSearchViewController and a ShowDetailsViewController
        coordinator.navigationController.setViewControllers([TVShowSearchViewController(), ShowDetailsViewController()], animated: false)
        
        coordinator.provider = MockProvider()
        
        // When selectedShow is called
        coordinator.selectedEpisode(episode: Episode(), withShowTitle: "", withAnimation: false)
        
        // Then the navigation controller should have an EpisodeInformationViewController on top of a ShowDetailsViewController on top of the TVShowSearchViewController
        XCTAssertTrue(coordinator.navigationController.viewControllers[0] is TVShowSearchViewController, "The navigation controller's first view controller should be a TVShowSearchViewController, but it was \(coordinator.navigationController.viewControllers[0])")
        XCTAssertTrue(coordinator.navigationController.viewControllers[1] is ShowDetailsViewController, "The navigation controller's second view controller should be a ShowDetailsViewController, but it was \(coordinator.navigationController.viewControllers[1])")
        XCTAssertTrue(coordinator.navigationController.viewControllers[2] is EpisodeInformationViewController, "The navigation controller's second view controller should be a EpisodeInformationViewController, but it was \(coordinator.navigationController.viewControllers[2])")
    }
    
    func testShowDetailsViewControllerBackButtonPressed() throws {
        // Given the navigation controller with a TVShowSearchViewController and a ShowDetailsViewController
        let showDetailsViewController = ShowDetailsViewController()
        coordinator.navigationController.setViewControllers([TVShowSearchViewController(), showDetailsViewController], animated: false)
        
        // When backButtonPressed is called
        coordinator.backButtonPressed(in: showDetailsViewController, withAnimation: false)
        
        // Then the navigation controller should only have a TVShowSearchViewController
        XCTAssertTrue(coordinator.navigationController.viewControllers[0] is TVShowSearchViewController, "The navigation controller's first view controller should be a TVShowSearchViewController, but it was \(coordinator.navigationController.viewControllers[0])")
        XCTAssertEqual(coordinator.navigationController.viewControllers.count, 1, "The navigation controller's stack should have one element (a TVShowSearchViewController), but it had \(coordinator.navigationController.viewControllers)")
    }
    
    func testEpisodeInformationViewControllerBackButtonPressed() throws {
        // Given the navigation controller with a TVShowSearchViewController, a ShowDetailsViewController and an EpisodeInformationViewController
        let episodeInformationViewController = EpisodeInformationViewController()
        coordinator.navigationController.setViewControllers([TVShowSearchViewController(), ShowDetailsViewController(), episodeInformationViewController], animated: false)
        
        // When backButtonPressed is called
        coordinator.backButtonPressed(inViewcontroller: episodeInformationViewController, withAnimation: false)
        
        // Then the navigation controller should only have a TVShowSearchViewController and a ShowDetailsViewController
        XCTAssertTrue(coordinator.navigationController.viewControllers[0] is TVShowSearchViewController, "The navigation controller's first view controller should be a TVShowSearchViewController, but it was \(coordinator.navigationController.viewControllers[0])")
        XCTAssertTrue(coordinator.navigationController.viewControllers[1] is ShowDetailsViewController, "The navigation controller's second view controller should be a ShowDetailsViewController, but it was \(coordinator.navigationController.viewControllers[1])")
        XCTAssertEqual(coordinator.navigationController.viewControllers.count, 2, "The navigation controller's stack should have two element (a TVShowSearchViewController and a ShowDetailsViewController), but it had \(coordinator.navigationController.viewControllers)")
    }
    
    func testShowDetailsViewControllerSeeMoreButtonPressed() throws {
        // Given the navigation controller with a TVShowSearchViewController and a ShowDetailsViewController
        let showDetailsViewController = ShowDetailsViewController()
        coordinator.navigationController.setViewControllers([TVShowSearchViewController(), showDetailsViewController], animated: false)
        
        let showSummary = "test show summary"
        
        // When seeMoreButtonPressed is called
        coordinator.seeMoreButtonPressed(in: showDetailsViewController, forShowSummary: showSummary)
        
        // Then the navigation controller should contain a TVShowSearchViewController and a ShowDetailsViewController
        XCTAssertTrue(coordinator.navigationController.viewControllers[0] is TVShowSearchViewController, "The navigation controller's first view controller should be a TVShowSearchViewController, but it was \(coordinator.navigationController.viewControllers[0])")
        XCTAssertTrue(coordinator.navigationController.viewControllers[1] is ShowDetailsViewController, "The navigation controller's second view controller should be a ShowDetailsViewController, but it was \(coordinator.navigationController.viewControllers[1])")
        XCTAssertEqual(coordinator.navigationController.viewControllers.count, 2, "The navigation controller's stack should have two elements (a TVShowSearchViewController and a ShowDetailsViewController), but it had \(coordinator.navigationController.viewControllers)")
    }

}
