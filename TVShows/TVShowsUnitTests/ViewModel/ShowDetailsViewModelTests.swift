//
//  ShowDetailsViewModelTests.swift
//  TVShowsUnitTests
//
//  Created by José Damaren on 26/06/23.
//

import Foundation
import XCTest

@testable import TVShows

class ShowDetailsViewModelTests: XCTestCase {
    var viewModel: ShowDetailsViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = ShowDetailsViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
    }
    
    func testSeparateEpisodesBySeason() throws {
        // Given a list of episodes, each potentially belonging to a different season
        let episodes: [Episode] = [
            Episode(id: 0, season: 1),
            Episode(id: 1, season: 1),
            Episode(id: 2, season: 2),
            Episode(id: 3, season: 2),
            Episode(id: 4, season: 3),
            Episode(id: 5, season: 3),
            Episode(id: 6, season: 4),
            Episode(id: 7, season: 4)
        ]
        
        // When updateEpisodes is called
        viewModel.updateEpisodes(withEpisodes: episodes)
        
        // Then the list of episodes separated by seasons is generated
        XCTAssertEqual(viewModel.numberOfSections, 4, "The number of sections in the view model (\(viewModel.numberOfSections)) should be equal to the number of seasons (\(4))")
        
        // the item i contains the list of episodes in the season i + 1
        XCTAssertEqual(viewModel.getNumberOfRows(inSection: 0), 2)
        XCTAssertEqual(viewModel.getNumberOfRows(inSection: 1), 2)
        XCTAssertEqual(viewModel.getNumberOfRows(inSection: 2), 2)
        XCTAssertEqual(viewModel.getNumberOfRows(inSection: 3), 2)
    }
    
    func testRequestEpisodes_NonEmptyResponse() throws {
        // Given a response with a non empty list of episodes
        var episodes: [Episode] = []
        var episodesSeparatedBySeasons: [[Episode]] = []
        let numberOfSeasons = Int.random(in: 1...10)
        for i in 0..<numberOfSeasons {
            let numberOfEpisodesInSeason = Int.random(in: 1...10)
            var seasonEpisodes: [Episode] = []
            for j in 0..<numberOfEpisodesInSeason {
                let episode = Episode(season: i+1, number: j+1)
                seasonEpisodes.append(episode)
                episodes.append(episode)
            }
            episodesSeparatedBySeasons.append(seasonEpisodes)
        }
        let provider = MockProvider(episodes: episodes)
        
        // When a request is made that gives a non empty response
        viewModel.requestEpisodes(forShowId: 1, withProvider: provider)
        
        // Then the list of episodes separated by seasons is generated
        XCTAssertEqual(viewModel.numberOfSections, numberOfSeasons, "The number of sections in the view model (\(viewModel.numberOfSections)) should be equal to the number of seasons (\(numberOfSeasons))")
        
        // Then the item i contains the list of episodes in the season i + 1
        for i in 0..<numberOfSeasons {
            XCTAssertEqual(viewModel.getNumberOfRows(inSection: i), episodesSeparatedBySeasons[i].count, "The number of rows in section \(i) (\(viewModel.getNumberOfRows(inSection: i))) should be equal to the number of episodes in season \(i + 1) (\(episodesSeparatedBySeasons[i].count))")
        }
    }
    
    func testRequestEpisodes_EmptyResponse() throws {
        // Given a response with an empty list of episodes
        let episodes: [Episode] = []
        let provider = MockProvider(episodes: episodes)
        
        // When a request is made that gives an empty response
        viewModel.requestEpisodes(forShowId: 1, withProvider: provider)
        
        // Then the list of episodes in the view model should be empty
        XCTAssertEqual(viewModel.numberOfSections, episodes.count, "The number of sections in the view model (\(viewModel.numberOfSections)) should be equal to the number of seasons (\(episodes.count))")
        XCTAssertTrue(viewModel.episodes.isEmpty, "The 'episodes' array should be empty, but it contains \(viewModel.episodes.count) elements")
    }
    
    func testRequestEpisodes_ResponseError() throws {
        // Given a response with a response error
        let responseError: NetworkError = .responseError(description: "Mock response error")
        let provider = MockProvider(responseError: responseError)
        
        // When the request gives a response error
        viewModel.requestEpisodes(forShowId: 1, withProvider: provider)
        
        // Then the list of episodes in the view model should be empty
        XCTAssertEqual(viewModel.numberOfSections, 0, "The number of sections in the view model (\(viewModel.numberOfSections)) should be equal to zero")
        XCTAssertTrue(viewModel.episodes.isEmpty, "The 'episodes' array should be empty, but it contains \(viewModel.episodes.count) elements")
        // And the view model should contain the error
        XCTAssertEqual(viewModel.error, responseError, "The viewModel should contain the error '\(responseError)' but it contained '\(String(describing: viewModel.error))'")
    }
    
    func testRequestEpisodes_UrlCreationError() throws {
        // Given a response with a url creation error
        let urlCreationError: NetworkError = .urlCreationError(description: "invalid url string")
        let provider = MockProvider(urlCreationError: urlCreationError)
        
        // When a request is made that gives a response with a url creation error
        viewModel.requestEpisodes(forShowId: 1, withProvider: provider)
        
        // Then the list of episodes in the view model should be empty
        XCTAssertEqual(viewModel.numberOfSections, 0, "The number of sections in the view model (\(viewModel.numberOfSections)) should be equal to zero")
        XCTAssertTrue(viewModel.episodes.isEmpty, "The 'episodes' array should be empty, but it contains \(viewModel.episodes.count) elements")
        // And the view model should contain the error
        XCTAssertEqual(viewModel.error, urlCreationError, "The viewModel should contain the error '\(urlCreationError)' but it contained '\(String(describing: viewModel.error))'")
    }
    
    func testRequestEpisodes_JSONDecodeError() throws {
        // Given a response with a JSONDecode error
        let JSONDecodeError: NetworkError = .JSONDecodeError
        let provider = MockProvider(JSONDecodeError: JSONDecodeError)
        
        // When a request is made that gives a response with a JSONDecode error
        viewModel.requestEpisodes(forShowId: 1, withProvider: provider)
        
        // Then the list of episodes in the view model should be empty
        XCTAssertEqual(viewModel.numberOfSections, 0, "The number of sections in the view model (\(viewModel.numberOfSections)) should be equal to zero")
        XCTAssertTrue(viewModel.episodes.isEmpty, "The 'episodes' array should be empty, but it contains \(viewModel.episodes.count) elements")
        // And the view model should contain the error
        XCTAssertEqual(viewModel.error, JSONDecodeError, "The viewModel should contain the error '\(JSONDecodeError)' but it contained '\(String(describing: viewModel.error))'")
    }
}
