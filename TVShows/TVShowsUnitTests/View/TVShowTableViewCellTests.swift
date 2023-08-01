//
//  TVShowTableViewCellTests.swift
//  TVShowsUnitTests
//
//  Created by José Damaren on 18/07/23.
//

import XCTest

@testable import TVShows

final class TVShowTableViewCellTests: XCTestCase {
    var cell: TVShowTableViewCell!

    override func setUp() {
        super.setUp()

        cell = TVShowTableViewCell()
    }

    override func tearDown() {
        super.tearDown()
        cell = nil
    }
    
    func testConfigure() throws {
        // Given the cell's viewModel with no show set
        cell.viewModel.show = nil
        
        // When configure is called with a given show
        let show = TVShow(id: 1)
        cell.configure(forShow: show)
        
        // Then the cell's viewModel contains the given show
        XCTAssertEqual(cell.viewModel.show, show, "The cell's viewModel should contain the given show (\(show)) but it contained \(String(describing: cell.viewModel.show))")
    }
    
    func testSetup() throws {
        // Given the viewModel with a show with name and genres set
        let showName = "Show Name"
        let genre1 = "Genre1"
        let genre2 = "Genre2"
        let genres = [genre1, genre2]
        let show = TVShow(id: 1, name: showName, genres: genres)
        cell.viewModel.show = show
        
        // When setup is called
        cell.setup()
        
        // Then
        // All the components should have translatesAutoresizingMaskIntoConstraints equal false
        XCTAssertEqual(cell.image.translatesAutoresizingMaskIntoConstraints, false, "The image translatesAutoresizingMaskIntoConstraints should be false, but it is \(cell.image.translatesAutoresizingMaskIntoConstraints)")
        XCTAssertEqual(cell.titleLabel.translatesAutoresizingMaskIntoConstraints, false, "The titleLabel translatesAutoresizingMaskIntoConstraints should be false, but it is \(cell.titleLabel.translatesAutoresizingMaskIntoConstraints)")
        XCTAssertEqual(cell.genresLabel.translatesAutoresizingMaskIntoConstraints, false, "The genresLabel translatesAutoresizingMaskIntoConstraints should be false, but it is \(cell.genresLabel.translatesAutoresizingMaskIntoConstraints)")
        XCTAssertEqual(cell.containerView.translatesAutoresizingMaskIntoConstraints, false, "The containerView translatesAutoresizingMaskIntoConstraints should be false, but it is \(cell.containerView.translatesAutoresizingMaskIntoConstraints)")
        // The title label should contain the show name
        XCTAssertEqual(cell.titleLabel.text, showName, "The titleLabel should contain the text \(showName) but it contains \(String(describing: cell.titleLabel.text))")
        // The title label's numberOfLines should be 0
        XCTAssertEqual(cell.titleLabel.numberOfLines, 0, "The title label's numberOfLines should be 0 but it is \(String(describing: cell.titleLabel.numberOfLines))")
        // The genres label should contain the genres text
        let genresText = "Genres: \(genre1), \(genre2)"
        XCTAssertEqual(cell.genresLabel.text, genresText, "The genresLabel should contain the text \(genresText) but it contains \(String(describing: cell.genresLabel.text))")
        // The genres label's numberOfLines should be 0
        XCTAssertEqual(cell.genresLabel.numberOfLines, 0, "The genres label's numberOfLines should be 0 but it is \(String(describing: cell.genresLabel.numberOfLines))")
        // The image should contain the placeholder image UIImage(systemName: "photo.artframe")
        XCTAssertEqual(cell.image.image, UIImage(systemName: "photo.artframe"), "The image should contain the the placeholder image (UIImage(systemName: \"photo.artframe\")) but it contains \(String(describing: cell.image.image))")
        // The image's contentMode should be .scaleAspectFit
        XCTAssertEqual(cell.image.contentMode, .scaleAspectFit, "The image's contentMode should be .scaleAspectFit but it is \(String(describing: cell.image.contentMode))")
        // The image's tintColor should be .label
        XCTAssertEqual(cell.image.tintColor, .label, "The image's tintColor should be .label but it is \(String(describing: cell.image.tintColor))")
        // The containerView's backgroundColor should be .secondarySystemBackground
        XCTAssertEqual(cell.containerView.backgroundColor, .secondarySystemBackground, "The containerView's backgroundColor should be .secondarySystemBackground but it is \(String(describing: cell.containerView.backgroundColor))")
    }
    
    func testUpdateView() throws {
        // Given the imageView with no image
        cell.image.image = nil
        
        let expectation = self.expectation(description: "TVShowTableViewCell updateView expectation")

        // When updateView is called with a given image
        let image = UIImage(systemName: "xmark")
        cell.updateView(forImage: image, completion: {
            // Then the imageView contains the given image
            XCTAssertEqual(self.cell.image.image, image, "The cell should contain the image \(String(describing: UIImage(systemName: "xmark"))) but it contains \(String(describing: self.cell.image.image))")
            expectation.fulfill()
        })

        self.wait(for: [expectation], timeout: 5)
    }
    
    func testLayout() throws {
        // Given the cell not yet laid out
        
        // When layout is called
        cell.layout()
        
        // Then
        // The contentView contains the containerView
        XCTAssertTrue(cell.contentView.subviews.contains(cell.containerView), "The cell's contentView should contain the containerView")
        // The containerView contains the image
        XCTAssertTrue(cell.containerView.subviews.contains(cell.image), "The cell's containerView should contain the image")
        // The containerView contains the titleLabel
        XCTAssertTrue(cell.containerView.subviews.contains(cell.titleLabel), "The cell's containerView should contain the titleLabel")
        // The containerView contains the genresLabel
        XCTAssertTrue(cell.containerView.subviews.contains(cell.genresLabel), "The cell's containerView should contain the genresLabel")
        
        // The image's leadingAnchor should have a space equal to horizontalMargin from the containerView's leadingAnchor
        XCTAssertTrue(cell.containerView.constraints.contains(where: { constraint in
            (constraint.firstItem as? UIImageView) == cell.image &&
            constraint.firstAnchor == cell.image.leadingAnchor &&
            (constraint.secondItem as? UIView) == cell.containerView &&
            constraint.secondAnchor == cell.containerView.leadingAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == TVShowTableViewCell.horizontalMargin &&
            constraint.isActive == true
        }), "The containerView should have the constraint image.leadingAnchor == containerView.leadingAnchor + \(TVShowTableViewCell.horizontalMargin), but it wasn't found")
        
        // The image's centerYAnchor should be equal to the containerView's centerYAnchor
        XCTAssertTrue(cell.containerView.constraints.contains(where: { constraint in
            (constraint.firstItem as? UIImageView) == cell.image &&
            constraint.firstAnchor == cell.image.centerYAnchor &&
            (constraint.secondItem as? UIView) == cell.containerView &&
            constraint.secondAnchor == cell.containerView.centerYAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == 0 &&
            constraint.isActive == true
        }), "The containerView should have the constraint image.centerYAnchor == containerView.centerYAnchor, but it wasn't found")
        
        // The image's height anchor should be equal to TVShowTableViewCell.cellHeight - 4 * TVShowTableViewCell.verticalMargin (4 = containerView top and bottom + image top and bottom)
        let imageHeight = TVShowTableViewCell.cellHeight - 4 * TVShowTableViewCell.verticalMargin
        XCTAssertTrue(cell.image.constraints.contains(where: { constraint in
            (constraint.firstItem as? UIImageView) == cell.image &&
            constraint.firstAnchor == cell.image.heightAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == imageHeight &&
            constraint.isActive == true
        }), "The image should have the constraint heightAnchor == TVShowTableViewCell.cellHeight - 4 * TVShowTableViewCell.verticalMargin, but it wasn't found")
        
        // The image's width anchor should be equal to the imageHeight * TVShowTableViewCell.imageAspectRatio
        let imageWidth = imageHeight * TVShowTableViewCell.imageAspectRatio
        XCTAssertTrue(cell.image.constraints.contains(where: { constraint in
            (constraint.firstItem as? UIImageView) == cell.image &&
            constraint.firstAnchor == cell.image.widthAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == imageWidth &&
            constraint.isActive == true
        }), "The image should have the constraint widthAnchor == imageHeight * TVShowTableViewCell.imageAspectRatio, but it wasn't found")
        
        // The titleLabel's leadingAnchor should have a space equal to 2 * horizontalMargin from the image's trailingAnchor
        XCTAssertTrue(cell.containerView.constraints.contains(where: { constraint in
            (constraint.firstItem as? UILabel) == cell.titleLabel &&
            constraint.firstAnchor == cell.titleLabel.leadingAnchor &&
            (constraint.secondItem as? UIImageView) == cell.image &&
            constraint.secondAnchor == cell.image.trailingAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == 2 * TVShowTableViewCell.horizontalMargin &&
            constraint.isActive == true
        }), "The containerView should have the constraint titleLabel.leadingAnchor == image.trailingAnchor + \(2 * TVShowTableViewCell.horizontalMargin), but it wasn't found")
        
        // The titleLabel's trailingAnchor should have a space equal to - 2 * horizontalMargin from the containerView's trailingAnchor
        XCTAssertTrue(cell.containerView.constraints.contains(where: { constraint in
            (constraint.firstItem as? UILabel) == cell.titleLabel &&
            constraint.firstAnchor == cell.titleLabel.trailingAnchor &&
            (constraint.secondItem as? UIView) == cell.containerView &&
            constraint.secondAnchor == cell.containerView.trailingAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == -2 * TVShowTableViewCell.horizontalMargin &&
            constraint.isActive == true
        }), "The containerView should have the constraint titleLabel.trailingAnchor == containerView.trailingAnchor - \(2 * TVShowTableViewCell.horizontalMargin), but it wasn't found")
        
        // The titleLabel's topAnchor should have a space equal to 2 * verticalMargin from the containerView's topAnchor
        XCTAssertTrue(cell.containerView.constraints.contains(where: { constraint in
            (constraint.firstItem as? UILabel) == cell.titleLabel &&
            constraint.firstAnchor == cell.titleLabel.topAnchor &&
            (constraint.secondItem as? UIView) == cell.containerView &&
            constraint.secondAnchor == cell.containerView.topAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == 2 * TVShowTableViewCell.verticalMargin &&
            constraint.isActive == true
        }), "The containerView should have the constraint titleLabel.topAnchor == containerView.topAnchor + \(2 * TVShowTableViewCell.verticalMargin), but it wasn't found")
        
        // The genresLabel's topAnchor should have a space equal to 2 * verticalMargin from the titleLabels's bottomAnchor
        XCTAssertTrue(cell.containerView.constraints.contains(where: { constraint in
            (constraint.firstItem as? UILabel) == cell.genresLabel &&
            constraint.firstAnchor == cell.genresLabel.topAnchor &&
            (constraint.secondItem as? UIView) == cell.titleLabel &&
            constraint.secondAnchor == cell.titleLabel.bottomAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == 2 * TVShowTableViewCell.verticalMargin &&
            constraint.isActive == true
        }), "The containerView should have the constraint genresLabel.topAnchor == titleLabels.bottomAnchor + \(2 * TVShowTableViewCell.verticalMargin), but it wasn't found")
        
        // The genresLabel's leadingAnchor should have a space equal to 2 * horizontalMargin from the image's trailingAnchor
        XCTAssertTrue(cell.containerView.constraints.contains(where: { constraint in
            (constraint.firstItem as? UILabel) == cell.genresLabel &&
            constraint.firstAnchor == cell.genresLabel.leadingAnchor &&
            (constraint.secondItem as? UIView) == cell.image &&
            constraint.secondAnchor == cell.image.trailingAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == 2 * TVShowTableViewCell.horizontalMargin &&
            constraint.isActive == true
        }), "The containerView should have the constraint genresLabel.leadingAnchor == image.trailingAnchor + \(2 * TVShowTableViewCell.horizontalMargin), but it wasn't found")
        
        // The genresLabel's trailingAnchor should have a space equal to - 2 * horizontalMargin from the containerView's trailingAnchor
        XCTAssertTrue(cell.containerView.constraints.contains(where: { constraint in
            (constraint.firstItem as? UILabel) == cell.genresLabel &&
            constraint.firstAnchor == cell.genresLabel.trailingAnchor &&
            (constraint.secondItem as? UIView) == cell.containerView &&
            constraint.secondAnchor == cell.containerView.trailingAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == -2 * TVShowTableViewCell.horizontalMargin &&
            constraint.isActive == true
        }), "The containerView should have the constraint genresLabel.trailingAnchor == containerView.trailingAnchor - \(2 * TVShowTableViewCell.horizontalMargin), but it wasn't found")
        
        // The containerView's leadingAnchor should have a space equal to horizontalMargin from the cell's leadingAnchor
        XCTAssertTrue(cell.constraints.contains(where: { constraint in
            (constraint.firstItem as? UIView) == cell.containerView &&
            constraint.firstAnchor == cell.containerView.leadingAnchor &&
            (constraint.secondItem as? UIView) == cell &&
            constraint.secondAnchor == cell.leadingAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == TVShowTableViewCell.horizontalMargin &&
            constraint.isActive == true
        }), "The cell should have the constraint containerView.leadingAnchor == cell.leadingAnchor + \(TVShowTableViewCell.horizontalMargin), but it wasn't found")
        
        // The containerView's topAnchor should have a space equal to verticalMargin from the cell's topAnchor
        XCTAssertTrue(cell.constraints.contains(where: { constraint in
            (constraint.firstItem as? UIView) == cell.containerView &&
            constraint.firstAnchor == cell.containerView.topAnchor &&
            (constraint.secondItem as? UIView) == cell &&
            constraint.secondAnchor == cell.topAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == TVShowTableViewCell.verticalMargin &&
            constraint.isActive == true
        }), "The cell should have the constraint containerView.topAnchor == cell.topAnchor + \(TVShowTableViewCell.verticalMargin), but it wasn't found")
        
        // The containerView's trailingAnchor should have a space equal to -horizontalMargin from the cell's trailingAnchor
        XCTAssertTrue(cell.constraints.contains(where: { constraint in
            (constraint.firstItem as? UIView) == cell.containerView &&
            constraint.firstAnchor == cell.containerView.trailingAnchor &&
            (constraint.secondItem as? UIView) == cell &&
            constraint.secondAnchor == cell.trailingAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == -TVShowTableViewCell.horizontalMargin &&
            constraint.isActive == true
        }), "The cell should have the constraint containerView.trailingAnchor == cell.trailingAnchor - \(TVShowTableViewCell.horizontalMargin), but it wasn't found")
        
        // The containerView's bottomAnchor should have a space equal to -verticalMargin from the cell's bottomAnchor
        XCTAssertTrue(cell.constraints.contains(where: { constraint in
            (constraint.firstItem as? UIView) == cell.containerView &&
            constraint.firstAnchor == cell.containerView.bottomAnchor &&
            (constraint.secondItem as? UIView) == cell &&
            constraint.secondAnchor == cell.bottomAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == -TVShowTableViewCell.verticalMargin &&
            constraint.isActive == true
        }), "The cell should have the constraint containerView.bottomAnchor == cell.bottomAnchor - \(TVShowTableViewCell.verticalMargin), but it wasn't found")
    }

}
