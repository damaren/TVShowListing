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
    
    func testRequestImage_NotNil() throws {
        // Given a not nil image in a URL with no error
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
        // Given a response with an error
        let responseError: NetworkError = .responseError(description: "Mock response error")
        let provider = MockProvider(responseError: responseError)
        
        // When a request is made that returns an error
        viewModel.requestImage(forUrl: "", withProvider: provider)
        
        // Then the image in the view model is nil
        XCTAssertNil(viewModel.image, "The image in the view model was not nil, but it should have have been nil")
        // And the view model contains the error
        XCTAssertEqual(viewModel.error, responseError, "The viewModel should contain the error '\(responseError)' but it contained '\(String(describing: viewModel.error))'")
    }
    
    func testRequestImage_UrlCreationError() throws {
        // Given a response with a url creation error
        let urlCreationError: NetworkError = .urlCreationError(description: "invalid url string")
        let provider = MockProvider(urlCreationError: urlCreationError)
        
        // When a request is made that returns a url creation error
        viewModel.requestImage(forUrl: "", withProvider: provider)
        
        // Then the image in the view model is nil
        XCTAssertNil(viewModel.image, "The image in the view model was not nil, but it should have have been nil")
        // And the view model contains the error
        XCTAssertEqual(viewModel.error, urlCreationError, "The viewModel should contain the error '\(urlCreationError)' but it contained '\(String(describing: viewModel.error))'")
    }
}
