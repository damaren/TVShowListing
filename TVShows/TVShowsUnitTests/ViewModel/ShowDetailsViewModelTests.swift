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
            Episode(id: 0, season: 2),
            Episode(id: 1, season: 2),
            Episode(id: 0, season: 3),
            Episode(id: 1, season: 3),
            Episode(id: 0, season: 4),
            Episode(id: 1, season: 4)
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
        let shouldGiveNonEmptyResponse: Bool = true
        
        // When a request is made that gives a non empty response
        viewModel.requestEpisodes(forShowId: 1, withProvider: MockProvider(shouldCompleteWithValue: shouldGiveNonEmptyResponse))
        
        // Then the list of episodes separated by seasons is generated
        XCTAssertEqual(viewModel.numberOfSections, 4, "The number of sections in the view model (\(viewModel.numberOfSections)) should be equal to the number of seasons (\(4))")
        
        // the item i contains the list of episodes in the season i + 1
        XCTAssertEqual(viewModel.getNumberOfRows(inSection: 0), 2)
        XCTAssertEqual(viewModel.getNumberOfRows(inSection: 1), 2)
        XCTAssertEqual(viewModel.getNumberOfRows(inSection: 2), 2)
        XCTAssertEqual(viewModel.getNumberOfRows(inSection: 3), 2)
    }
    
    func testRequestEpisodes_EmptyResponse() throws {
        // Given a response with an empty list of episodes
        let shouldGiveNonEmptyResponse: Bool = false
        
        // When a request is made that gives an empty response
        viewModel.requestEpisodes(forShowId: 1, withProvider: MockProvider(shouldCompleteWithValue: shouldGiveNonEmptyResponse))
        
        // Then the list of episodes in the view model should be empty
        XCTAssertEqual(viewModel.numberOfSections, 0, "The number of sections in the view model (\(viewModel.numberOfSections)) should be equal to the number of seasons (\(0))")
    }
}
