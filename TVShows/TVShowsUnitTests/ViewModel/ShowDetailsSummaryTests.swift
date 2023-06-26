//
//  ShowDetailsSummaryTests.swift
//  TVShowsUnitTests
//
//  Created by José Damaren on 26/06/23.
//

import Foundation
import XCTest

@testable import TVShows

class ShowDetailsSummaryTests: XCTestCase {
    var viewModel: ShowDetailsSummaryViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = ShowDetailsSummaryViewModel()
    }
    
    func testGettters() throws {
        let show: TVShow = TVShow(
            id: 1,
            genres: [
                "Drama",
                "Crime",
                "Thriller"
            ],
            schedule: Schedule(
                time: "22:00",
                days: ["Sunday"]
            ),
            summary: "Show summary"
        )
        viewModel.show = show
        XCTAssertEqual(viewModel.getGenresLabelText(), "Genres: Drama, Crime, Thriller")
        XCTAssertEqual(viewModel.getTimesLabelText(), "Time: 22:00")
        XCTAssertEqual(viewModel.getDaysLabelText(), "Days: Sunday")
        XCTAssertEqual(viewModel.getSummaryText(), "Show summary")
    }
}
