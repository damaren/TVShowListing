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
    
    func testRequestImage() throws {
        viewModel.requestImage(forUrl: "", withProvider: MockProvider(shouldCompleteWithValue: true))
        XCTAssertNotNil(viewModel.image)
        viewModel.requestImage(forUrl: "", withProvider: MockProvider(shouldCompleteWithValue: false))
        XCTAssertNil(viewModel.image)
    }
}
