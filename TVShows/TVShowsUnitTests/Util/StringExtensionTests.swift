//
//  StringExtensionTests.swift
//  TVShowsUnitTests
//
//  Created by José Damaren on 27/07/23.
//

import XCTest

@testable import TVShows

final class StringExtensionTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testHtmlToAttributedString() throws {
        // Given an html string with the bold tag
        let htmlString = "<b>bold text</b>"
        
        // When htmlToAttributedString is called
        let attributedString = htmlString.htmlToAttributedString(withSize: 12)
        
        // Then the resulting attributed string has the font 'systemFont'
        let attributes = (attributedString?.attributes(at: 0, effectiveRange: nil))!
        let attrFont = attributes[NSAttributedString.Key.font] as! UIFont
        let expectedFont = UIFont.systemFont(ofSize: 12, weight: .bold)
        XCTAssertEqual(attrFont.fontName, expectedFont.fontName)
    }
}
