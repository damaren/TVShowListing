//
//  EpisodeInformationViewModelTests.swift
//  TVShowsUnitTests
//
//  Created by José Damaren on 26/06/23.
//

import Foundation
import XCTest

@testable import TVShows

class EpisodeInformationViewModelTests: XCTestCase {
    var viewModel: EpisodeInformationViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = EpisodeInformationViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
    }
    
    func testGetSeasonAndNumberText_InfoIsAvailable() throws {
        // Given an episode with season and number set
        let season: Int = 8
        let number: Int = 27
        let episode: Episode = Episode(id: 1, season: season, number: number)
        viewModel.episode = episode
        
        // When we call the season and number getter
        let seasonAndNumberText = viewModel.getSeasonAndNumberText()
        
        // Then we get the correct text back
        let expectedText: String = "S\(season)E\(number):"
        XCTAssertEqual(seasonAndNumberText, expectedText, "The season and number getter returned '\(seasonAndNumberText)' but should have returned '\(expectedText)'")
    }
    
    func testGetSeasonAndNumberText_InfoIsNotAvailable() throws {
        // Given an episode without information about season and number
        let episode: Episode = Episode(id: 1)
        viewModel.episode = episode
        
        // When we call the season and number getter
        let seasonAndNumberText = viewModel.getSeasonAndNumberText()
        
        // Then we get the message saying that the info was not available
        XCTAssertEqual(seasonAndNumberText, EpisodeInformationViewModel.noSeasonAndNumberMessage, "The season and number getter returned '\(seasonAndNumberText)' but should have returned '\(EpisodeInformationViewModel.noSeasonAndNumberMessage)'")
    }
    
    func testGetEpisodeNameText_InfoIsAvailable() throws {
        // Given an episode with a name set
        let episodeName: String = "Episode Name"
        let episode: Episode = Episode(id: 1, name: episodeName)
        viewModel.episode = episode
        
        // When we call getEpisodeNameText
        let episodeNameText = viewModel.getEpisodeNameText()
        
        // Then we get the correct name
        XCTAssertEqual(episodeNameText, episodeName, "getEpisodeNameText() returned '\(episodeNameText)' but should have returned '\(episodeName)'")
    }
    
    func testGetEpisodeNameText_InfoIsNotAvailable() throws {
        // Given an episode with no name set
        let episode: Episode = Episode(id: 1)
        viewModel.episode = episode
        
        // When we call getEpisodeNameText
        let episodeNameText = viewModel.getEpisodeNameText()
        
        // Then we get the message saying that the name was not available
        XCTAssertEqual(episodeNameText, EpisodeInformationViewModel.noEpisodeNameMessage, "getEpisodeNameText() returned '\(episodeNameText)' but should have returned '\(EpisodeInformationViewModel.noEpisodeNameMessage)'")
    }
    
    func testGetSummaryText_InfoIsAvailable() throws {
        // Given an episode with a summary set
        let episodeSummary: String = "Episode summary"
        let episode: Episode = Episode(id: 1, summary: episodeSummary)
        viewModel.episode = episode
        
        // When we call getSummaryText
        let episodeSummaryText = viewModel.getSummaryText()
        
        // Then we get the correct summary
        XCTAssertEqual(episodeSummaryText, episodeSummary, "getSummaryText() returned '\(episodeSummaryText)' but should have returned '\(episodeSummary)'")
    }
    
    func testGetSummaryText_InfoIsNotAvailable() throws {
        // Given an episode with no summary set
        let episode: Episode = Episode(id: 1)
        viewModel.episode = episode
        
        // When we call getSummaryText
        let episodeSummaryText = viewModel.getSummaryText()
        
        // Then we get the message saying that the summary was not available
        XCTAssertEqual(episodeSummaryText, EpisodeInformationViewModel.noSummaryMessage, "getSummaryText() returned '\(episodeSummaryText)' but should have returned '\(EpisodeInformationViewModel.noSummaryMessage)'")
    }
    
    func testConfigure() throws {
        // Given the view model with no episode or show title set
        viewModel.episode = nil
        viewModel._showTitle = nil
        // Given an episode and show title
        let episode = Episode(id: 1)
        let showTitle = "Show Title"
        
        class MockView: EpisodeInformationViewProtocol {
            func updateView(forImage image: UIImage?, completion: (() -> ())?) {}
            func updateViewForError() {}
        }
        
        // When we call configure with the episode and show title
        viewModel.configure(view: MockView(), forEpisode: episode, andShowTitle: showTitle, withProvider: MockProvider())
        
        // Then the view model contains the episode and the show title
        XCTAssertEqual(viewModel.episode, episode, "The view model should contain the episode with id \(String(describing: episode.id)) but contained \(String(describing: viewModel.episode))")
        XCTAssertEqual(viewModel.showTitle, showTitle, "The view model should contain the showTitle \(showTitle) but contained \(String(describing: viewModel.showTitle))")
    }
    
    func testRequestImage_NotNil() throws {
        // Given a not nil image in a URL
        let image = UIImage()
        let provider = MockProvider(image: image)
        
        // When a request is made the locates and returns the image
        viewModel.requestImage(forUrl: "", withProvider: provider)
        
        // Then the image in the view model is not nil
        XCTAssertNotNil(viewModel.image, "The image in the view model was nil, but it should have a not nil value")
    }
    
    func testRequestImage_Nil() throws {
        // Given URL that has no image in it
        let image: UIImage? = nil
        let provider = MockProvider(image: image)
        
        // When a request is made to that URL
        viewModel.requestImage(forUrl: "", withProvider: provider)
        
        // Then the image in the view model is nil
        XCTAssertNil(viewModel.image, "The image in the view model was not nil, but it should have have been nil")
    }
    
    func testRequestImage_ResponseError() throws {
        // Given a response with a response error
        let responseError: NetworkError = .responseError(description: "Mock response error")
        let provider = MockProvider(responseError: responseError)
        
        // When the request returns a response error
        viewModel.requestImage(forUrl: "", withProvider: provider)
        
        // Then the image in the view model is nil
        XCTAssertNil(viewModel.image, "The image in the view model was not nil, but it should have have been nil")
        // And the view model contains the error
        XCTAssertEqual(viewModel.networkError, responseError, "The viewModel should contain the error '\(responseError)' but it contained '\(String(describing: viewModel.networkError))'")
    }
    
    func testRequestImage_UrlCreationError() throws {
        // Given a response with a url creation error
        let urlCreationError: NetworkError = .urlCreationError(description: "invalid url string")
        let provider = MockProvider(urlCreationError: urlCreationError)
        
        // When the request gives a url creation error
        viewModel.requestImage(forUrl: "", withProvider: provider)
        
        // Then the image in the view model is nil
        XCTAssertNil(viewModel.image, "The image in the view model was not nil, but it should have have been nil")
        // And the view model contains the error
        XCTAssertEqual(viewModel.networkError, urlCreationError, "The viewModel should contain the error '\(urlCreationError)' but it contained '\(String(describing: viewModel.networkError))'")
    }
}
