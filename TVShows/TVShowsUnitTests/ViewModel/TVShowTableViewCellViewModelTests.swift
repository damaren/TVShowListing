//
//  TVShowTableViewCellViewModelTests.swift
//  TVShowsUnitTests
//
//  Created by José Damaren on 26/06/23.
//

import Foundation
import XCTest

@testable import TVShows

class TVShowTableViewCellViewModelTests: XCTestCase {
    var viewModel: TVShowTableViewCellViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = TVShowTableViewCellViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
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
        // Given a response with response error
        let responseError: NetworkError = .responseError(description: "Mock response error")
        let provider = MockProvider(responseError: responseError)
        
        // When the request returns a response error
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
        
        // When the request returns a url creation error
        viewModel.requestImage(forUrl: "", withProvider: provider)
        
        // Then the image in the view model is nil
        XCTAssertNil(viewModel.image, "The image in the view model was not nil, but it should have have been nil")
        // And the view model contains the error
        XCTAssertEqual(viewModel.networkError, urlCreationError, "The viewModel should contain the error '\(urlCreationError)' but it contained '\(String(describing: viewModel.networkError))'")
    }
    
    func testGetShowName_InfoIsAvailable() throws {
        // Given the view model with a show that has the name set
        let showName: String = "Show name"
        let show: TVShow = TVShow(id: 1, name: showName)
        viewModel.show = show
        
        // When getShowName is called
        let viewModelShowName = viewModel.getShowName()
        
        // Then we get the correct show name
        XCTAssertEqual(viewModelShowName, showName, "The view model returned \(viewModelShowName) but should have returned \(showName)")
    }
    
    func testGetShowName_InfoIsNotAvailable() throws {
        // Given the view model with a show that has no name set
        let show: TVShow = TVShow(id: 1)
        viewModel.show = show
        
        // When getShowName is called
        let viewModelShowName = viewModel.getShowName()
        
        // Then we get the message saying that no show name was provided
        XCTAssertEqual(viewModelShowName, TVShowTableViewCellViewModel.noShowNameMessage, "The view model returned \(viewModelShowName) but should have returned \(TVShowTableViewCellViewModel.noShowNameMessage)")
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
        XCTAssertEqual(viewModelGenres, TVShowTableViewCellViewModel.noGenresMessage, "The view model returned \(viewModelGenres) but should have returned \(TVShowTableViewCellViewModel.noGenresMessage)")
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
