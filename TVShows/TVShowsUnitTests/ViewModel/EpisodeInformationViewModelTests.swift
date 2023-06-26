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
    
    func testGetSeasonAndNumberText() throws {
        let episode: Episode = Episode(id: 1, season: 1, number: 5)
        viewModel.episode = episode
        XCTAssertEqual(viewModel.getSeasonAndNumberText(), "S1E5:")
    }
}
