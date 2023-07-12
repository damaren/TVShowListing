//
//  TVMazeProviderTests.swift
//  TVShowsUnitTests
//
//  Created by José Damaren on 11/07/23.
//

import XCTest

@testable import TVShows

final class TVMazeProviderTests: XCTestCase {
    var provider: TVMazeProvider!

    override func setUp() {
        super.setUp()

        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        provider = TVMazeProvider(urlSession: urlSession)
    }

    override func tearDown() {
        super.tearDown()
        provider = nil
        MockURLProtocol.error = nil
    }
    
    func testRequestTVShows_NonEmptyResponse() throws {
        // Given a non empty response to the tv show search
        MockURLProtocol.stubResponseData = tvShowMockResponse.data(using: .utf8)

        let expectation = self.expectation(description: "TV show service response expectation")

        // When a request is made that gives a non empty response
        provider.requestTVShows(searchString: "", completion: { response, error in
            // Then response should contain the array of TVShowResponse with the number of elements equal to the number of elements in the response from the API
            XCTAssertNotNil(response, "The response from the requestTVShows method should NOT be nil")
            XCTAssertEqual(response?.count, 3, "The number of items in the response (\(String(describing: response?.count))) should be equal to the number of items in the response from the API (\(3))")
            // And the error should be nil
            XCTAssertNil(error, "The error should be nil, but it was \(String(describing: error))")
            expectation.fulfill()
        })

        self.wait(for: [expectation], timeout: 5)
    }
    
    func testRequestTVShows_EmptyResponse() throws {
        // Given a non empty response to the tv show search
        MockURLProtocol.stubResponseData = tvShowMockEmptyResponse.data(using: .utf8)

        let expectation = self.expectation(description: "TV show empty response expectation")

        // When a request is made that gives an empty response
        provider.requestTVShows(searchString: "", completion: { response, error in
            // Then response should contain the array of TVShowResponse with zero elements
            XCTAssertNotNil(response, "The response from the requestTVShows method should NOT be nil")
            XCTAssertEqual(response?.count, 0, "Testing an empty response from the API. The number of items in the response (\(String(describing: response?.count))) should be equal to zero.")
            // And the error should be nil
            XCTAssertNil(error, "The error should be nil, but it was \(String(describing: error))")
            expectation.fulfill()
        })

        self.wait(for: [expectation], timeout: 5)
    }
    
    func testRequestTVShows_ResponseError() {
        // Given a response with a response error to the tv show search
        let responseError = NetworkError.responseError(description: "")
        MockURLProtocol.error = responseError

        let expectation = self.expectation(description: "TV show responseError expectation")

        // When a request is made that gives response error
        provider.requestTVShows(searchString: "", completion: { response, error in
            // Then response should be nil
            XCTAssertNil(response, "The response should be nil, but it was \(String(describing: response))")
            // And the error should be of type NetworkError.responseError
            XCTAssertTrue(error?.type == .responseError, "The error should contain a NetworkError.responseError, but it contained \(String(describing: error))")
            expectation.fulfill()
        })

        self.wait(for: [expectation], timeout: 5)
    }
    
    func testRequestTVShows_QueryAllowedStringError() {
        // Given a string that cannot be made query allowed
        let notQueryAllowedString = String(
            bytes: [0xD8, 0x00] as [UInt8],
            encoding: .utf16BigEndian)!

        let expectation = self.expectation(description: "TV show queryAllowedStringError expectation")

        // When a request is made with the string
        provider.requestTVShows(searchString: notQueryAllowedString, completion: { response, error in
            // Then response should be nil
            XCTAssertNil(response, "The response should be nil, but it was \(String(describing: response))")
            // And the error should be of type NetworkError.queryAllowedStringError
            XCTAssertTrue(error?.type == .queryAllowedStringError, "The error should contain a NetworkError.queryAllowedStringError, but it contained \(String(describing: error))")
            // And the error description should contain the unallowed string
            XCTAssertEqual(error?.description, notQueryAllowedString, "The error should contain the unallowed string (\(notQueryAllowedString)) as a description, but it contained \(String(describing: error?.description))")
            expectation.fulfill()
        })

        self.wait(for: [expectation], timeout: 5)
    }
    
    func testRequestTVShows_UrlCreationError() {
        // Given an invalid base URL
        let baseURL: String = "http:// invalid base url"
        let searchString: String = ""
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        let provider = TVMazeProvider(urlSession: urlSession, baseURL: baseURL) // had to declare the provider here to inject the invalid baseURL

        let expectation = self.expectation(description: "TV show urlCreationError expectation")

        // When a request is made with the invalid base URL
        provider.requestTVShows(searchString: searchString, completion: { response, error in
            // Then response should be nil
            XCTAssertNil(response, "The response should be nil, but it was \(String(describing: response))")
            // And the error should be of type NetworkError.urlCreationError
            XCTAssertTrue(error?.type == .urlCreationError, "The error should contain a NetworkError.urlCreationError, but it contained \(String(describing: error))")
            // And the error description should contain the invalid url
            let urlString = "\(baseURL)/search/shows?q=\(searchString)"
            XCTAssertEqual(error?.description, urlString, "The error should contain the invalid url (\(urlString)) as a description, but it contained \(String(describing: error?.description))")
            expectation.fulfill()
        })

        self.wait(for: [expectation], timeout: 5)
    }
    
    func testRequestTVShows_JSONDecodeError() throws {
        // Given an invalid JSON response
        MockURLProtocol.stubResponseData = tvShowMockInvalidJSONResponse.data(using: .utf8)

        let expectation = self.expectation(description: "TV show service JSONDecodeError expectation")

        // When a request is made that gives an invalid JSON response
        provider.requestTVShows(searchString: "", completion: { response, error in
            // Then response should be nil
            XCTAssertNil(response, "The response should be nil, but it was \(String(describing: response))")
            // And the error should be of type NetworkError.JSONDecodeError
            XCTAssertTrue(error?.type == .JSONDecodeError, "The error should contain a NetworkError.JSONDecodeError, but it contained \(String(describing: error))")
            expectation.fulfill()
        })

        self.wait(for: [expectation], timeout: 5)
    }
    
    func testRequestEpisodes_NonEmptyResponse() throws {
        // Given a non empty response to the episodes request
        MockURLProtocol.stubResponseData = episodeMockResponse.data(using: .utf8)

        let expectation = self.expectation(description: "Episode response expectation")

        // When a request is made that gives a non empty response
        provider.requestEpisodes(showID: 1, completion: { response, error in
            // Then response should contain the array of Episode with the number of elements equal to the number of elements in the response from the API
            XCTAssertNotNil(response, "The response from the requestEpisodes method should NOT be nil")
            XCTAssertEqual(response?.count, 6, "The number of items in the response (\(String(describing: response?.count))) should be equal to the number of items in the response from the API (\(6))")
            // And the error should be nil
            XCTAssertNil(error, "The error should be nil, but it was \(String(describing: error))")
            expectation.fulfill()
        })

        self.wait(for: [expectation], timeout: 5)
    }
    
    func testRequestEpisodes_EmptyResponse() throws {
        // Given a non empty response to the episodes request
        MockURLProtocol.stubResponseData = episodeEmptyResponse.data(using: .utf8)

        let expectation = self.expectation(description: "Episode empty response expectation")

        // When a request is made that gives an empty response
        provider.requestEpisodes(showID: 1, completion: { response, error in
            // Then response should contain the array of Episode with zero elements
            XCTAssertNotNil(response, "The response from the requestEpisodes method should NOT be nil")
            XCTAssertEqual(response?.count, 0, "Testing an empty response from the API. The number of items in the response (\(String(describing: response?.count))) should be equal to zero.")
            // And the error should be nil
            XCTAssertNil(error, "The error should be nil, but it was \(String(describing: error))")
            expectation.fulfill()
        })

        self.wait(for: [expectation], timeout: 5)
    }
    
    func testRequestEpisodes_ResponseError() {
        // Given a response with a response error to the episodes request
        let responseError = NetworkError.responseError(description: "")
        MockURLProtocol.error = responseError

        let expectation = self.expectation(description: "Episode responseError expectation")

        // When a request is made that gives response error
        provider.requestEpisodes(showID: 1, completion: { response, error in
            // Then response should be nil
            XCTAssertNil(response, "The response should be nil, but it was \(String(describing: response))")
            // And the error should be of type NetworkError.responseError
            XCTAssertTrue(error?.type == .responseError, "The error should contain a NetworkError.responseError, but it contained \(String(describing: error))")
            expectation.fulfill()
        })

        self.wait(for: [expectation], timeout: 5)
    }
    
    func testRequestEpisodes_UrlCreationError() {
        // Given an invalid base URL
        let baseURL: String = "http:// invalid base url"
        let showID: Int = 1
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        let provider = TVMazeProvider(urlSession: urlSession, baseURL: baseURL) // had to declare the provider here to inject the invalid baseURL

        let expectation = self.expectation(description: "Episode urlCreationError expectation")

        // When a request is made with the invalid base URL
        provider.requestEpisodes(showID: showID, completion: { response, error in
            // Then response should be nil
            XCTAssertNil(response, "The response should be nil, but it was \(String(describing: response))")
            // And the error should be of type NetworkError.urlCreationError
            XCTAssertTrue(error?.type == .urlCreationError, "The error should contain a NetworkError.urlCreationError, but it contained \(String(describing: error))")
            // And the error description should contain the invalid url
            let urlString = "\(baseURL)/shows/\(showID)/episodes"
            XCTAssertEqual(error?.description, urlString, "The error should contain the invalid url (\(urlString)) as a description, but it contained \(String(describing: error?.description))")
            expectation.fulfill()
        })

        self.wait(for: [expectation], timeout: 5)
    }
    
    func testRequestEpisodes_JSONDecodeError() throws {
        // Given an invalid JSON response
        MockURLProtocol.stubResponseData = episodeInvalidJSONResponse.data(using: .utf8)

        let expectation = self.expectation(description: "Episode JSONDecodeError expectation")

        // When a request is made that gives an invalid JSON response
        provider.requestEpisodes(showID: 1, completion: { response, error in
            // Then response should be nil
            XCTAssertNil(response, "The response should be nil, but it was \(String(describing: response))")
            // And the error should be of type NetworkError.JSONDecodeError
            XCTAssertTrue(error?.type == .JSONDecodeError, "The error should contain a NetworkError.JSONDecodeError, but it contained \(String(describing: error))")
            expectation.fulfill()
        })

        self.wait(for: [expectation], timeout: 5)
    }
}
