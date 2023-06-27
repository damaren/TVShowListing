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
    
    func testSeparateEpisodesBySeason() throws {
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
        viewModel.updateEpisodes(withEpisodes: episodes)
        XCTAssertEqual(viewModel.numberOfSections, 4)
        XCTAssertEqual(viewModel.getNumberOfRows(inSection: 0), 2)
        XCTAssertEqual(viewModel.getNumberOfRows(inSection: 1), 2)
        XCTAssertEqual(viewModel.getNumberOfRows(inSection: 2), 2)
        XCTAssertEqual(viewModel.getNumberOfRows(inSection: 3), 2)
    }
    
    func testRequestEpisodes() throws {
        viewModel.requestEpisodes(forShowId: 1, withProvider: MockProvider(shouldCompleteWithValue: true))
        XCTAssertEqual(viewModel.numberOfSections, 4)
        XCTAssertEqual(viewModel.getNumberOfRows(inSection: 0), 2)
        XCTAssertEqual(viewModel.getNumberOfRows(inSection: 1), 2)
        XCTAssertEqual(viewModel.getNumberOfRows(inSection: 2), 2)
        XCTAssertEqual(viewModel.getNumberOfRows(inSection: 3), 2)
        viewModel.requestEpisodes(forShowId: 1, withProvider: MockProvider(shouldCompleteWithValue: false))
        XCTAssertTrue(viewModel.episodes.isEmpty)
    }
}
