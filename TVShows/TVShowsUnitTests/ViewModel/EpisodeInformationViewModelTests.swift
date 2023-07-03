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
    
    func testGetSeasonAndNumberText() throws {
        // Given an episode
        let episode: Episode = Episode(id: 1, season: 1, number: 5)
        viewModel.episode = episode
        
        // When we call the season and number getter
        let seasonAndNumberText = viewModel.getSeasonAndNumberText()
        
        // Then we get the correct value back
        XCTAssertEqual(seasonAndNumberText, "S1E5:", "The season and number getter returned '\(seasonAndNumberText)' but should have returned 'S1E5:'")
    }
}
