//
//  ShowDetailsViewControllerTests.swift
//  TVShowsUnitTests
//
//  Created by José Damaren on 24/07/23.
//

import XCTest

@testable import TVShows

final class ShowDetailsViewControllerTests: XCTestCase {
    var vc: ShowDetailsViewController!
    
    override func setUp() {
        super.setUp()

        vc = ShowDetailsViewController()
    }

    override func tearDown() {
        super.tearDown()
        vc = nil
    }
    
    func testSetup() throws {
        // Given the instantiated view controller
        // The view model with a show with name set
        let showName = "Show Name"
        let show = TVShow(id: 1, name: showName)
        vc.viewModel.show = show
        
        // When setup is called
        vc.setup()
        
        // Then
        // All the components should have translatesAutoresizingMaskIntoConstraints equal false
        XCTAssertEqual(vc.summaryView.translatesAutoresizingMaskIntoConstraints, false, "The summaryView translatesAutoresizingMaskIntoConstraints should be false, but it is \(vc.summaryView.translatesAutoresizingMaskIntoConstraints)")
        XCTAssertEqual(vc.episodesTableView.translatesAutoresizingMaskIntoConstraints, false, "The episodesTableView translatesAutoresizingMaskIntoConstraints should be false, but it is \(vc.episodesTableView.translatesAutoresizingMaskIntoConstraints)")

        // The title should be equal to view model's show name
        XCTAssertEqual(vc.title, showName, "The title should be \(showName) but it is \(String(describing: vc.title))")
        
        // The view's backgroundColor should be .systemBackground
        XCTAssertEqual(vc.view.backgroundColor, .systemBackground, "The view's backgroundColor should be .systemBackground but it is \(String(describing: vc.view.backgroundColor))")
        
        // The navigation bar's left button should have the "chevron.left" system image
        XCTAssertEqual(vc.navigationItem.leftBarButtonItem?.image, UIImage(systemName: "chevron.left"), "The navigation bar's left button should have the 'chevron.left' system image, but it is \(String(describing: vc.navigationItem.leftBarButtonItem?.image))")
        
        // The navigation bar's left button should have the .label tint
        XCTAssertEqual(vc.navigationItem.leftBarButtonItem?.tintColor, .label, "The navigation bar's left button should have the .label tint, but it is \(String(describing: vc.navigationItem.leftBarButtonItem?.tintColor))")
        
        // The summaryView's backgroundColor should be .systemBackground
        XCTAssertEqual(vc.summaryView.backgroundColor, .systemBackground, "The summaryView's backgroundColor should be .systemBackground but it is \(String(describing: vc.summaryView.backgroundColor))")
        
        // The summaryView's viewModel should have the show set
        XCTAssertEqual(vc.summaryView.viewModel.show, show, "The summaryView's viewModel should have the show set, but it has \(String(describing: vc.summaryView.viewModel.show))")
        
        // The summaryView's delegate should be view controller (vc)
        XCTAssertEqual(vc.summaryView.delegate as? ShowDetailsViewController, vc, "The summaryView's delegate should be view controller (vc) but it is \(String(describing: vc.summaryView.delegate))")
        
        // The episodesTableView's dataSource should ve the view controller (vc)
        XCTAssertEqual(vc.episodesTableView.dataSource as? ShowDetailsViewController, vc, "The episodesTableView's dataSource should ve the view controller (vc) but it is \(String(describing: vc.episodesTableView.dataSource))")
        
        // The episodesTableView's delegate should ve the view controller (vc)
        XCTAssertEqual(vc.episodesTableView.delegate as? ShowDetailsViewController, vc, "The episodesTableView's delegate should ve the view controller (vc) but it is \(String(describing: vc.episodesTableView.delegate))")

        // The episodesTableView's backgroundColor should be .systemBackground
        XCTAssertEqual(vc.episodesTableView.backgroundColor, .systemBackground, "The episodesTableView's backgroundColor should be .systemBackground but it is \(String(describing: vc.episodesTableView.backgroundColor))")
    }
    
    func testLayoutViews() throws {
        // Given the view controller not yet laid out
        
        // When layout is called
        vc.layoutViews()
        
        // Then
        // The view contains the summaryView
        XCTAssertTrue(vc.view.subviews.contains(vc.summaryView), "The vc's view should contain the summaryView")
        // The view contains the episodesTableView
        XCTAssertTrue(vc.view.subviews.contains(vc.episodesTableView), "The vc's view should contain the episodesTableView")
        
        // The summaryView's topAnchor should be equal to the safeAreaLayoutGuide's topAnchor
        XCTAssertTrue(vc.view.constraints.contains(where: { constraint in
            (constraint.firstItem as? ShowDetailsSummaryView) == vc.summaryView &&
            constraint.firstAnchor == vc.summaryView.topAnchor &&
            (constraint.secondItem as? UILayoutGuide) == vc.view.safeAreaLayoutGuide &&
            constraint.secondAnchor == vc.view.safeAreaLayoutGuide.topAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == 0 &&
            constraint.isActive == true
        }), "The view should have the constraint summaryView.topAnchor == safeAreaLayoutGuide.topAnchor, but it wasn't found")

        // The summaryView's leadingAnchor should be equal to the view's leadingAnchor
        XCTAssertTrue(vc.view.constraints.contains(where: { constraint in
            (constraint.firstItem as? ShowDetailsSummaryView) == vc.summaryView &&
            constraint.firstAnchor == vc.summaryView.leadingAnchor &&
            (constraint.secondItem as? UIView) == vc.view &&
            constraint.secondAnchor == vc.view.leadingAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == 0 &&
            constraint.isActive == true
        }), "The view should have the constraint summaryView.leadingAnchor == view.leadingAnchor, but it wasn't found")

        // The summaryView's trailingAnchor should be equal to the view's trailingAnchor
        XCTAssertTrue(vc.view.constraints.contains(where: { constraint in
            (constraint.firstItem as? ShowDetailsSummaryView) == vc.summaryView &&
            constraint.firstAnchor == vc.summaryView.trailingAnchor &&
            (constraint.secondItem as? UIView) == vc.view &&
            constraint.secondAnchor == vc.view.trailingAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == 0 &&
            constraint.isActive == true
        }), "The view should have the constraint summaryView.trailingAnchor == view.trailingAnchor, but it wasn't found")

        // The summaryView's heightAnchor should be equal to 400
        XCTAssertTrue(vc.summaryView.constraints.contains(where: { constraint in
            (constraint.firstItem as? ShowDetailsSummaryView) == vc.summaryView &&
            constraint.firstAnchor == vc.summaryView.heightAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == 400 &&
            constraint.isActive == true
        }), "The searchView should have the constraint summaryView.heightAnchor == 400, but it wasn't found")

        // The episodesTableView's topAnchor should be equal to the summaryView's bottomAnchor
        XCTAssertTrue(vc.view.constraints.contains(where: { constraint in
            (constraint.firstItem as? UITableView) == vc.episodesTableView &&
            constraint.firstAnchor == vc.episodesTableView.topAnchor &&
            (constraint.secondItem as? ShowDetailsSummaryView) == vc.summaryView &&
            constraint.secondAnchor == vc.summaryView.bottomAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == 0 &&
            constraint.isActive == true
        }), "The view should have the constraint episodesTableView.topAnchor == summaryView.bottomAnchor, but it wasn't found")

        // The episodesTableView's leadingAnchor should be equal to the view's leadingAnchor
        XCTAssertTrue(vc.view.constraints.contains(where: { constraint in
            (constraint.firstItem as? UITableView) == vc.episodesTableView &&
            constraint.firstAnchor == vc.episodesTableView.leadingAnchor &&
            (constraint.secondItem as? UIView) == vc.view &&
            constraint.secondAnchor == vc.view.leadingAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == 0 &&
            constraint.isActive == true
        }), "The view should have the constraint episodesTableView.leadingAnchor == view.leadingAnchor, but it wasn't found")

        // The episodesTableView's trailingAnchor should be equal to the view's trailingAnchor
        XCTAssertTrue(vc.view.constraints.contains(where: { constraint in
            (constraint.firstItem as? UITableView) == vc.episodesTableView &&
            constraint.firstAnchor == vc.episodesTableView.trailingAnchor &&
            (constraint.secondItem as? UIView) == vc.view &&
            constraint.secondAnchor == vc.view.trailingAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == 0 &&
            constraint.isActive == true
        }), "The view should have the constraint episodesTableView.trailingAnchor == view.trailingAnchor, but it wasn't found")

        // The episodesTableView's bottomAnchor should be equal to the safeAreaLayoutGuide's bottomAnchor
        XCTAssertTrue(vc.view.constraints.contains(where: { constraint in
            (constraint.firstItem as? UITableView) == vc.episodesTableView &&
            constraint.firstAnchor == vc.episodesTableView.bottomAnchor &&
            (constraint.secondItem as? UILayoutGuide) == vc.view.safeAreaLayoutGuide &&
            constraint.secondAnchor == vc.view.safeAreaLayoutGuide.bottomAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == 0 &&
            constraint.isActive == true
        }), "The view should have the constraint episodesTableView.bottomAnchor == safeAreaLayoutGuide.bottomAnchor, but it wasn't found")
    }
    
    func testConfigure() throws {
        // Given the viewModel with no show set
        vc.viewModel.show = nil
        
        // When configure is called with a show
        let show = TVShow(id: 0)
        vc.configure(show: show)
        
        // Then the view model should contain the given show
        XCTAssertEqual(vc.viewModel.show, show, "The view model should contain the given show (\(show)) but it contains \(String(describing: vc.viewModel.show))")
    }
    
    func testUpdateView() throws {
        // Given the viewController's tableView with no cells in it
        vc.viewModel.episodes = []
        vc.episodesTableView.reloadData()
        vc.setup()
        vc.view.addSubview(vc.episodesTableView)
        vc.episodesTableView.frame = vc.view.bounds // give as much space as possible for the table view to layout it's visible cells
        vc.view.layoutSubviews() // without this, the table view is not calling the cell for row at
        
        // The view model containing a list of episodes
        let episodes: [[Episode]] = [
            [
                Episode(id: 1, name: "Episode 1", season: 1, number: 1),
                Episode(id: 2, name: "Episode 2", season: 1, number: 2),
                Episode(id: 3, name: "Episode 3", season: 1, number: 3)
            ],
            [
                Episode(id: 4, name: "Episode 4", season: 2, number: 1),
                Episode(id: 5, name: "Episode 5", season: 2, number: 2),
                Episode(id: 6, name: "Episode 6", season: 2, number: 3)
            ],
            [
                Episode(id: 7, name: "Episode 7", season: 3, number: 1),
                Episode(id: 8, name: "Episode 8", season: 3, number: 2),
                Episode(id: 9, name: "Episode 9", season: 3, number: 3)
            ]
        ]
        vc.viewModel.episodes = episodes
        
        let expectation = self.expectation(description: "ShowDetailsViewControllerTests updateView expectation")
        
        // When updateView is called
        vc.updateView(completion: {
            
            // Then
            for i in 0..<episodes.count {
                // The number of cells in the table view for each section should be equal to the number of episodes in the respective season
                XCTAssertEqual(self.vc.episodesTableView.numberOfRows(inSection: i), episodes[i].count, "The number of cells in the table view's section \(i) (\(self.vc.episodesTableView.numberOfRows(inSection: i))) should be equal to the number of episodes in the respective season (\(episodes[i].count))")
                
                for j in 0..<episodes[i].count {
                    // The cell's title should be equal to the episode's name
                    XCTAssertEqual((self.vc.episodesTableView.cellForRow(at: IndexPath(row: j, section: i)) as! EpisodeTableViewCell).titleLabel.text, episodes[i][j].name, "The cell's title (\(String(describing: (self.vc.episodesTableView.cellForRow(at: IndexPath(row: j, section: i)) as! EpisodeTableViewCell).titleLabel.text))) should be equal to the episode's name (\(String(describing: episodes[i][j].name)))")
                    
                    // The cell's number label should be 'Ep. <episode number>:'
                    let numberText = "Ep. \(episodes[i][j].number!):"
                    XCTAssertEqual((self.vc.episodesTableView.cellForRow(at: IndexPath(row: j, section: i)) as! EpisodeTableViewCell).numberLabel.text, numberText, "The cell's number text (\(String(describing: (self.vc.episodesTableView.cellForRow(at: IndexPath(row: j, section: i)) as! EpisodeTableViewCell).numberLabel.text))) should be equal to \(numberText)")
                }
                
            }
            expectation.fulfill()
        })
        
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testBackButtonPressed() throws {
        class MockShowDetailsDelegate: UIViewController, ShowDetailsViewControllerDelegate {
            var backButtonPressedWasCalled: Bool = false
            func selectedEpisode(episode: TVShows.Episode, withShowTitle showTitle: String, withAnimation: Bool) {}
            
            func backButtonPressed(inViewcontroller: TVShows.ShowDetailsViewController, withAnimation: Bool) {
                backButtonPressedWasCalled = true
            }
        }
        let mockDelegate = MockShowDetailsDelegate()
        
        // Given the instantiated viewController with the delegate set
        vc.delegate = mockDelegate
        
        // When backButtonPressed gets called
        vc.backButtonPressed()
        
        // Then the delegate's backButtonPressed method should be called
        XCTAssertTrue(mockDelegate.backButtonPressedWasCalled, "The delegate's backButtonPressed method should be called, mockDelegate.backButtonPressedWasCalled should be true")
    }
    
    func testNumberOfSections() throws {
        // Given the viewModel with the episodes set
        let episodes: [[Episode]] = [
            [
                Episode(id: 1, name: "Episode 1", season: 1, number: 1),
                Episode(id: 2, name: "Episode 2", season: 1, number: 2),
                Episode(id: 3, name: "Episode 3", season: 1, number: 3)
            ],
            [
                Episode(id: 4, name: "Episode 4", season: 2, number: 1),
                Episode(id: 5, name: "Episode 5", season: 2, number: 2),
                Episode(id: 6, name: "Episode 6", season: 2, number: 3)
            ],
            [
                Episode(id: 7, name: "Episode 7", season: 3, number: 1),
                Episode(id: 8, name: "Episode 8", season: 3, number: 2),
                Episode(id: 9, name: "Episode 9", season: 3, number: 3)
            ]
        ]
        vc.viewModel.episodes = episodes
        
        // When numberOfSections is called
        let numberOfSections = vc.numberOfSections(in: vc.episodesTableView)
        
        // Then the number of sections should be equal to the number of elements in the episodes array
        XCTAssertEqual(numberOfSections, episodes.count, "Then the number of sections (\(numberOfSections)) should be equal to the number of elements in the episodes array (\(episodes.count))")
    }
    
    func testNumberOfRows() throws {
        // Given the viewModel with the episodes set
        let episodes: [[Episode]] = [
            [
                Episode(id: 1, name: "Episode 1", season: 1, number: 1),
                Episode(id: 2, name: "Episode 2", season: 1, number: 2),
                Episode(id: 3, name: "Episode 3", season: 1, number: 3)
            ],
            [
                Episode(id: 4, name: "Episode 4", season: 2, number: 1),
                Episode(id: 5, name: "Episode 5", season: 2, number: 2),
                Episode(id: 6, name: "Episode 6", season: 2, number: 3)
            ],
            [
                Episode(id: 7, name: "Episode 7", season: 3, number: 1),
                Episode(id: 8, name: "Episode 8", season: 3, number: 2),
                Episode(id: 9, name: "Episode 9", season: 3, number: 3)
            ]
        ]
        vc.viewModel.episodes = episodes
        
        // When numberOfRows is called
        for i in 0..<episodes.count {
            // Then the number of rows of section i should be equal to the number of episodes in the index i of the episodes array
            XCTAssertEqual(vc.tableView(vc.episodesTableView, numberOfRowsInSection: i), episodes[i].count, "The number of rows of section \(i) should be equal to the number of episodes in the index \(i) of the episodes array")
        }
    }
    
    func testCellForRowAt() throws {
        // Given the viewController's tableView with no cells in it
        vc.viewModel.episodes = []
        vc.episodesTableView.reloadData()
        vc.episodesTableView.register(EpisodeTableViewCell.self, forCellReuseIdentifier: EpisodeTableViewCell.reuseIdentifier) // this is necessary to call cellForRowAt
        // The view model with a list of episodes
        let episodes: [[Episode]] = [
            [
                Episode(id: 1, name: "Episode 1", season: 1, number: 1),
                Episode(id: 2, name: "Episode 2", season: 1, number: 2),
                Episode(id: 3, name: "Episode 3", season: 1, number: 3)
            ],
            [
                Episode(id: 4, name: "Episode 4", season: 2, number: 1),
                Episode(id: 5, name: "Episode 5", season: 2, number: 2),
                Episode(id: 6, name: "Episode 6", season: 2, number: 3)
            ],
            [
                Episode(id: 7, name: "Episode 7", season: 3, number: 1),
                Episode(id: 8, name: "Episode 8", season: 3, number: 2),
                Episode(id: 9, name: "Episode 9", season: 3, number: 3)
            ]
        ]
        vc.viewModel.episodes = episodes
        
        // When cellForRowAt is called
        let seasonIndexForTesting = 0
        let episodeIndexForTesting = 2
        let episodeForTesting = episodes[seasonIndexForTesting][episodeIndexForTesting]
        let cell = vc.tableView(vc.episodesTableView, cellForRowAt: IndexPath(row: episodeIndexForTesting, section: seasonIndexForTesting))
        
        // Then the cell is configured with the correct episode (episodeForTesting)
        // The cell's title should be the episode's name
        XCTAssertEqual((cell as! EpisodeTableViewCell).titleLabel.text, episodeForTesting.name, "The cell should have a titleLabel with text \(String(describing: episodeForTesting.name)) but it has \(String(describing: (cell as! EpisodeTableViewCell).titleLabel.text))")
        
        // The cell should have 'Ep. <number>:' as it's numberLabel's text
        let numberText = "Ep. \(episodeForTesting.number!):"
        XCTAssertEqual((cell as! EpisodeTableViewCell).numberLabel.text, numberText, "The cell should have a numberLabel with text \(numberText) but it has \(String(describing: (cell as! EpisodeTableViewCell).numberLabel.text))")
    }
    
    func testDidSelectRowAt() throws {
        class MockShowDetailsDelegate: UIViewController, ShowDetailsViewControllerDelegate {
            var selectedEpisodeWasCalled: Bool = false
            func selectedEpisode(episode: TVShows.Episode, withShowTitle showTitle: String, withAnimation: Bool) {
                selectedEpisodeWasCalled = true
            }
            
            func backButtonPressed(inViewcontroller: TVShows.ShowDetailsViewController, withAnimation: Bool) {}
        }
        let mockDelegate = MockShowDetailsDelegate()
        
        // Given the instantiated viewController with the delegate set
        vc.delegate = mockDelegate
        // The table view with rows in in
        let episodes: [[Episode]] = [
            [
                Episode(id: 1, name: "Episode 1", season: 1, number: 1),
                Episode(id: 2, name: "Episode 2", season: 1, number: 2),
                Episode(id: 3, name: "Episode 3", season: 1, number: 3)
            ],
            [
                Episode(id: 4, name: "Episode 4", season: 2, number: 1),
                Episode(id: 5, name: "Episode 5", season: 2, number: 2),
                Episode(id: 6, name: "Episode 6", season: 2, number: 3)
            ],
            [
                Episode(id: 7, name: "Episode 7", season: 3, number: 1),
                Episode(id: 8, name: "Episode 8", season: 3, number: 2),
                Episode(id: 9, name: "Episode 9", season: 3, number: 3)
            ]
        ]
        vc.viewModel.episodes = episodes
        vc.episodesTableView.reloadData()
        
        // When backButtonPressed gets called
        vc.tableView(vc.episodesTableView, didSelectRowAt: IndexPath(row: 1, section: 1))
        
        // Then the delegate's selectedEpisode method should be called
        XCTAssertTrue(mockDelegate.selectedEpisodeWasCalled, "The delegate's selectedEpisode method should be called, mockDelegate.selectedEpisodeWasCalled should be true")
        // After the selection, the tableView should deselect the cell
        XCTAssertNil(vc.episodesTableView.indexPathForSelectedRow, "After the selection, the tableView should deselect the cell, but there's a selection (\(String(describing: vc.episodesTableView.indexPathForSelectedRow)))")
    }
    
    func testViewForHeaderInSection() throws {
        // Given the instantiated vc
        
        // When viewForHeader is called
        let sectionForTesting = 0
        let headerView = vc.tableView(vc.episodesTableView, viewForHeaderInSection: sectionForTesting)!
        
        // Then
        // The view's height anchor should be equal to 50
        XCTAssertTrue(headerView.constraints.contains(where: { constraint in
            (constraint.firstItem as? UIView) == headerView &&
            constraint.firstAnchor == headerView.heightAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == 50 &&
            constraint.isActive == true
        }), "The headerView should have the constraint headerView.heightAnchor == 50, but it wasn't found")
        
        // The view's backgroundColor should be .systemGray4
        XCTAssertEqual(headerView.backgroundColor?.cgColor, UIColor.systemGray4.cgColor, "The view's backgroundColor should be .systemGray4 but it is \(String(describing: headerView.backgroundColor))")
        
        // The view should contain a UILabel as it's subview
        guard let seasonLabel = headerView.subviews.first(where: { v in v is UILabel }) as? UILabel else {
            XCTFail("The view should contain a UILabel as it's subview, but it doesn't")
            return
        }
        
        // The seasonLabel's translatesAutoresizingMaskIntoConstraints should be false
        XCTAssertFalse(seasonLabel.translatesAutoresizingMaskIntoConstraints, "The seasonLabel's translatesAutoresizingMaskIntoConstraints should be false, but it isn't")

        // The seasonLabel's leadingAnchor should be equal to the headerView's leadingAnchor
        XCTAssertTrue(headerView.constraints.contains(where: { constraint in
            (constraint.firstItem as? UILabel) == seasonLabel &&
            constraint.firstAnchor == seasonLabel.leadingAnchor &&
            (constraint.secondItem as? UIView) == headerView &&
            constraint.secondAnchor == headerView.leadingAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == 8 &&
            constraint.isActive == true
        }), "The headerView should have the constraint seasonLabel.leadingAnchor == headerView.leadingAnchor, but it wasn't found")
        
        // The seasonLabel's centerYAnchor should be equal to the headerView's centerYAnchor
        XCTAssertTrue(headerView.constraints.contains(where: { constraint in
            (constraint.firstItem as? UILabel) == seasonLabel &&
            constraint.firstAnchor == seasonLabel.centerYAnchor &&
            (constraint.secondItem as? UIView) == headerView &&
            constraint.secondAnchor == headerView.centerYAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == 0 &&
            constraint.isActive == true
        }), "The headerView should have the constraint seasonLabel.centerYAnchor == headerView.centerYAnchor, but it wasn't found")
        
        // The seasonLabel should have the text "Season <section +1>"
        XCTAssertEqual(seasonLabel.text, "Season \(sectionForTesting + 1)", "The seasonLabel should have the text 'Season \(sectionForTesting + 1)' but it has \(String(describing: seasonLabel.text))")
    }
    
    func testHeightForRowAt() throws {
        // Given the instantiated vc
        
        // When heightForRowAt is called
        let height = vc.tableView(vc.episodesTableView, heightForRowAt: IndexPath(row: 0, section: 0))
        
        // Then the height should be equal to EpisodeTableViewCell.cellHeight
        XCTAssertEqual(height, EpisodeTableViewCell.cellHeight, "The height should be equal to \(EpisodeTableViewCell.cellHeight) but it is \(height)")
    }
    
    func testSeeMore() throws {
        // Given the instantiated vc
        // The view model with a show with a description set
        let showSummary = "Show summary"
        let show = TVShow(id: 1, summary: showSummary)
        vc.viewModel.show = show
        
        // When seeMoreButtonPressed is called
        vc.seeMoreButtonPressed()
        
        // Then the showDescriptionVC should not be nil
        XCTAssertNotNil(vc.showDescriptionVC, "The showDescriptionVC should not be nil")
        // The showDescriptionVC should have the view model's show summary as it's descriptionLabel's text
        XCTAssertEqual(vc.showDescriptionVC?.descriptionLabel.text, showSummary, "The showDescriptionVC should have the view model's show summary (\(showSummary)) as it's descriptionLabel's text, but it has \(String(describing: vc.showDescriptionVC?.descriptionLabel.text))")
    }
    
    func testShowDescriptionViewControllerDismissed() throws {
        // Given the showDescriptionViewController not nil
        vc.showDescriptionVC = ShowDescriptionViewController()
        
        // When showDescriptionViewControllerDismissed is called
        vc.showDescriptionViewControllerDismissed(viewController: vc.showDescriptionVC!)
        
        // Then showDescriptionViewController should be nil
        XCTAssertNil(vc.showDescriptionVC, "Then showDescriptionViewController should be nil")
    }
}
