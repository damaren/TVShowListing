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
        let shouldGiveNonEmptyResponse: Bool = true
        
        // When a request is made that gives a non empty response
        viewModel.requestTVShows(withSearchText: "", andProvider: MockProvider(shouldCompleteWithValue: shouldGiveNonEmptyResponse))
        
        // Then the number of shows in the view model should be equal to the number of items in the non empty response
        XCTAssertEqual(viewModel.shows.count, 6, "The number of shows in the view model (\(viewModel.shows.count)) should be equal to the number of items in the response from the API (\(6))")
    }
    
    func testRequestTVShows_EmptyResponse() throws {
        // Given an empty response to the tv show search
        let shouldGiveNonEmptyResponse: Bool = false
        
        // When a request is made that gives an empty response
        viewModel.requestTVShows(withSearchText: "", andProvider: MockProvider(shouldCompleteWithValue: shouldGiveNonEmptyResponse))
        
        // Then the number of shows in the view model should be zero
        XCTAssertTrue(viewModel.shows.isEmpty, "The number of shows in the view model (\(viewModel.shows.count)) should be equal to the number of items in the response from the API (\(0))")
    }
}
