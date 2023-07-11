//
//  EpisodeInformationViewModelTests.swift
//  TVShowsUnitTests
//
//  Created by José Damaren on 26/06/23.
//

import Foundation
import XCTest

@testable import TVShows

class EpisodeInformationViewModelTests: XCTestCase {
    var viewModel: EpisodeInformationViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = EpisodeInformationViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
    }
    
    func testGetSeasonAndNumberText() throws {
        // Given an episode
        let episode: Episode = Episode(id: 1, season: 1, number: 5)
        viewModel.episode = episode
        
        // When we call the season and number getter
        let seasonAndNumberText = viewModel.getSeasonAndNumberText()
        
        // Then we get the correct value back
        XCTAssertEqual(seasonAndNumberText, "S1E5:", "The season and number getter returned '\(seasonAndNumberText)' but should have returned 'S1E5:'")
    }
    
    func testRequestImage_NotNil() throws {
        // Given a not nil image in a URL
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
        // Given a response with a response error
        let responseError: NetworkError = .responseError(description: "Mock response error")
        let provider = MockProvider(responseError: responseError)
        
        // When the request returns a response error
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
        
        // When the request gives a url creation error
        viewModel.requestImage(forUrl: "", withProvider: provider)
        
        // Then the image in the view model is nil
        XCTAssertNil(viewModel.image, "The image in the view model was not nil, but it should have have been nil")
        // And the view model contains the error
        XCTAssertEqual(viewModel.error, urlCreationError, "The viewModel should contain the error '\(urlCreationError)' but it contained '\(String(describing: viewModel.error))'")
    }
}
