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
    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
    }
    
    func testUpdateShows() throws {
        // Given a respose from the API containing a list of TVShowResponse
        let tvShowResponses: [TVShowResponse] = [
            TVShowResponse(show: TVShow(id: 0)),
            TVShowResponse(show: TVShow(id: 1)),
            TVShowResponse(show: TVShow(id: 2)),
            TVShowResponse(show: TVShow(id: 3)),
            TVShowResponse(show: TVShow(id: 4)),
            TVShowResponse(show: TVShow(id: 5))
        ]
        
        // When updateShows is called with the given list
        viewModel.updateShows(forTVShowResponses: tvShowResponses)
        
        // Then the number of items in the shows array should be equal to the number of items received from the API
        XCTAssertEqual(viewModel.shows.count, tvShowResponses.count, "The number of shows in the view model (\(viewModel.shows.count)) should be equal to the number of items in the response from the API (\(tvShowResponses.count))")
    }
    
    func testRequestTVShows_NonEmptyResponse() throws {
        // Given a non empty response to the tv show search
        let tvShowResponses: [TVShowResponse] = [
            TVShowResponse(show: TVShow(id: 0)),
            TVShowResponse(show: TVShow(id: 1)),
            TVShowResponse(show: TVShow(id: 2)),
            TVShowResponse(show: TVShow(id: 3)),
            TVShowResponse(show: TVShow(id: 4)),
            TVShowResponse(show: TVShow(id: 5))
        ]
        
        // When a request is made that gives a non empty response
        viewModel.requestTVShows(withSearchText: "", andProvider: MockProvider(showResponses: tvShowResponses))
        
        // Then the number of shows in the view model should be equal to the number of items in the non empty response
        XCTAssertEqual(viewModel.shows.count, tvShowResponses.count, "The number of shows in the view model (\(viewModel.shows.count)) should be equal to the number of items in the response from the API (\(tvShowResponses.count))")
    }
    
    func testRequestTVShows_EmptyResponse() throws {
        // Given an empty response to the tv show search
        let tvShowResponses: [TVShowResponse] = []
        
        // When a request is made that gives an empty response
        viewModel.requestTVShows(withSearchText: "", andProvider: MockProvider(showResponses: tvShowResponses))
        
        // Then the number of shows in the view model should be zero
        XCTAssertTrue(viewModel.shows.isEmpty, "The number of shows in the view model (\(viewModel.shows.count)) should be equal to the number of items in the response from the API (\(0))")
    }
    
    func testRequestTVShows_ResponseError() throws {
        // Given a response with a response error to the tv show search
        let tvShowResponses: [TVShowResponse] = [
            TVShowResponse(show: TVShow(id: 0)),
            TVShowResponse(show: TVShow(id: 1)),
            TVShowResponse(show: TVShow(id: 2)),
            TVShowResponse(show: TVShow(id: 3)),
            TVShowResponse(show: TVShow(id: 4)),
            TVShowResponse(show: TVShow(id: 5))
        ]
        let responseError: NetworkError = .responseError("Mock response error")
        let provider = MockProvider(showResponses: tvShowResponses, responseError: responseError)
        
        // When a request is made that gives response error
        viewModel.requestTVShows(withSearchText: "", andProvider: provider)
        
        // Then the number of shows in the view model should be zero
        XCTAssertTrue(viewModel.shows.isEmpty, "The number of shows in the view model (\(viewModel.shows.count)) should be equal to (\(0))")
        // And the view model should contain the error
        XCTAssertEqual(viewModel.error, responseError, "The viewModel should contain the error '\(responseError)' but it contained '\(String(describing: viewModel.error))'")
    }
    
    func testRequestTVShows_QueryAllowedStringError() throws {
        // Given a response with a query allowed string error to the tv show search
        let tvShowResponses: [TVShowResponse] = [
            TVShowResponse(show: TVShow(id: 0)),
            TVShowResponse(show: TVShow(id: 1)),
            TVShowResponse(show: TVShow(id: 2)),
            TVShowResponse(show: TVShow(id: 3)),
            TVShowResponse(show: TVShow(id: 4)),
            TVShowResponse(show: TVShow(id: 5))
        ]
        let queryAllowedError: NetworkError = .queryAllowedStringError("test query allowed error")
        let provider = MockProvider(showResponses: tvShowResponses, queryAllowedStringError: queryAllowedError)
        
        // When a request is made that gives a query allowed string error
        viewModel.requestTVShows(withSearchText: "", andProvider: provider)
        
        // Then the number of shows in the view model should be zero
        XCTAssertTrue(viewModel.shows.isEmpty, "The number of shows in the view model (\(viewModel.shows.count)) should be equal to (\(0))")
        // And the view model should contain the error
        XCTAssertEqual(viewModel.error, queryAllowedError, "The viewModel should contain the error '\(queryAllowedError)' but it contained '\(String(describing: viewModel.error))'")
    }
    
    func testRequestTVShows_UrlCreationError() throws {
        // Given a response with a url creation error to the tv show search
        let tvShowResponses: [TVShowResponse] = [
            TVShowResponse(show: TVShow(id: 0)),
            TVShowResponse(show: TVShow(id: 1)),
            TVShowResponse(show: TVShow(id: 2)),
            TVShowResponse(show: TVShow(id: 3)),
            TVShowResponse(show: TVShow(id: 4)),
            TVShowResponse(show: TVShow(id: 5))
        ]
        let urlCreationError: NetworkError = .urlCreationError("invalid url string")
        let provider = MockProvider(showResponses: tvShowResponses, urlCreationError: urlCreationError)
        
        // When a request is made that gives a url creation error
        viewModel.requestTVShows(withSearchText: "", andProvider: provider)
        
        // Then the number of shows in the view model should be zero
        XCTAssertTrue(viewModel.shows.isEmpty, "The number of shows in the view model (\(viewModel.shows.count)) should be equal to (\(0))")
        // And the view model should contain the error
        XCTAssertEqual(viewModel.error, urlCreationError, "The viewModel should contain the error '\(urlCreationError)' but it contained '\(String(describing: viewModel.error))'")
    }
    
    func testRequestTVShows_JSONDecodeError() throws {
        // Given a response with a JSON decode error to the tv show search
        let tvShowResponses: [TVShowResponse] = [
            TVShowResponse(show: TVShow(id: 0)),
            TVShowResponse(show: TVShow(id: 1)),
            TVShowResponse(show: TVShow(id: 2)),
            TVShowResponse(show: TVShow(id: 3)),
            TVShowResponse(show: TVShow(id: 4)),
            TVShowResponse(show: TVShow(id: 5))
        ]
        let JSONDecodeError: NetworkError = .JSONDecodeError
        let provider = MockProvider(showResponses: tvShowResponses, JSONDecodeError: JSONDecodeError)
        
        // When a request is made that gives a JSON decode error
        viewModel.requestTVShows(withSearchText: "", andProvider: provider)
        
        // Then the number of shows in the view model should be zero
        XCTAssertTrue(viewModel.shows.isEmpty, "The number of shows in the view model (\(viewModel.shows.count)) should be equal to (\(0))")
        // And the view model should contain the error
        XCTAssertEqual(viewModel.error, JSONDecodeError, "The viewModel should contain the error '\(JSONDecodeError)' but it contained '\(String(describing: viewModel.error))'")
    }
}
