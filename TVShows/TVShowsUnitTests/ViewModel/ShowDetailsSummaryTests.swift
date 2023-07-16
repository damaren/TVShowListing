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
    
    func testGetGenres_InfoIsAvailable() throws {
        // Given the view model with a show that has the genres set
        let genre1: String = "Genre1"
        let genre2: String = "Genre2"
        let genre3: String = "Genre3"
        let genres: [String] = [genre1, genre2, genre3]
        let show: TVShow = TVShow(id: 1, genres: genres)
        viewModel.show = show
        
        // When getGenres is called
        let viewModelGenres = viewModel.getGenres()
        
        // Then we get the correct genres text
        let genresText = "Genres: \(genre1), \(genre2), \(genre3)"
        XCTAssertEqual(viewModelGenres, genresText, "The view model returned \(viewModelGenres) but should have returned \(genresText)")
    }
    
    func testGetGenres_InfoIsNotAvailable() throws {
        // Given the view model with a show that has no genres set
        let show: TVShow = TVShow(id: 1)
        viewModel.show = show
        
        // When getGenres is called
        let viewModelGenres = viewModel.getGenres()
        
        // Then we get the message saying that no genres was provided
        XCTAssertEqual(viewModelGenres, ShowDetailsSummaryViewModel.noGenresMessage, "The view model returned \(viewModelGenres) but should have returned \(ShowDetailsSummaryViewModel.noGenresMessage)")
    }
    
    func testGetTime_InfoIsAvailable() throws {
        // Given the view model with a show that has the schedule with a time set
        let time = "22:00"
        let schedule = Schedule(
            time: time,
            days: ["Sunday"]
        )
        let show: TVShow = TVShow(id: 1, schedule: schedule)
        viewModel.show = show
        
        // When getTime is called
        let viewModelTime = viewModel.getTime()
        
        // Then we get the correct time text
        let timeText = "Time: \(time)"
        XCTAssertEqual(viewModelTime, timeText, "The view model returned \(viewModelTime) but should have returned \(timeText)")
    }
    
    func testGetTime_InfoIsNotAvailable() throws {
        // Given the view model with a show that has no schedule set
        let show: TVShow = TVShow(id: 1)
        viewModel.show = show
        
        // When getTime is called
        let viewModelTime = viewModel.getTime()
        
        // Then we get the message saying that no time info was provided
        XCTAssertEqual(viewModelTime, ShowDetailsSummaryViewModel.noTimeMessage, "The view model returned \(viewModelTime) but should have returned \(ShowDetailsSummaryViewModel.noTimeMessage)")
    }
    
    func testGetDays_InfoIsAvailable() throws {
        // Given the view model with a show that has the schedule with the days set
        let day1 = "Sunday"
        let day2 = "Monday"
        let days = [day1, day2]
        let schedule = Schedule(
            time: "22:00",
            days: days
        )
        let show: TVShow = TVShow(id: 1, schedule: schedule)
        viewModel.show = show
        
        // When getDays is called
        let viewModelDays = viewModel.getDays()
        
        // Then we get the correct days text
        let daysText = "Days: \(day1), \(day2)"
        XCTAssertEqual(viewModelDays, daysText, "The view model returned \(viewModelDays) but should have returned \(daysText)")
    }
    
    func testGetDays_InfoIsNotAvailable() throws {
        // Given the view model with a show that has no schedule set
        let show: TVShow = TVShow(id: 1)
        viewModel.show = show
        
        // When getDays is called
        let viewModelDays = viewModel.getDays()
        
        // Then we get the message saying that no days info was provided
        XCTAssertEqual(viewModelDays, ShowDetailsSummaryViewModel.noDaysMessage, "The view model returned \(viewModelDays) but should have returned \(ShowDetailsSummaryViewModel.noDaysMessage)")
    }
    
    func testGetSummary_InfoIsAvailable() throws {
        // Given the view model with a show that has the summary set
        let summary = "Show summary"
        let show: TVShow = TVShow(id: 1, summary: summary)
        viewModel.show = show
        
        // When getSummary is called
        let viewModelSummary = viewModel.getSummary()
        
        // Then we get the correct summary text
        XCTAssertEqual(viewModelSummary, summary, "The view model returned \(viewModelSummary) but should have returned \(summary)")
    }
    
    func testGetSummary_InfoIsNotAvailable() throws {
        // Given the view model with a show that has no summary set
        let show: TVShow = TVShow(id: 1)
        viewModel.show = show
        
        // When getSummary is called
        let viewModelSummary = viewModel.getSummary()
        
        // Then we get the message saying that nosummary was provided
        XCTAssertEqual(viewModelSummary, ShowDetailsSummaryViewModel.noSummaryMessage, "The view model returned \(viewModelSummary) but should have returned \(ShowDetailsSummaryViewModel.noSummaryMessage)")
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
        XCTAssertEqual(viewModel.networkError, responseError, "The viewModel should contain the error '\(responseError)' but it contained '\(String(describing: viewModel.networkError))'")
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
        XCTAssertEqual(viewModel.networkError, urlCreationError, "The viewModel should contain the error '\(urlCreationError)' but it contained '\(String(describing: viewModel.networkError))'")
    }
    
    func testConfigure() {
        // Given the view model with no show set
        viewModel.show = nil
        
        // When configure is called with a given show
        let show: TVShow = TVShow(id: 1)
        viewModel.configure(forShow: show, withProvider: MockProvider())
        
        // Then the view model contains the show
        XCTAssertEqual(viewModel.show, show, "The view model should contain the show \(show) but contained \(String(describing: viewModel.show))")
    }
}
