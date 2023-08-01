//
//  EpisodeTableViewCellTests.swift
//  TVShowsUnitTests
//
//  Created by José Damaren on 01/08/23.
//

import XCTest

@testable import TVShows

final class EpisodeTableViewCellTests: XCTestCase {
    var cell: EpisodeTableViewCell!

    override func setUp() {
        super.setUp()

        cell = EpisodeTableViewCell()
    }

    override func tearDown() {
        super.tearDown()
        cell = nil
    }
    
    func testConfigure() throws {
        // Given the cell with no episode set
        cell.episode = nil

        // When configure is called with a given episode
        let episode = Episode(id: 1)
        cell.configure(forEpisode: episode)

        // Then the cell contains the given episode
        XCTAssertEqual(cell.episode, episode, "The cell should contain the given episode (\(episode)) but it contained \(String(describing: cell.episode))")
    }
    
    func testSetup() throws {
        // Given the cell with an episode set
        let episodeName = "Episode name"
        let episodeNumber = 1
        let episode = Episode(id: 1, name: episodeName, number: episodeNumber)
        cell.episode = episode
        
        // When setup is called
        cell.setup()
        
        // Then
        // All the components should have translatesAutoresizingMaskIntoConstraints equal false
        XCTAssertEqual(cell.numberLabel.translatesAutoresizingMaskIntoConstraints, false, "The numberLabel translatesAutoresizingMaskIntoConstraints should be false, but it is \(cell.numberLabel.translatesAutoresizingMaskIntoConstraints)")
        XCTAssertEqual(cell.titleLabel.translatesAutoresizingMaskIntoConstraints, false, "The titleLabel translatesAutoresizingMaskIntoConstraints should be false, but it is \(cell.titleLabel.translatesAutoresizingMaskIntoConstraints)")
        XCTAssertEqual(cell.containerView.translatesAutoresizingMaskIntoConstraints, false, "The containerView translatesAutoresizingMaskIntoConstraints should be false, but it is \(cell.containerView.translatesAutoresizingMaskIntoConstraints)")
        
        // The number label's text should be "Ep. 1:"
        XCTAssertEqual(cell.numberLabel.text, "Ep. 1:", "The number label's text should be 'Ep. 1:' but it is \(String(describing: cell.numberLabel.text))")
        
        // The titleLabel's adjustsFontSizeToFitWidth should be true
        XCTAssertTrue(cell.titleLabel.adjustsFontSizeToFitWidth, "The titleLabel's adjustsFontSizeToFitWidth should be true")
        
        // The titleLabel's minimumScaleFactor should be 0.8
        XCTAssertEqual(cell.titleLabel.minimumScaleFactor, 0.8, accuracy: 0.01, "The titleLabel's minimumScaleFactor should be 0.8, but it is \(cell.titleLabel.minimumScaleFactor)")
        
        // The titleLabel's textAlignment should be .right
        XCTAssertEqual(cell.titleLabel.textAlignment, .right, "The titleLabel's textAlignment should be .right, but it is \(cell.titleLabel.textAlignment)")
        
        // The titleLabel's text should be "Episode name"
        XCTAssertEqual(cell.titleLabel.text, "Episode name", "The titleLabel's text should be 'Episode name', but it is \(String(describing: cell.titleLabel.text))")
        
        // The containerView's backgroundColor should be .secondarySystemBackground
        XCTAssertEqual(cell.containerView.backgroundColor, .secondarySystemBackground, "The containerView's backgroundColor should be .secondarySystemBackground, but it is \(String(describing: cell.containerView.backgroundColor))")
    }
    
    func testLayout() throws {
        // Given the cell not yet laid out

        // When layout is called
        cell.layout()

        // Then
        // The contentView contains the containerView
        XCTAssertTrue(cell.contentView.subviews.contains(cell.containerView), "The cell's contentView should contain the containerView")
        // The containerView contains the numberLabel
        XCTAssertTrue(cell.containerView.subviews.contains(cell.numberLabel), "The cell's containerView should contain the numberLabel")
        // The containerView contains the titleLabel
        XCTAssertTrue(cell.containerView.subviews.contains(cell.titleLabel), "The cell's containerView should contain the titleLabel")
        
        // The numberLabel's leadingAnchor should have a space equal to 2 * horizontalMargin from the containerView's leadingAnchor
        XCTAssertTrue(cell.containerView.constraints.contains(where: { constraint in
            (constraint.firstItem as? UILabel) == cell.numberLabel &&
            constraint.firstAnchor == cell.numberLabel.leadingAnchor &&
            (constraint.secondItem as? UIView) == cell.containerView &&
            constraint.secondAnchor == cell.containerView.leadingAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == 2 * EpisodeTableViewCell.horizontalMargin &&
            constraint.isActive == true
        }), "The containerView should have the constraint numberLabel.leadingAnchor == containerView.leadingAnchor + \(2 * EpisodeTableViewCell.horizontalMargin), but it wasn't found")
        
        // The numberLabel's centerYAnchor should be equal to the containerView's centerYAnchor
        XCTAssertTrue(cell.containerView.constraints.contains(where: { constraint in
            (constraint.firstItem as? UILabel) == cell.numberLabel &&
            constraint.firstAnchor == cell.numberLabel.centerYAnchor &&
            (constraint.secondItem as? UIView) == cell.containerView &&
            constraint.secondAnchor == cell.containerView.centerYAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == 0 &&
            constraint.isActive == true
        }), "The containerView should have the constraint numberLabel.centerYAnchor == containerView.centerYAnchor, but it wasn't found")
        
        // The numberLabel's horizontal contentCompressionResistancePriority should be equal to .defaultHigh
        XCTAssertEqual(cell.numberLabel.contentCompressionResistancePriority(for: .horizontal), .defaultHigh, "The numberLabel's horizontal contentCompressionResistancePriority should be equal to .defaultHigh, but it is \(cell.numberLabel.contentCompressionResistancePriority(for: .horizontal))")
        
        // The titleLabel's leadingAnchor should be equal to the numberLabel's trailingAnchor + 2 * horizontalMargin
        XCTAssertTrue(cell.containerView.constraints.contains(where: { constraint in
            (constraint.firstItem as? UILabel) == cell.titleLabel &&
            constraint.firstAnchor == cell.titleLabel.leadingAnchor &&
            (constraint.secondItem as? UILabel) == cell.numberLabel &&
            constraint.secondAnchor == cell.numberLabel.trailingAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == 2 * EpisodeTableViewCell.horizontalMargin &&
            constraint.isActive == true
        }), "The containerView should have the constraint titleLabel.leadingAnchor == numberLabel.trailingAnchor + \(2 * EpisodeTableViewCell.horizontalMargin), but it wasn't found")
        
        // The titleLabel's trailingAnchor should be equal to the containerView's trailingAnchor - 2 * horizontalMargin
        XCTAssertTrue(cell.containerView.constraints.contains(where: { constraint in
            (constraint.firstItem as? UILabel) == cell.titleLabel &&
            constraint.firstAnchor == cell.titleLabel.trailingAnchor &&
            (constraint.secondItem as? UIView) == cell.containerView &&
            constraint.secondAnchor == cell.containerView.trailingAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == -2 * EpisodeTableViewCell.horizontalMargin &&
            constraint.isActive == true
        }), "The containerView should have the constraint titleLabel.trailingAnchor == containerView.trailingAnchor - \(2 * EpisodeTableViewCell.horizontalMargin), but it wasn't found")
        
        // The titleLabel's centerYAnchor should be equal to the containerView's centerYAnchor
        XCTAssertTrue(cell.containerView.constraints.contains(where: { constraint in
            (constraint.firstItem as? UILabel) == cell.titleLabel &&
            constraint.firstAnchor == cell.titleLabel.centerYAnchor &&
            (constraint.secondItem as? UIView) == cell.containerView &&
            constraint.secondAnchor == cell.containerView.centerYAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == 0 &&
            constraint.isActive == true
        }), "The containerView should have the constraint titleLabel.centerYAnchor == containerView.centerYAnchor, but it wasn't found")
        
        // The titleLabel's horizontal contentCompressionResistancePriority should be equal to .defaultLow
        XCTAssertEqual(cell.titleLabel.contentCompressionResistancePriority(for: .horizontal), .defaultLow, "The titleLabel's horizontal contentCompressionResistancePriority should be equal to .defaultLow, but it is \(cell.numberLabel.contentCompressionResistancePriority(for: .horizontal))")
        
        // The containerView's leadingAnchor should be equal to the cell's leadingAnchor + EpisodeTableViewCell.horizontalMargin
        XCTAssertTrue(cell.constraints.contains(where: { constraint in
            (constraint.firstItem as? UIView) == cell.containerView &&
            constraint.firstAnchor == cell.containerView.leadingAnchor &&
            (constraint.secondItem as? UITableViewCell) == cell &&
            constraint.secondAnchor == cell.leadingAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == EpisodeTableViewCell.horizontalMargin &&
            constraint.isActive == true
        }), "The cell should have the constraint containerView.leadingAnchor == cell.leadingAnchor + \(EpisodeTableViewCell.horizontalMargin), but it wasn't found")
        
        // The containerView's topAnchor should be equal to the cell's topAnchor + EpisodeTableViewCell.verticalMargin
        XCTAssertTrue(cell.constraints.contains(where: { constraint in
            (constraint.firstItem as? UIView) == cell.containerView &&
            constraint.firstAnchor == cell.containerView.topAnchor &&
            (constraint.secondItem as? UITableViewCell) == cell &&
            constraint.secondAnchor == cell.topAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == EpisodeTableViewCell.verticalMargin &&
            constraint.isActive == true
        }), "The cell should have the constraint containerView.topAnchor == cell.topAnchor + \(EpisodeTableViewCell.verticalMargin), but it wasn't found")

        // The containerView's bottomAnchor should be equal to the cell's bottomAnchor - EpisodeTableViewCell.verticalMargin
        XCTAssertTrue(cell.constraints.contains(where: { constraint in
            (constraint.firstItem as? UIView) == cell.containerView &&
            constraint.firstAnchor == cell.containerView.bottomAnchor &&
            (constraint.secondItem as? UITableViewCell) == cell &&
            constraint.secondAnchor == cell.bottomAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == -EpisodeTableViewCell.verticalMargin &&
            constraint.isActive == true
        }), "The cell should have the constraint containerView.bottomAnchor == cell.bottomAnchor - \(EpisodeTableViewCell.verticalMargin), but it wasn't found")
        
        // The containerView's trailingAnchor should be equal to the cell's trailingAnchor - EpisodeTableViewCell.horizontalMargin
        XCTAssertTrue(cell.constraints.contains(where: { constraint in
            (constraint.firstItem as? UIView) == cell.containerView &&
            constraint.firstAnchor == cell.containerView.trailingAnchor &&
            (constraint.secondItem as? UITableViewCell) == cell &&
            constraint.secondAnchor == cell.trailingAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == -EpisodeTableViewCell.horizontalMargin &&
            constraint.isActive == true
        }), "The cell should have the constraint containerView.trailingAnchor == cell.trailingAnchor - \(EpisodeTableViewCell.horizontalMargin), but it wasn't found")
    }
    
    func testGenerateEpisodeNumber() throws {
        // Given the cell withan episode with number set
        let episodeNumber = 2
        cell.episode = Episode(id: 1, number: episodeNumber)
        
        // When generateEpisodeNumberText is called
        let numberText = cell.generateEpisodeNumberText()
        
        // Then the resulting text shoul be equal to "Ep. <episode number>:"
        XCTAssertEqual(numberText, "Ep. \(episodeNumber):", "The resulting text shoul be equal to 'Ep. \(episodeNumber):', but it is \(numberText)")
    }

}

