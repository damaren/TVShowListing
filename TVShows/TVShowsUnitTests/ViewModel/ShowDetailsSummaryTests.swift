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
    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
    }
    
    func testGettters() throws {
        // Given a show with genres, schedule and summary
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
        
        // When we call the getters
        let genresText = viewModel.getGenresLabelText()
        let timeText = viewModel.getTimesLabelText()
        let daysText = viewModel.getDaysLabelText()
        let summaryText = viewModel.getSummaryText()
        
        // Then we get the correct values
        XCTAssertEqual(genresText, "Genres: Drama, Crime, Thriller", "The genres getter returned '\(genresText)' but should have returned 'Genres: Drama, Crime, Thriller'")
        XCTAssertEqual(timeText, "Time: 22:00", "The time getter returned '\(timeText)' but should have returned 'Time: 22:00'")
        XCTAssertEqual(daysText, "Days: Sunday", "The days getter returned '\(daysText)' but should have returned 'Days: Sunday'")
        XCTAssertEqual(summaryText, "Show summary", "The summary getter returned '\(summaryText)' but should have returned 'Show summary'")
    }
}
