//
//  TVMazeProviderTests.swift
//  TVShowsUnitTests
//
//  Created by José Damaren on 11/07/23.
//

import XCTest

final class TVMazeProviderTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

//
//  ListViewModelTests.swift
//  TVShowsUnitTests
//
//  Created by José Damaren on 26/06/23.
//

//import Foundation
//import XCTest
//
//@testable import TVShows
//
//class ListViewModelTests: XCTestCase {
//    var viewModel: ListViewModel!
//    var provider: TVMazeProvider!
//
//    override func setUp() {
//        super.setUp()
//        viewModel = ListViewModel()
//
//        let config = URLSessionConfiguration.ephemeral
//        config.protocolClasses = [MockURLProtocol.self]
//        let urlSession = URLSession(configuration: config)
//        provider = TVMazeProvider(urlSession: urlSession)
//    }
//
//    override func tearDown() {
//        super.tearDown()
//        viewModel = nil
//        provider = nil
//    }
//
//    func testUpdateShows() throws {
//        // Given a respose from the API containing a list of TVShowResponse
//        let tvShowResponses: [TVShowResponse] = [
//            TVShowResponse(show: TVShow(id: 0)),
//            TVShowResponse(show: TVShow(id: 1)),
//            TVShowResponse(show: TVShow(id: 2)),
//            TVShowResponse(show: TVShow(id: 3)),
//            TVShowResponse(show: TVShow(id: 4)),
//            TVShowResponse(show: TVShow(id: 5))
//        ]
//
//        // When updateShows is called with the given list
//        viewModel.updateShows(forTVShowResponses: tvShowResponses)
//
//        // Then the number of items in the shows array should be equal to the number of items received from the API
//        XCTAssertEqual(viewModel.shows.count, tvShowResponses.count, "The number of shows in the view model (\(viewModel.shows.count)) should be equal to the number of items in the response from the API (\(tvShowResponses.count))")
//    }
//
//    func testRequestTVShows_NonEmptyResponse() throws {
//        // Given a non empty response to the tv show search
//        MockURLProtocol.stubResponseData = tvShowMockResponse.data(using: .utf8)
//
//        let expectation = self.expectation(description: "TV show service response expectation")
//
//        // When a request is made that gives a non empty response
//        viewModel.requestTVShows(withSearchText: "", andProvider: provider, completion: {
//
//            // Then the number of shows in the view model should be equal to the number of items in the response from the API
//            XCTAssertEqual(self.viewModel.shows.count, 3, "The number of shows in the view model (\(self.viewModel.shows.count)) should be equal to the number of items in the response from the API (\(3))")
//            expectation.fulfill()
//        })
//
//        self.wait(for: [expectation], timeout: 5)
//    }
//
//    func testRequestTVShows_EmptyResponse() throws {
//        // Given an empty response to the tv show search
//        MockURLProtocol.stubResponseData = tvShowMockEmptyResponse.data(using: .utf8)
//
//        // And given the view model with a non empty shows array (for testing that viewModel.shows will be empty after the request)
//        viewModel.shows = [TVShow()]
//
//        let expectation = self.expectation(description: "TV show service empty response expectation")
//
//        // When a request is made that gives an empty response
//        viewModel.requestTVShows(withSearchText: "", andProvider: provider, completion: {
//
//            // Then the number of shows in the view model should be zero
//            XCTAssertTrue(self.viewModel.shows.isEmpty, "The number of shows in the view model (\(self.viewModel.shows.count)) should be equal to the number of items in the response from the API (\(0))")
//            expectation.fulfill()
//        })
//
//        self.wait(for: [expectation], timeout: 5)
//    }
//
//    func testRequestTVShows_ResponseError() {
//        // Given a response with a response error to the tv show search
//        let responseError = NetworkError.responseError(description: "")
//        MockURLProtocol.error = responseError
//
//        let expectation = self.expectation(description: "TV show service empty response expectation")
//
//        // When a request is made that gives response error
//        viewModel.requestTVShows(withSearchText: "", andProvider: provider, completion: {
//
//            // Then the number of shows in the view model should be zero
//            XCTAssertTrue(self.viewModel.shows.isEmpty, "The number of shows in the view model (\(self.viewModel.shows.count)) should be equal to 0")
//            // And the view model should contain a response error
//            XCTAssertTrue(self.viewModel.error?.type == .responseError, "The view model should contain a NetworkError.responseError, but it contained \(String(describing: self.viewModel.error))")
//            expectation.fulfill()
//        })
//
//        self.wait(for: [expectation], timeout: 5)
//    }
//
//    func testRequestTVShows_QueryAllowedStringError() throws {
//        // Given an invalid search text
//        let notQueryAllowedString = String(
//            bytes: [0xD8, 0x00] as [UInt8],
//            encoding: .utf16BigEndian)!
//
//        let expectation = self.expectation(description: "TV show service empty response expectation")
//
//        // When we try to generate a query allowed string
//        viewModel.requestTVShows(withSearchText: notQueryAllowedString, andProvider: provider, completion: {
//
//            // Then the number of shows in the view model should be zero
//            XCTAssertTrue(self.viewModel.shows.isEmpty, "The number of shows in the view model (\(self.viewModel.shows.count)) should be equal to 0")
//            // And we get back a QueryAllowedStringError
//            XCTAssertTrue(self.viewModel.error?.type == .queryAllowedStringError, "The view model should contain a NetworkError.queryAllowedStringError, but it contained \(String(describing: self.viewModel.error))")
//            // And the error description should be equal to the search text
//            XCTAssertTrue(self.viewModel.error?.description == notQueryAllowedString, "The view model's error should have the search text as description (\(notQueryAllowedString)), but it contained \(String(describing: self.viewModel.error?.description))")
//            expectation.fulfill()
//        })
//
//        self.wait(for: [expectation], timeout: 5)
//    }
//
//    func testRequestTVShows_UrlCreationError() throws {
//        // Given a response with a url creation error to the tv show search
//        let tvShowResponses: [TVShowResponse] = [
//            TVShowResponse(show: TVShow(id: 0)),
//            TVShowResponse(show: TVShow(id: 1)),
//            TVShowResponse(show: TVShow(id: 2)),
//            TVShowResponse(show: TVShow(id: 3)),
//            TVShowResponse(show: TVShow(id: 4)),
//            TVShowResponse(show: TVShow(id: 5))
//        ]
//        let urlCreationError: NetworkError = .urlCreationError(description: "invalid url string")
//        let provider = MockProvider(showResponses: tvShowResponses, urlCreationError: urlCreationError)
//
//        // When a request is made that gives a url creation error
//        viewModel.requestTVShows(withSearchText: "", andProvider: provider)
//
//        // Then the number of shows in the view model should be zero
//        XCTAssertTrue(viewModel.shows.isEmpty, "The number of shows in the view model (\(viewModel.shows.count)) should be equal to (\(0))")
//        // And the view model should contain the error
//        XCTAssertEqual(viewModel.error, urlCreationError, "The viewModel should contain the error '\(urlCreationError)' but it contained '\(String(describing: viewModel.error))'")
//    }
//
//    func testRequestTVShows_JSONDecodeError() throws {
//        // Given a response with a JSON decode error to the tv show search
//        let tvShowResponses: [TVShowResponse] = [
//            TVShowResponse(show: TVShow(id: 0)),
//            TVShowResponse(show: TVShow(id: 1)),
//            TVShowResponse(show: TVShow(id: 2)),
//            TVShowResponse(show: TVShow(id: 3)),
//            TVShowResponse(show: TVShow(id: 4)),
//            TVShowResponse(show: TVShow(id: 5))
//        ]
//        let JSONDecodeError: NetworkError = .JSONDecodeError
//        let provider = MockProvider(showResponses: tvShowResponses, JSONDecodeError: JSONDecodeError)
//
//        // When a request is made that gives a JSON decode error
//        viewModel.requestTVShows(withSearchText: "", andProvider: provider)
//
//        // Then the number of shows in the view model should be zero
//        XCTAssertTrue(viewModel.shows.isEmpty, "The number of shows in the view model (\(viewModel.shows.count)) should be equal to (\(0))")
//        // And the view model should contain the error
//        XCTAssertEqual(viewModel.error, JSONDecodeError, "The viewModel should contain the error '\(JSONDecodeError)' but it contained '\(String(describing: viewModel.error))'")
//    }
//}
