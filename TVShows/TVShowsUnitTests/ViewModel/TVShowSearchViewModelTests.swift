//
//  TVShowSearchViewModelTests.swift
//  TVShowsUnitTests
//
//  Created by José Damaren on 26/06/23.
//

import Foundation
import XCTest

@testable import TVShows

class TVShowSearchViewModelTests: XCTestCase {
    
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
        
        class MockProvider: Provider {
            func requestTVShows(searchString: String, completion: @escaping ([TVShows.TVShowResponse]?, TVShows.NetworkError?) -> ()) {}
            func requestEpisodes(showID: Int, completion: @escaping ([TVShows.Episode]?, TVShows.NetworkError?) -> ()) {}
            func requestImage(forUrl urlString: String?, completion: @escaping (UIImage?, TVShows.NetworkError?) -> ()) {}
        }
        let viewModel = createSUT(forProvider: MockProvider())
        
        // When updateShows is called with the given list
        viewModel.updateShows(forTVShowResponses: tvShowResponses)
        
        // Then the number of items in the shows array should be equal to the number of items received from the API
        XCTAssertEqual(viewModel.shows.count, tvShowResponses.count, "The number of shows in the view model (\(viewModel.shows.count)) should be equal to the number of items in the response from the API (\(tvShowResponses.count))")
    }
    
    func testGetShowFor() throws {
        // Given the view model with a non empty list of shows
        let shows = [TVShow(id: 0), TVShow(id: 1), TVShow(id: 2), TVShow(id: 3), TVShow(id: 4), TVShow(id: 5)]
        class MockProvider: Provider {
            func requestTVShows(searchString: String, completion: @escaping ([TVShows.TVShowResponse]?, TVShows.NetworkError?) -> ()) {}
            func requestEpisodes(showID: Int, completion: @escaping ([TVShows.Episode]?, TVShows.NetworkError?) -> ()) {}
            func requestImage(forUrl urlString: String?, completion: @escaping (UIImage?, TVShows.NetworkError?) -> ()) {}
        }
        let viewModel = createSUT(forProvider: MockProvider())
        viewModel.shows = shows
        
        // When getShowFor is called with row equal to i
        let i = 2
        let returnedShow = viewModel.getShowFor(indexPath: IndexPath(row: i, section: 0))
        
        // Then the view model returns the show in the index equal to i
        XCTAssertEqual(returnedShow, shows[i], "The returned show should have been \(shows[i]) but it was \(returnedShow)")
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
        
        class MockProvider: Provider {
            var responses: [TVShowResponse]
            init(responses: [TVShowResponse]) {
                self.responses = responses
            }
            func requestTVShows(searchString: String, completion: @escaping ([TVShows.TVShowResponse]?, TVShows.NetworkError?) -> ()) {
                completion(responses, nil)
            }
            func requestEpisodes(showID: Int, completion: @escaping ([TVShows.Episode]?, TVShows.NetworkError?) -> ()) {}
            func requestImage(forUrl urlString: String?, completion: @escaping (UIImage?, TVShows.NetworkError?) -> ()) {}
        }
        
        let viewModel = createSUT(forProvider: MockProvider(responses: tvShowResponses))
        
        // When a request is made that gives a non empty response
        viewModel.requestTVShows(withSearchText: "", completion: nil)
        
        // Then the number of shows in the view model should be equal to the number of items in the non empty response
        XCTAssertEqual(viewModel.shows.count, tvShowResponses.count, "The number of shows in the view model (\(viewModel.shows.count)) should be equal to the number of items in the response from the API (\(tvShowResponses.count))")
    }
    
    func testRequestTVShows_EmptyResponse() throws {
        // Given an empty response to the tv show search
        let tvShowResponses: [TVShowResponse] = []
        
        class MockProvider: Provider {
            var responses: [TVShowResponse]
            init(responses: [TVShowResponse]) {
                self.responses = responses
            }
            func requestTVShows(searchString: String, completion: @escaping ([TVShows.TVShowResponse]?, TVShows.NetworkError?) -> ()) {
                completion(responses, nil)
            }
            func requestEpisodes(showID: Int, completion: @escaping ([TVShows.Episode]?, TVShows.NetworkError?) -> ()) {}
            func requestImage(forUrl urlString: String?, completion: @escaping (UIImage?, TVShows.NetworkError?) -> ()) {}
        }
        
        let provider = MockProvider(responses: tvShowResponses)
        
        let viewModel = createSUT(forProvider: provider)
        
        // When a request is made that gives an empty response
        viewModel.requestTVShows(withSearchText: "", completion: nil)
        
        // Then the number of shows in the view model should be zero
        XCTAssertTrue(viewModel.shows.isEmpty, "The number of shows in the view model (\(viewModel.shows.count)) should be equal to the number of items in the response from the API (\(0))")
    }
    
    func testRequestTVShows_ResponseError() throws {
        // Given a response with a response error to the tv show search
        let responseError: NetworkError = .responseError(description: "Mock response error")
        
        class MockProvider: Provider {
            var responseError: NetworkError
            init(responseError: NetworkError) {
                self.responseError = responseError
            }
            func requestTVShows(searchString: String, completion: @escaping ([TVShows.TVShowResponse]?, TVShows.NetworkError?) -> ()) {
                completion(nil, responseError)
            }
            func requestEpisodes(showID: Int, completion: @escaping ([TVShows.Episode]?, TVShows.NetworkError?) -> ()) {}
            func requestImage(forUrl urlString: String?, completion: @escaping (UIImage?, TVShows.NetworkError?) -> ()) {}
        }
        
        let viewModel = createSUT(forProvider: MockProvider(responseError: responseError))
        
        // When the request gives a response error
        viewModel.requestTVShows(withSearchText: "", completion: nil)
        
        // Then the number of shows in the view model should be zero
        XCTAssertTrue(viewModel.shows.isEmpty, "The number of shows in the view model (\(viewModel.shows.count)) should be equal to (\(0))")
        // And the view model should contain the error
        XCTAssertEqual(viewModel.error, responseError, "The viewModel should contain the error '\(responseError)' but it contained '\(String(describing: viewModel.error))'")
    }
    
    func testRequestTVShows_QueryAllowedStringError() throws {
        // Given a response with a query allowed string error to the tv show search
        let queryAllowedError: NetworkError = .queryAllowedStringError(description: "Mock query allowed error")
        
        class MockProvider: Provider {
            var queryAllowedError: NetworkError
            init(queryAllowedError: NetworkError) {
                self.queryAllowedError = queryAllowedError
            }
            func requestTVShows(searchString: String, completion: @escaping ([TVShows.TVShowResponse]?, TVShows.NetworkError?) -> ()) {
                completion(nil, queryAllowedError)
            }
            func requestEpisodes(showID: Int, completion: @escaping ([TVShows.Episode]?, TVShows.NetworkError?) -> ()) {}
            func requestImage(forUrl urlString: String?, completion: @escaping (UIImage?, TVShows.NetworkError?) -> ()) {}
        }
        
        let provider = MockProvider(queryAllowedError: queryAllowedError)
        let viewModel = createSUT(forProvider: provider)
        
        // When the request gives a query allowed string error
        viewModel.requestTVShows(withSearchText: "", completion: nil)
        
        // Then the number of shows in the view model should be zero
        XCTAssertTrue(viewModel.shows.isEmpty, "The number of shows in the view model (\(viewModel.shows.count)) should be equal to (\(0))")
        // And the view model should contain the error
        XCTAssertEqual(viewModel.error, queryAllowedError, "The viewModel should contain the error '\(queryAllowedError)' but it contained '\(String(describing: viewModel.error))'")
    }
    
    func testRequestTVShows_UrlCreationError() throws {
        // Given a response with a url creation error to the tv show search
        let urlCreationError: NetworkError = .urlCreationError(description: "invalid url string")
        
        class MockProvider: Provider {
            var urlCreationError: NetworkError
            init(urlCreationError: NetworkError) {
                self.urlCreationError = urlCreationError
            }
            func requestTVShows(searchString: String, completion: @escaping ([TVShows.TVShowResponse]?, TVShows.NetworkError?) -> ()) {
                completion(nil, urlCreationError)
            }
            func requestEpisodes(showID: Int, completion: @escaping ([TVShows.Episode]?, TVShows.NetworkError?) -> ()) {}
            func requestImage(forUrl urlString: String?, completion: @escaping (UIImage?, TVShows.NetworkError?) -> ()) {}
        }
        
        let provider = MockProvider(urlCreationError: urlCreationError)
        let viewModel = createSUT(forProvider: provider)
        
        // When the request gives a url creation error
        viewModel.requestTVShows(withSearchText: "", completion: nil)
        
        // Then the number of shows in the view model should be zero
        XCTAssertTrue(viewModel.shows.isEmpty, "The number of shows in the view model (\(viewModel.shows.count)) should be equal to (\(0))")
        // And the view model should contain the error
        XCTAssertEqual(viewModel.error, urlCreationError, "The viewModel should contain the error '\(urlCreationError)' but it contained '\(String(describing: viewModel.error))'")
    }
    
    func testRequestTVShows_JSONDecodeError() throws {
        // Given a response with a JSON decode error to the tv show search
        let JSONDecodeError: NetworkError = .JSONDecodeError
        
        class MockProvider: Provider {
            var JSONDecodeError: NetworkError
            init(JSONDecodeError: NetworkError) {
                self.JSONDecodeError = JSONDecodeError
            }
            func requestTVShows(searchString: String, completion: @escaping ([TVShows.TVShowResponse]?, TVShows.NetworkError?) -> ()) {
                completion(nil, JSONDecodeError)
            }
            func requestEpisodes(showID: Int, completion: @escaping ([TVShows.Episode]?, TVShows.NetworkError?) -> ()) {}
            func requestImage(forUrl urlString: String?, completion: @escaping (UIImage?, TVShows.NetworkError?) -> ()) {}
        }
        let viewModel = createSUT(forProvider: MockProvider(JSONDecodeError: JSONDecodeError))
        
        // When the request gives a JSON decode error
        viewModel.requestTVShows(withSearchText: "", completion: nil)
        
        // Then the number of shows in the view model should be zero
        XCTAssertTrue(viewModel.shows.isEmpty, "The number of shows in the view model (\(viewModel.shows.count)) should be equal to (\(0))")
        // And the view model should contain the error
        XCTAssertEqual(viewModel.error, JSONDecodeError, "The viewModel should contain the error '\(JSONDecodeError)' but it contained '\(String(describing: viewModel.error))'")
    }
    
    private func createSUT(forProvider provider: Provider) -> TVShowSearchViewModel {
        
        class MockSearchView: TVShowSearchViewProtocol {
            func updateView(completion: (() -> ())?) {}
        }
        
        return TVShowSearchViewModel(showSearchView: MockSearchView(), provider: provider)
    }
}
