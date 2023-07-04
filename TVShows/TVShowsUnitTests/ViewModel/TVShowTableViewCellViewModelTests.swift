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
        
        // When a request is made the locates and returns the image
        viewModel.requestImage(forUrl: "", withProvider: MockProvider(image: image))
        
        // Then the image in the view model is not nil
        XCTAssertNotNil(viewModel.image, "The image in the view model was nil, but it should have a not nil value")
    }
    
    func testRequestImage_Nil() throws {
        // Given URL that has no image in it
        let image: UIImage? = nil
        
        // When a request is made to that URL
        viewModel.requestImage(forUrl: "", withProvider: MockProvider(image: image))
        
        // Then the image in the view model is nil
        XCTAssertNil(viewModel.image, "The image in the view model was not nil, but it should have have been nil")
    }
}
