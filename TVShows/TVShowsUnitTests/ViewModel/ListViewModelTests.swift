//
//  ListViewModelTests.swift
//  TVShowsUnitTests
//
//  Created by José Damaren on 26/06/23.
//

import Foundation
import XCTest

@testable import TVShows

class ListViewModelTests: XCTestCase {
    var viewModel: ListViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = ListViewModel()
    }
    
    func testUpdateShows() throws {
        let tvShowResponses: [TVShowResponse] = [
            TVShowResponse(show: TVShow(id: 0)),
            TVShowResponse(show: TVShow(id: 1)),
            TVShowResponse(show: TVShow(id: 2)),
            TVShowResponse(show: TVShow(id: 3)),
            TVShowResponse(show: TVShow(id: 4)),
            TVShowResponse(show: TVShow(id: 5))
        ]
        viewModel.updateShows(forTVShowResponses: tvShowResponses)
        // the number of items in the shows array should be equal to the number of items received from the API
        XCTAssertEqual(viewModel.shows.count, tvShowResponses.count)
    }
}
