//
//  AppDelegateTests.swift
//  TVShowsUnitTests
//
//  Created by José Damaren on 17/07/23.
//

import XCTest

@testable import TVShows

final class AppDelegateTests: XCTestCase {
    var appDelegate: AppDelegate!

    override func setUp() {
        super.setUp()

        appDelegate = AppDelegate()
    }

    override func tearDown() {
        super.tearDown()
        appDelegate = nil
    }

    func testSelectedShow() throws {
        // Given the navigation controller with a ListViewController
        appDelegate.navigationController.setViewControllers([ListViewController()], animated: false)
        
        // When selectedShow is called
        appDelegate.selectedShow(show: TVShow(), withAnimation: false)
        
        // Then the navigation controller should have a ShowDetailsViewController on top of the ListViewController
        print(appDelegate.navigationController.viewControllers)
        XCTAssertTrue(appDelegate.navigationController.viewControllers[0] is ListViewController, "The navigation controller's first view controller should be a ListViewController, but it was \(appDelegate.navigationController.viewControllers[0])")
        XCTAssertTrue(appDelegate.navigationController.viewControllers[1] is ShowDetailsViewController, "The navigation controller's second view controller should be a ShowDetailsViewController, but it was \(appDelegate.navigationController.viewControllers[1])")
    }
    
    func testSelectedEpisode() throws {
        // Given the navigation controller with a ListViewController and a ShowDetailsViewController
        appDelegate.navigationController.setViewControllers([ListViewController(), ShowDetailsViewController()], animated: false)
        
        // When selectedShow is called
        appDelegate.selectedEpisode(episode: Episode(), withShowTitle: "", withAnimation: false)
        
        // Then the navigation controller should have an EpisodeInformationViewController on top of a ShowDetailsViewController on top of the ListViewController
        print(appDelegate.navigationController.viewControllers)
        XCTAssertTrue(appDelegate.navigationController.viewControllers[0] is ListViewController, "The navigation controller's first view controller should be a ListViewController, but it was \(appDelegate.navigationController.viewControllers[0])")
        XCTAssertTrue(appDelegate.navigationController.viewControllers[1] is ShowDetailsViewController, "The navigation controller's second view controller should be a ShowDetailsViewController, but it was \(appDelegate.navigationController.viewControllers[1])")
        XCTAssertTrue(appDelegate.navigationController.viewControllers[2] is EpisodeInformationViewController, "The navigation controller's second view controller should be a EpisodeInformationViewController, but it was \(appDelegate.navigationController.viewControllers[2])")
    }
    
    func testShowDetailsViewControllerBackButtonPressed() throws {
        // Given the navigation controller with a ListViewController and a ShowDetailsViewController
        let showDetailsViewController = ShowDetailsViewController()
        appDelegate.navigationController.setViewControllers([ListViewController(), showDetailsViewController], animated: false)
        
        // When backButtonPressed is called
        appDelegate.backButtonPressed(inViewcontroller: showDetailsViewController, withAnimation: false)
        
        // Then the navigation controller should only have a ListViewController
        print(appDelegate.navigationController.viewControllers)
        XCTAssertTrue(appDelegate.navigationController.viewControllers[0] is ListViewController, "The navigation controller's first view controller should be a ListViewController, but it was \(appDelegate.navigationController.viewControllers[0])")
        XCTAssertEqual(appDelegate.navigationController.viewControllers.count, 1, "The navigation controller's stack should have one element (a ListViewController), but it had \(appDelegate.navigationController.viewControllers)")
    }
    
    func testEpisodeInformationViewControllerBackButtonPressed() throws {
        // Given the navigation controller with a ListViewController, a ShowDetailsViewController and an EpisodeInformationViewController
        let episodeInformationViewController = EpisodeInformationViewController()
        appDelegate.navigationController.setViewControllers([ListViewController(), ShowDetailsViewController(), episodeInformationViewController], animated: false)
        
        // When backButtonPressed is called
        appDelegate.backButtonPressed(inViewcontroller: episodeInformationViewController, withAnimation: false)
        
        // Then the navigation controller should only have a ListViewController and a ShowDetailsViewController
        print(appDelegate.navigationController.viewControllers)
        XCTAssertTrue(appDelegate.navigationController.viewControllers[0] is ListViewController, "The navigation controller's first view controller should be a ListViewController, but it was \(appDelegate.navigationController.viewControllers[0])")
        XCTAssertTrue(appDelegate.navigationController.viewControllers[1] is ShowDetailsViewController, "The navigation controller's second view controller should be a ShowDetailsViewController, but it was \(appDelegate.navigationController.viewControllers[1])")
        XCTAssertEqual(appDelegate.navigationController.viewControllers.count, 2, "The navigation controller's stack should have two element (a ListViewController and a ShowDetailsViewController), but it had \(appDelegate.navigationController.viewControllers)")
    }

}
