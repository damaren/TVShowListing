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
        // A view model with that returns "Show Name" for the showName
        class MockViewModel: ShowDetailsViewModelProtocol {
            var showName: String = ""
            var numberOfSections: Int = 0
            var showSummary: String = ""
            func configure(forShow show: TVShows.TVShow, withProvider provider: TVShows.Provider) {}
            func getNumberOfRows(inSection section: Int) -> Int { return 0 }
            func getEpisode(forIndexPath indexPath: IndexPath) -> TVShows.Episode { return Episode() }
            init(showName: String) {
                self.showName = showName
            }
        }
        
        let showName = "Show Name"
        let viewModel = MockViewModel(showName: showName)
        vc.viewModel = viewModel
        vc.summaryView = UIView()
        
        // When setup is called
        vc.setup()
        
        // Then
        // All the components should have translatesAutoresizingMaskIntoConstraints equal false
        XCTAssertEqual(vc.summaryView?.translatesAutoresizingMaskIntoConstraints, false, "The summaryView translatesAutoresizingMaskIntoConstraints should be false, but it is \(String(describing: vc.summaryView?.translatesAutoresizingMaskIntoConstraints))")
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
        XCTAssertEqual(vc.summaryView?.backgroundColor, .systemBackground, "The summaryView's backgroundColor should be .systemBackground but it is \(String(describing: vc.summaryView?.backgroundColor))")
        
        // The episodesTableView's dataSource should ve the view controller (vc)
        XCTAssertEqual(vc.episodesTableView.dataSource as? ShowDetailsViewController, vc, "The episodesTableView's dataSource should ve the view controller (vc) but it is \(String(describing: vc.episodesTableView.dataSource))")
        
        // The episodesTableView's delegate should ve the view controller (vc)
        XCTAssertEqual(vc.episodesTableView.delegate as? ShowDetailsViewController, vc, "The episodesTableView's delegate should ve the view controller (vc) but it is \(String(describing: vc.episodesTableView.delegate))")

        // The episodesTableView's backgroundColor should be .systemBackground
        XCTAssertEqual(vc.episodesTableView.backgroundColor, .systemBackground, "The episodesTableView's backgroundColor should be .systemBackground but it is \(String(describing: vc.episodesTableView.backgroundColor))")
    }
    
    func testLayoutViews() throws {
        // Given the view controller not yet laid out
        class MockViewModel: ShowDetailsViewModelProtocol {
            var showName: String = ""
            var numberOfSections: Int = 0
            var showSummary: String = ""
            func configure(forShow show: TVShows.TVShow, withProvider provider: TVShows.Provider) {}
            func getNumberOfRows(inSection section: Int) -> Int { return 0 }
            func getEpisode(forIndexPath indexPath: IndexPath) -> TVShows.Episode { return Episode() }
        }
        
        vc.configure(show: TVShow(), viewModel: MockViewModel(), summaryView: UIView())
        
        // When layout is called
        vc.layoutViews()
        
        guard let summaryView = vc.summaryView else {
            fatalError("The summaryView should have been initialized with the vc.configure method")
        }
        
        // Then
        // The view contains the summaryView
        XCTAssertTrue(vc.view.subviews.contains(summaryView), "The vc's view should contain the summaryView")
        // The view contains the episodesTableView
        XCTAssertTrue(vc.view.subviews.contains(vc.episodesTableView), "The vc's view should contain the episodesTableView")
        
        // The summaryView's topAnchor should be equal to the safeAreaLayoutGuide's topAnchor
        XCTAssertTrue(vc.view.constraints.contains(where: { constraint in
            (constraint.firstItem as? UIView) == vc.summaryView &&
            constraint.firstAnchor == summaryView.topAnchor &&
            (constraint.secondItem as? UILayoutGuide) == vc.view.safeAreaLayoutGuide &&
            constraint.secondAnchor == vc.view.safeAreaLayoutGuide.topAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == 0 &&
            constraint.isActive == true
        }), "The view should have the constraint summaryView.topAnchor == safeAreaLayoutGuide.topAnchor, but it wasn't found")

        // The summaryView's leadingAnchor should be equal to the view's leadingAnchor
        XCTAssertTrue(vc.view.constraints.contains(where: { constraint in
            (constraint.firstItem as? UIView) == vc.summaryView &&
            constraint.firstAnchor == summaryView.leadingAnchor &&
            (constraint.secondItem as? UIView) == vc.view &&
            constraint.secondAnchor == vc.view.leadingAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == 0 &&
            constraint.isActive == true
        }), "The view should have the constraint summaryView.leadingAnchor == view.leadingAnchor, but it wasn't found")

        // The summaryView's trailingAnchor should be equal to the view's trailingAnchor
        XCTAssertTrue(vc.view.constraints.contains(where: { constraint in
            (constraint.firstItem as? UIView) == vc.summaryView &&
            constraint.firstAnchor == summaryView.trailingAnchor &&
            (constraint.secondItem as? UIView) == vc.view &&
            constraint.secondAnchor == vc.view.trailingAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == 0 &&
            constraint.isActive == true
        }), "The view should have the constraint summaryView.trailingAnchor == view.trailingAnchor, but it wasn't found")

        // The summaryView's heightAnchor should be equal to 400
        XCTAssertTrue(summaryView.constraints.contains(where: { constraint in
            (constraint.firstItem as? UIView) == vc.summaryView &&
            constraint.firstAnchor == summaryView.heightAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == 400 &&
            constraint.isActive == true
        }), "The searchView should have the constraint summaryView.heightAnchor == 400, but it wasn't found")

        // The episodesTableView's topAnchor should be equal to the summaryView's bottomAnchor
        XCTAssertTrue(vc.view.constraints.contains(where: { constraint in
            (constraint.firstItem as? UITableView) == vc.episodesTableView &&
            constraint.firstAnchor == vc.episodesTableView.topAnchor &&
            (constraint.secondItem as? UIView) == vc.summaryView &&
            constraint.secondAnchor == summaryView.bottomAnchor &&
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
        // Given a mock view model that checks if configure was called with a given show
        class MockViewModel: ShowDetailsViewModelProtocol {
            var showName: String = ""
            var numberOfSections: Int = 0
            var showSummary: String = ""
            var show: TVShow? = nil
            func configure(forShow show: TVShows.TVShow, withProvider provider: TVShows.Provider) {
                self.show = show
            }
            func getNumberOfRows(inSection section: Int) -> Int { return 0 }
            func getEpisode(forIndexPath indexPath: IndexPath) -> TVShows.Episode { return Episode() }
        }
        
        let viewModel = MockViewModel()
        
        // When configure is called with a show
        let show = TVShow(id: 0)
        vc.configure(show: show, viewModel: viewModel, summaryView: UIView())
        
        // Then the view model's configure and the summaryView's configure should get called with the given show
        XCTAssertEqual(viewModel.show, show, "The view model should contain the given show (\(show)) but it contains \(String(describing: viewModel.show))")
    }
    
    func testUpdateView() throws {
        // Given the viewController's tableView with no cells in it
        
        class MockViewModel: ShowDetailsViewModelProtocol {
            var showName: String = ""
            var numberOfSections: Int {
                get {
                    return episodes.count
                }
            }
            var showSummary: String = ""
            var episodes: [[Episode]] = []
            func configure(forShow show: TVShows.TVShow, withProvider provider: TVShows.Provider) {}
            func getNumberOfRows(inSection section: Int) -> Int { return episodes[section].count }
            func getEpisode(forIndexPath indexPath: IndexPath) -> TVShows.Episode { return episodes[indexPath.section][indexPath.row] }
        }
        
        let mockViewModel = MockViewModel()
        
        mockViewModel.episodes = []
        vc.viewModel = mockViewModel
        vc.summaryView = UIView()
        vc.episodesTableView.reloadData()
        vc.setup()
        vc.view.addSubview(vc.episodesTableView)
        vc.episodesTableView.frame = vc.view.bounds // give as much space as possible for the table view to layout it's visible cells
        vc.view.layoutSubviews() // without this, the table view is not calling the cell for row at
        
        let expectation = self.expectation(description: "ShowDetailsViewControllerTests updateView expectation")
        
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
        mockViewModel.episodes = episodes
        
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
            func seeMoreButtonPressed(inViewcontroller: TVShows.ShowDetailsViewController, forShowSummary summary: String?) {}
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
        class MockViewModel: ShowDetailsViewModelProtocol {
            var showName: String = ""
            var numberOfSections: Int = 0
            var showSummary: String = ""
            func configure(forShow show: TVShows.TVShow, withProvider provider: TVShows.Provider) {}
            func getNumberOfRows(inSection section: Int) -> Int { return 0 }
            func getEpisode(forIndexPath indexPath: IndexPath) -> TVShows.Episode { return Episode() }
            init(numberOfSection: Int) {
                self.numberOfSections = numberOfSection
            }
        }
        
        let mockNumberOfSections = 1
        let mockViewModel = MockViewModel(numberOfSection: mockNumberOfSections)
        
        vc.viewModel = mockViewModel
        
        // When numberOfSections is called
        let numberOfSections = vc.numberOfSections(in: vc.episodesTableView)
        
        // Then the number of sections should be equal to the value returned by the viewModel
        XCTAssertEqual(numberOfSections, mockNumberOfSections, "Then the number of sections (\(numberOfSections)) should be equal to the value returned by the viewModel (\(mockNumberOfSections))")
    }
    
    func testNumberOfRows() throws {
        // Given the viewModel with the episodes set
        class MockViewModel: ShowDetailsViewModelProtocol {
            var showName: String = ""
            var numberOfSections: Int = 0
            var showSummary: String = ""
            var episodes: [[Episode]] = []
            func configure(forShow show: TVShows.TVShow, withProvider provider: TVShows.Provider) {}
            func getNumberOfRows(inSection section: Int) -> Int { return numberOfRows[section] }
            func getEpisode(forIndexPath indexPath: IndexPath) -> TVShows.Episode { return Episode() }
            
            let numberOfRows: [Int]
            
            init(numberOfRows: [Int]) {
                self.numberOfRows = numberOfRows
            }
        }
        
        let numberOfRowsPerSection: [Int] = [1, 3, 7]
        
        let mockViewModel = MockViewModel(numberOfRows: numberOfRowsPerSection)
        vc.viewModel = mockViewModel
        
        // When numberOfRows is called
        for i in 0..<numberOfRowsPerSection.count {
            // Then the number of rows of section i should be equal to the number of episodes in the index i of the episodes array
            XCTAssertEqual(vc.tableView(vc.episodesTableView, numberOfRowsInSection: i), numberOfRowsPerSection[i], "The number of rows of section \(i) should be equal to the number of episodes in the index \(i) of the numberOfRowsPerSection array")
        }
    }
    
    func testCellForRowAt() throws {
        // Given the viewController's tableView with no cells in it
        
        class MockViewModel: ShowDetailsViewModelProtocol {
            var showName: String = ""
            var numberOfSections: Int {
                get {
                    return episodes.count
                }
            }
            var showSummary: String = ""
            var episodes: [[Episode]] = []
            func configure(forShow show: TVShows.TVShow, withProvider provider: TVShows.Provider) {}
            func getNumberOfRows(inSection section: Int) -> Int { return episodes[section].count }
            func getEpisode(forIndexPath indexPath: IndexPath) -> TVShows.Episode { return episodes[indexPath.section][indexPath.row] }
        }
        
        let mockViewModel = MockViewModel()
        mockViewModel.episodes = []
        
        vc.viewModel = mockViewModel
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
        mockViewModel.episodes = episodes
        
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
            func seeMoreButtonPressed(inViewcontroller: TVShows.ShowDetailsViewController, forShowSummary summary: String?) {}
            
            var selectedEpisodeWasCalled: Bool = false
            func selectedEpisode(episode: TVShows.Episode, withShowTitle showTitle: String, withAnimation: Bool) {
                selectedEpisodeWasCalled = true
            }
            
            func backButtonPressed(inViewcontroller: TVShows.ShowDetailsViewController, withAnimation: Bool) {}
        }
        let mockDelegate = MockShowDetailsDelegate()
        
        // Given the instantiated viewController with the delegate set
        vc.delegate = mockDelegate
        
        class MockViewModel: ShowDetailsViewModelProtocol {
            var showName: String = ""
            var numberOfSections: Int {
                get {
                    return episodes.count
                }
            }
            var showSummary: String = ""
            var episodes: [[Episode]] = []
            func configure(forShow show: TVShows.TVShow, withProvider provider: TVShows.Provider) {}
            func getNumberOfRows(inSection section: Int) -> Int { return 0 }
            func getEpisode(forIndexPath indexPath: IndexPath) -> TVShows.Episode { return Episode() }
        }
        
        let mockViewModel = MockViewModel()
        vc.viewModel = mockViewModel
        
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
        mockViewModel.episodes = episodes
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
        class MockShowDetailsDelegate: UIViewController, ShowDetailsViewControllerDelegate {
            func seeMoreButtonPressed(inViewcontroller: TVShows.ShowDetailsViewController, forShowSummary summary: String?) {
                seeMoreButtonPressedWasCalled = true
            }
            var seeMoreButtonPressedWasCalled: Bool = false
            func selectedEpisode(episode: TVShows.Episode, withShowTitle showTitle: String, withAnimation: Bool) {}
            
            func backButtonPressed(inViewcontroller: TVShows.ShowDetailsViewController, withAnimation: Bool) {}
        }
        let mockDelegate = MockShowDetailsDelegate()
        vc.delegate = mockDelegate
        
        // When seeMoreButtonPressed is called
        vc.seeMoreButtonPressed()
        
        // Then the delegate's seeMoreButtonPressed method should be called
        XCTAssertTrue(mockDelegate.seeMoreButtonPressedWasCalled, "The delegate's seeMoreButtonPressed method should be called, mockDelegate.seeMoreButtonPressedWasCalled should be true")
    }
}
