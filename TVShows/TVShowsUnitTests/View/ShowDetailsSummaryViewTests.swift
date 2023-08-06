//
//  ShowDetailsSummaryViewTests.swift
//  TVShowsUnitTests
//
//  Created by José Damaren on 03/08/23.
//

import XCTest

@testable import TVShows

final class ShowDetailsSummaryViewTests: XCTestCase {
    var summaryView: ShowDetailsSummaryView!
    
    override func setUp() {
        super.setUp()

        summaryView = ShowDetailsSummaryView()
    }

    override func tearDown() {
        super.tearDown()
        summaryView = nil
    }
    
    func testSetup() throws {
        // Given the instantiated summary view not yet set up
        
        // The configured view model
        let genres: [String] = ["genre1", "genre2", "genre3"]
        let time = "22:00"
        let days = ["Monday", "Wednesday"]
        let schedule: Schedule = Schedule(time: time, days: days)
        let summary = "Show summary"
        let show = TVShow(id: 1, genres: genres, schedule: schedule, summary: summary)
        summaryView.viewModel.configure(forShow: show, withProvider: MockProvider())
        
        // When setup is called
        summaryView.setup()
        
        // Then
        
        // All the components have translatesAutoresizingMaskIntoConstraints equal false
        XCTAssertFalse(summaryView.translatesAutoresizingMaskIntoConstraints, "The summaryView should have translatesAutoresizingMaskIntoConstraints equal false")
        XCTAssertFalse(summaryView.imageView.translatesAutoresizingMaskIntoConstraints, "The image view should have translatesAutoresizingMaskIntoConstraints equal false")
        XCTAssertFalse(summaryView.genresLabel.translatesAutoresizingMaskIntoConstraints, "The genresLabel should have translatesAutoresizingMaskIntoConstraints equal false")
        XCTAssertFalse(summaryView.timeLabel.translatesAutoresizingMaskIntoConstraints, "The timeLabel should have translatesAutoresizingMaskIntoConstraints equal false")
        XCTAssertFalse(summaryView.daysLabel.translatesAutoresizingMaskIntoConstraints, "The daysLabel should have translatesAutoresizingMaskIntoConstraints equal false")
        XCTAssertFalse(summaryView.summaryLabel.translatesAutoresizingMaskIntoConstraints, "The summaryLabel should have translatesAutoresizingMaskIntoConstraints equal false")
        XCTAssertFalse(summaryView.seeMoreButton.translatesAutoresizingMaskIntoConstraints, "The seeMoreButton should have translatesAutoresizingMaskIntoConstraints equal false")
        
        // The imageView's image should be UIImage(systemName: "photo.artframe")
        XCTAssertEqual(summaryView.imageView.image, UIImage(systemName: "photo.artframe"), "The imageView should contain the image \(String(describing: UIImage(systemName: "photo.artframe"))) but it contains \(String(describing: summaryView.imageView.image))")
        
        // The imageView's tintColor should be .label
        XCTAssertEqual(summaryView.imageView.tintColor, .label, "The imageView's tintColor should be .label, but it is \(String(describing: summaryView.imageView.tintColor))")

        // The imageView's contentMode should be .scaleAspectFit
        XCTAssertEqual(summaryView.imageView.contentMode, .scaleAspectFit, "The imageView's contentMode should be .scaleAspectFit, but it is \(summaryView.imageView.contentMode)")
        
        // The genresLabel's numberOfLines should be 0
        XCTAssertEqual(summaryView.genresLabel.numberOfLines, 0, "The genresLabel's numberOfLines should be 0, but it is \(summaryView.genresLabel.numberOfLines)")

        // The genresLabel's text should be 'Genres: genre1, genre2, genre3'
        XCTAssertEqual(summaryView.genresLabel.text, "Genres: genre1, genre2, genre3", "The genresLabel's text should be 'Genres: genre1, genre2, genre3', but it is \(String(describing: summaryView.genresLabel.text))")
        
        // The timeLabel's numberOfLines should be 0
        XCTAssertEqual(summaryView.timeLabel.numberOfLines, 0, "The timeLabel's numberOfLines should be 0, but it is \(summaryView.timeLabel.numberOfLines)")
        
        // The timeLabel's text should be 'Time: 22:00'
        XCTAssertEqual(summaryView.timeLabel.text, "Time: 22:00", "The timeLabel's text should be 'Time: 22:00', but it is \(String(describing: summaryView.timeLabel.text))")
        
        // The daysLabel's numberOfLines should be 0
        XCTAssertEqual(summaryView.daysLabel.numberOfLines, 0, "The daysLabel's numberOfLines should be 0, but it is \(summaryView.daysLabel.numberOfLines)")
        
        // The daysLabel's text should be 'Days: Monday, Wednesday'
        XCTAssertEqual(summaryView.daysLabel.text, "Days: Monday, Wednesday", "The daysLabel's text should be 'Days: Monday, Wednesday', but it is \(String(describing: summaryView.daysLabel.text))")
        
        // The summaryLabel's numberOfLines should be 0
        XCTAssertEqual(summaryView.summaryLabel.numberOfLines, 0, "The summaryLabel's numberOfLines should be 0, but it is \(summaryView.summaryLabel.numberOfLines)")
        
        // The summaryLabel's text should be 'Show summary'
        XCTAssertEqual(summaryView.summaryLabel.text, summary, "The summaryLabel's text should be \(summary), but it is \(String(describing: summaryView.summaryLabel.text))")
        
        // The seeMoreButton's title for .normal should be 'more'
        XCTAssertEqual(summaryView.seeMoreButton.title(for: .normal), "more", "The seeMoreButton's title for .normal should be 'more', but it is \(String(describing: summaryView.seeMoreButton.title(for: .normal)))")
        
        // The seeMoreButton's title color for .normal should be .secondaryLabel
        XCTAssertEqual(summaryView.seeMoreButton.titleColor(for: .normal), .secondaryLabel, "The seeMoreButton's title color for .normal should be .secondaryLabel, but it is \(String(describing: summaryView.seeMoreButton.titleColor(for: .normal)))")
    }
    
    func testLayout() throws {
        // Given the view not yet laid out
        
        // When layout is called
        summaryView.layout()
        
        // Then
        // The summaryView contains the imageView
        XCTAssertTrue(summaryView.subviews.contains(summaryView.imageView), "The summaryView should contain the imageView")
        // The summaryView contains the timeLabel
        XCTAssertTrue(summaryView.subviews.contains(summaryView.timeLabel), "The summaryView should contain the timeLabel")
        // The summaryView contains the daysLabel
        XCTAssertTrue(summaryView.subviews.contains(summaryView.daysLabel), "The summaryView should contain the daysLabel")
        // The summaryView contains the genresLabel
        XCTAssertTrue(summaryView.subviews.contains(summaryView.genresLabel), "The summaryView should contain the genresLabel")
        // The summaryView contains the summaryLabel
        XCTAssertTrue(summaryView.subviews.contains(summaryView.summaryLabel), "The summaryView should contain the summaryLabel")
        // The summaryView contains the seeMoreButton
        XCTAssertTrue(summaryView.subviews.contains(summaryView.seeMoreButton), "The summaryView should contain the seeMoreButton")
        
        // The imageView's topAnchor should be equal to the summaryView's topAnchor + 2*ShowDetailsSummaryView.verticalMargin
        XCTAssertTrue(summaryView.constraints.contains(where: { constraint in
            (constraint.firstItem as? UIImageView) == summaryView.imageView &&
            constraint.firstAnchor == summaryView.imageView.topAnchor &&
            (constraint.secondItem as? UIView) == summaryView &&
            constraint.secondAnchor == summaryView.topAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == 2*ShowDetailsSummaryView.verticalMargin &&
            constraint.isActive == true
        }), "The summaryView should have the constraint imageView.topAnchor == summaryView.topAnchor + \(2*ShowDetailsSummaryView.verticalMargin), but it wasn't found")
        
        // The imageView's leadingAnchor should be equal to the summaryView's leadingAnchor + 2*ShowDetailsSummaryView.horizontalMargin
        XCTAssertTrue(summaryView.constraints.contains(where: { constraint in
            (constraint.firstItem as? UIImageView) == summaryView.imageView &&
            constraint.firstAnchor == summaryView.imageView.leadingAnchor &&
            (constraint.secondItem as? UIView) == summaryView &&
            constraint.secondAnchor == summaryView.leadingAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == 2*ShowDetailsSummaryView.horizontalMargin &&
            constraint.isActive == true
        }), "The summaryView should have the constraint imageView.leadingAnchor == summaryView.leadingAnchor + \(2*ShowDetailsSummaryView.horizontalMargin), but it wasn't found")
        
        // The imageView's widthAnchor should be equal to 210
        XCTAssertTrue(summaryView.imageView.constraints.contains(where: { constraint in
            (constraint.firstItem as? UIImageView) == summaryView.imageView &&
            constraint.firstAnchor == summaryView.imageView.widthAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == 210 &&
            constraint.isActive == true
        }), "The imageView should have the constraint imageView.widthAnchor == 210, but it wasn't found")

        // The imageView's heightAnchor should be equal to 295
        XCTAssertTrue(summaryView.imageView.constraints.contains(where: { constraint in
            (constraint.firstItem as? UIImageView) == summaryView.imageView &&
            constraint.firstAnchor == summaryView.imageView.heightAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == 295 &&
            constraint.isActive == true
        }), "The imageView should have the constraint imageView.heightAnchor == 295, but it wasn't found")

        // The genresLabel's topAnchor should be equal to the summaryView's topAnchor + 2*ShowDetailsSummaryView.verticalMargin
        XCTAssertTrue(summaryView.constraints.contains(where: { constraint in
            (constraint.firstItem as? UILabel) == summaryView.genresLabel &&
            constraint.firstAnchor == summaryView.genresLabel.topAnchor &&
            (constraint.secondItem as? UIView) == summaryView &&
            constraint.secondAnchor == summaryView.topAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == 2*ShowDetailsSummaryView.verticalMargin &&
            constraint.isActive == true
        }), "The summaryView should have the constraint genresLabel.topAnchor == summaryView.topAnchor + \(2*ShowDetailsSummaryView.verticalMargin), but it wasn't found")

        // The genresLabel's trailingAnchor should be equal to the summaryView's trailingAnchor -2*ShowDetailsSummaryView.horizontalMargin
        XCTAssertTrue(summaryView.constraints.contains(where: { constraint in
            (constraint.firstItem as? UILabel) == summaryView.genresLabel &&
            constraint.firstAnchor == summaryView.genresLabel.trailingAnchor &&
            (constraint.secondItem as? UIView) == summaryView &&
            constraint.secondAnchor == summaryView.trailingAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == -2*ShowDetailsSummaryView.horizontalMargin &&
            constraint.isActive == true
        }), "The summaryView should have the constraint genresLabel.trailingAnchor == summaryView.trailingAnchor - \(2*ShowDetailsSummaryView.horizontalMargin), but it wasn't found")
        
        // The genresLabel's leadingAnchor should be equal to the imageView's trailingAnchor +2*ShowDetailsSummaryView.horizontalMargin
        XCTAssertTrue(summaryView.constraints.contains(where: { constraint in
            (constraint.firstItem as? UILabel) == summaryView.genresLabel &&
            constraint.firstAnchor == summaryView.genresLabel.leadingAnchor &&
            (constraint.secondItem as? UIImageView) == summaryView.imageView &&
            constraint.secondAnchor == summaryView.imageView.trailingAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == +2*ShowDetailsSummaryView.horizontalMargin &&
            constraint.isActive == true
        }), "The summaryView should have the constraint genresLabel.leadingAnchor == imageView.trailingAnchor + \(2*ShowDetailsSummaryView.horizontalMargin), but it wasn't found")
        
        // The timeLabel's topAnchor should be equal to the genresLabel's bottomAnchor +2*ShowDetailsSummaryView.verticalMargin
        XCTAssertTrue(summaryView.constraints.contains(where: { constraint in
            (constraint.firstItem as? UILabel) == summaryView.timeLabel &&
            constraint.firstAnchor == summaryView.timeLabel.topAnchor &&
            (constraint.secondItem as? UILabel) == summaryView.genresLabel &&
            constraint.secondAnchor == summaryView.genresLabel.bottomAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == +2*ShowDetailsSummaryView.verticalMargin &&
            constraint.isActive == true
        }), "The summaryView should have the constraint timeLabel.topAnchor == genresLabel.bottomAnchor + \(2*ShowDetailsSummaryView.verticalMargin), but it wasn't found")
        
        // The timeLabel's leadingAnchor should be equal to the imageView's trailingAnchor +2*ShowDetailsSummaryView.horizontalMargin
        XCTAssertTrue(summaryView.constraints.contains(where: { constraint in
            (constraint.firstItem as? UILabel) == summaryView.timeLabel &&
            constraint.firstAnchor == summaryView.timeLabel.leadingAnchor &&
            (constraint.secondItem as? UIImageView) == summaryView.imageView &&
            constraint.secondAnchor == summaryView.imageView.trailingAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == +2*ShowDetailsSummaryView.horizontalMargin &&
            constraint.isActive == true
        }), "The summaryView should have the constraint timeLabel.leadingAnchor == imageView.trailingAnchor + \(2*ShowDetailsSummaryView.horizontalMargin), but it wasn't found")
        
        // The timeLabel's trailingAnchor should be equal to the summaryView's trailingAnchor -2*ShowDetailsSummaryView.horizontalMargin
        XCTAssertTrue(summaryView.constraints.contains(where: { constraint in
            (constraint.firstItem as? UILabel) == summaryView.timeLabel &&
            constraint.firstAnchor == summaryView.timeLabel.trailingAnchor &&
            (constraint.secondItem as? UIView) == summaryView &&
            constraint.secondAnchor == summaryView.trailingAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == -2*ShowDetailsSummaryView.horizontalMargin &&
            constraint.isActive == true
        }), "The summaryView should have the constraint timeLabel.trailingAnchor == summaryView.trailingAnchor - \(2*ShowDetailsSummaryView.horizontalMargin), but it wasn't found")

        // The daysLabel's topAnchor should be equal to the timeLabel's bottomAnchor +2*ShowDetailsSummaryView.verticalMargin
        XCTAssertTrue(summaryView.constraints.contains(where: { constraint in
            (constraint.firstItem as? UILabel) == summaryView.daysLabel &&
            constraint.firstAnchor == summaryView.daysLabel.topAnchor &&
            (constraint.secondItem as? UILabel) == summaryView.timeLabel &&
            constraint.secondAnchor == summaryView.timeLabel.bottomAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == +2*ShowDetailsSummaryView.verticalMargin &&
            constraint.isActive == true
        }), "The summaryView should have the constraint daysLabel.topAnchor == timeLabel.bottomAnchor + \(2*ShowDetailsSummaryView.verticalMargin), but it wasn't found")
        
        // The daysLabel's leadingAnchor should be equal to the imageView's trailingAnchor +2*ShowDetailsSummaryView.horizontalMargin
        XCTAssertTrue(summaryView.constraints.contains(where: { constraint in
            (constraint.firstItem as? UILabel) == summaryView.daysLabel &&
            constraint.firstAnchor == summaryView.daysLabel.leadingAnchor &&
            (constraint.secondItem as? UIImageView) == summaryView.imageView &&
            constraint.secondAnchor == summaryView.imageView.trailingAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == +2*ShowDetailsSummaryView.horizontalMargin &&
            constraint.isActive == true
        }), "The summaryView should have the constraint daysLabel.leadingAnchor == imageView.trailingAnchor + \(2*ShowDetailsSummaryView.horizontalMargin), but it wasn't found")
        
        // The daysLabel's trailingAnchor should be equal to the summaryView's trailingAnchor -2*ShowDetailsSummaryView.horizontalMargin
        XCTAssertTrue(summaryView.constraints.contains(where: { constraint in
            (constraint.firstItem as? UILabel) == summaryView.daysLabel &&
            constraint.firstAnchor == summaryView.daysLabel.trailingAnchor &&
            (constraint.secondItem as? UIView) == summaryView &&
            constraint.secondAnchor == summaryView.trailingAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == -2*ShowDetailsSummaryView.horizontalMargin &&
            constraint.isActive == true
        }), "The summaryView should have the constraint daysLabel.trailingAnchor == summaryView.trailingAnchor - \(2*ShowDetailsSummaryView.horizontalMargin), but it wasn't found")
        
        // The summaryLabel's topAnchor should be equal to the imageView's bottomAnchor +2*ShowDetailsSummaryView.verticalMargin
        XCTAssertTrue(summaryView.constraints.contains(where: { constraint in
            (constraint.firstItem as? UILabel) == summaryView.summaryLabel &&
            constraint.firstAnchor == summaryView.summaryLabel.topAnchor &&
            (constraint.secondItem as? UIImageView) == summaryView.imageView &&
            constraint.secondAnchor == summaryView.imageView.bottomAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == +2*ShowDetailsSummaryView.verticalMargin &&
            constraint.isActive == true
        }), "The summaryView should have the constraint summaryLabel.topAnchor == imageView.bottomAnchor + \(2*ShowDetailsSummaryView.verticalMargin), but it wasn't found")
        
        // The summaryLabel's leadingAnchor should be equal to the summaryView's leadingAnchor +2*ShowDetailsSummaryView.horizontalMargin
        XCTAssertTrue(summaryView.constraints.contains(where: { constraint in
            (constraint.firstItem as? UILabel) == summaryView.summaryLabel &&
            constraint.firstAnchor == summaryView.summaryLabel.leadingAnchor &&
            (constraint.secondItem as? UIView) == summaryView &&
            constraint.secondAnchor == summaryView.leadingAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == +2*ShowDetailsSummaryView.horizontalMargin &&
            constraint.isActive == true
        }), "The summaryView should have the constraint summaryLabel.leadingAnchor == summaryView.leadingAnchor + \(2*ShowDetailsSummaryView.horizontalMargin), but it wasn't found")
        
        // The summaryLabel's trailingAnchor should be equal to the seeMoreButton's leadingAnchor -ShowDetailsSummaryView.horizontalMargin
        XCTAssertTrue(summaryView.constraints.contains(where: { constraint in
            (constraint.firstItem as? UILabel) == summaryView.summaryLabel &&
            constraint.firstAnchor == summaryView.summaryLabel.trailingAnchor &&
            (constraint.secondItem as? UIButton) == summaryView.seeMoreButton &&
            constraint.secondAnchor == summaryView.seeMoreButton.leadingAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == -ShowDetailsSummaryView.horizontalMargin &&
            constraint.isActive == true
        }), "The summaryView should have the constraint summaryLabel.trailingAnchor == seeMoreButton.leadingAnchor - \(ShowDetailsSummaryView.horizontalMargin), but it wasn't found")
        
        // The summaryLabel's bottomAnchor should be equal to the summaryView's bottomAnchor -2*ShowDetailsSummaryView.verticalMargin
        XCTAssertTrue(summaryView.constraints.contains(where: { constraint in
            (constraint.firstItem as? UILabel) == summaryView.summaryLabel &&
            constraint.firstAnchor == summaryView.summaryLabel.bottomAnchor &&
            (constraint.secondItem as? UIView) == summaryView &&
            constraint.secondAnchor == summaryView.bottomAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == -2*ShowDetailsSummaryView.verticalMargin &&
            constraint.isActive == true
        }), "The summaryView should have the constraint summaryLabel.bottomAnchor == summaryView.bottomAnchor - \(2*ShowDetailsSummaryView.verticalMargin), but it wasn't found")

        // The summaryLabel's horizontal contentCompressionResistancePriority should be equal to .defaultLow
        XCTAssertEqual(summaryView.summaryLabel.contentCompressionResistancePriority(for: .horizontal), .defaultLow, "The summaryLabel's horizontal contentCompressionResistancePriority should be equal to .defaultLow, but it is \(summaryView.summaryLabel.contentCompressionResistancePriority(for: .horizontal))")
        
        // The seeMoreButton's horizontal contentCompressionResistancePriority should be equal to .defaultHigh
        XCTAssertEqual(summaryView.seeMoreButton.contentCompressionResistancePriority(for: .horizontal), .defaultHigh, "The seeMoreButton's horizontal contentCompressionResistancePriority should be equal to .defaultHigh, but it is \(summaryView.seeMoreButton.contentCompressionResistancePriority(for: .horizontal))")
        
        // The seeMoreButton's trailingAnchor should be equal to the summaryView's trailingAnchor -2*ShowDetailsSummaryView.horizontalMargin
        XCTAssertTrue(summaryView.constraints.contains(where: { constraint in
            (constraint.firstItem as? UIButton) == summaryView.seeMoreButton &&
            constraint.firstAnchor == summaryView.seeMoreButton.trailingAnchor &&
            (constraint.secondItem as? UIView) == summaryView &&
            constraint.secondAnchor == summaryView.trailingAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == -2*ShowDetailsSummaryView.horizontalMargin &&
            constraint.isActive == true
        }), "The summaryView should have the constraint seeMoreButton.trailingAnchor == summaryView.trailingAnchor - \(2*ShowDetailsSummaryView.horizontalMargin), but it wasn't found")
        
        // The seeMoreButton's bottomAnchor should be equal to the summaryView's bottomAnchor -2*ShowDetailsSummaryView.verticalMargin
        XCTAssertTrue(summaryView.constraints.contains(where: { constraint in
            (constraint.firstItem as? UIButton) == summaryView.seeMoreButton &&
            constraint.firstAnchor == summaryView.seeMoreButton.bottomAnchor &&
            (constraint.secondItem as? UIView) == summaryView &&
            constraint.secondAnchor == summaryView.bottomAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == -2*ShowDetailsSummaryView.verticalMargin &&
            constraint.isActive == true
        }), "The summaryView should have the constraint seeMoreButton.bottomAnchor == summaryView.bottomAnchor - \(2*ShowDetailsSummaryView.verticalMargin), but it wasn't found")
    }
    
    func testSeeMoreButtonPressed() {
        // Given the instantiated view
        // With a delegate set
        class MockDelegate: ShowDetailsSummaryViewDelegate {
            func seeMoreButtonPressed() {
                seeMoreButtonPressedCalled = true
            }
            
            var seeMoreButtonPressedCalled = false
        }
        let mockDelegate = MockDelegate()
        summaryView.delegate = mockDelegate
        
        // When seeMoreButtonPressedIsCalled
        summaryView.seeMoreButtonPressed()
        
        // Then the delegate's seeMoreButtonPressed method should be called
        XCTAssertTrue(mockDelegate.seeMoreButtonPressedCalled, "The delegate's seeMoreButtonPressed method should be called, seeMoreButtonPressedCalled should be true")
    }
    
    func testConfigure() throws {
        // Given the viewModel with no show set
        summaryView.viewModel.show = nil
        
        // When configure is called
        let show = TVShow(id: 1)
        summaryView.configure(forShow: show)
        
        // Then the viewModel's show should be the given show
        XCTAssertEqual(summaryView.viewModel.show, show, "The viewModel's show should be the given show (\(show)), but it is \(String(describing: summaryView.viewModel.show))")
    }
    
    func testUpdateView() throws {
        // Given the instantiated view
        
        let expectation = self.expectation(description: "ShowDetailsSummaryViewTests updateView expectation")

        // When updateView is called with a given image
        let image = UIImage(systemName: "xmark")
        summaryView.updateView(forImage: image, completion: {
            // Then the imageView contains the given image
            XCTAssertEqual(self.summaryView.imageView.image, image, "The summaryView should contain the image \(String(describing: image)) but it contains \(String(describing: self.summaryView.imageView.image))")
            expectation.fulfill()
        })

        self.wait(for: [expectation], timeout: 5)
    }
}
