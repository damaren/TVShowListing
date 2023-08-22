//
//  TVShowSearchViewControllerTests.swift
//  TVShowsUnitTests
//
//  Created by José Damaren on 21/07/23.
//

import XCTest

@testable import TVShows

final class TVShowSearchViewControllerTests: XCTestCase {
    var vc: TVShowSearchViewController!
    
    override func setUp() {
        super.setUp()

        vc = TVShowSearchViewController()
    }

    override func tearDown() {
        super.tearDown()
        vc = nil
    }
    
    func testSetup() {
        // Given the instantiated view controller
        
        // The viewmodel with a given title
        class MockViewModel: TVShowSearchViewModelProtocol {
            var title: String
            
            init(title: String) {
                self.title = title
            }
            
            var numberOfRows: Int = 0
            
            func requestTVShows(withSearchText searchText: String, completion: (() -> ())?) {}
            
            func getShowFor(indexPath: IndexPath) -> TVShows.TVShow {
                return TVShow()
            }
        }
        
        let title = "Test title"
        let viewModel = MockViewModel(title: title)
        vc.viewModel = viewModel
        
        // When setup is called
        vc.setup()
        
        // Then
        // All the components should have translatesAutoresizingMaskIntoConstraints equal false
        XCTAssertEqual(vc.searchView.translatesAutoresizingMaskIntoConstraints, false, "The searchView translatesAutoresizingMaskIntoConstraints should be false, but it is \(vc.searchView.translatesAutoresizingMaskIntoConstraints)")
        XCTAssertEqual(vc.showsTableView.translatesAutoresizingMaskIntoConstraints, false, "The showsTableView translatesAutoresizingMaskIntoConstraints should be false, but it is \(vc.showsTableView.translatesAutoresizingMaskIntoConstraints)")
        
        // The title should be equal to TVShowSearchViewModel.tvShowSearchTitle
        XCTAssertEqual(vc.title, viewModel.title, "The title should be \(title) but it is \(String(describing: vc.title))")
        
        // The view's backgroundColor should be .systemBackground
        XCTAssertEqual(vc.view.backgroundColor, .systemBackground, "The view's backgroundColor should be .systemBackground but it is \(String(describing: vc.view.backgroundColor))")
        
        // The searchView's backgroundColor should be .systemBackground
        XCTAssertEqual(vc.searchView.backgroundColor, .systemBackground, "The searchView's backgroundColor should be .systemBackground but it is \(String(describing: vc.searchView.backgroundColor))")
        
        // The searchView's delegate should be the view controller (vc)
        XCTAssertEqual(vc.searchView.delegate as? TVShowSearchViewController, vc, "The searchView's delegate should be the view controller (vc) but it is \(String(describing: vc.searchView.delegate))")
        
        // The showsTableView's dataSource should ve the view controller (vc)
        XCTAssertEqual(vc.showsTableView.dataSource as? TVShowSearchViewController, vc, "The showsTableView's dataSource should ve the view controller (vc) but it is \(String(describing: vc.showsTableView.dataSource))")
        
        // The showsTableView's delegate should ve the view controller (vc)
        XCTAssertEqual(vc.showsTableView.delegate as? TVShowSearchViewController, vc, "The showsTableView's delegate should ve the view controller (vc) but it is \(String(describing: vc.showsTableView.delegate))")
        
        // The showsTableView's backgroundColor should be .systemBackground
        XCTAssertEqual(vc.showsTableView.backgroundColor, .systemBackground, "The showsTableView's backgroundColor should be .systemBackground but it is \(String(describing: vc.showsTableView.backgroundColor))")
    }
    
    func testLayoutViews() throws {
        // Given the view controller not yet laid out
        
        // When layout is called
        vc.layoutViews()
        
        // Then
        // The view contains the searchView
        XCTAssertTrue(vc.view.subviews.contains(vc.searchView), "The vc's view should contain the searchView")
        // The view contains the showsTableView
        XCTAssertTrue(vc.view.subviews.contains(vc.showsTableView), "The vc's view should contain the showsTableView")
        
        // The searchView's topAnchor should be equal to the safeAreaLayoutGuide's topAnchor
        XCTAssertTrue(vc.view.constraints.contains(where: { constraint in
            (constraint.firstItem as? SearchView) == vc.searchView &&
            constraint.firstAnchor == vc.searchView.topAnchor &&
            (constraint.secondItem as? UILayoutGuide) == vc.view.safeAreaLayoutGuide &&
            constraint.secondAnchor == vc.view.safeAreaLayoutGuide.topAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == 0 &&
            constraint.isActive == true
        }), "The view should have the constraint searchView.topAnchor == safeAreaLayoutGuide.topAnchor, but it wasn't found")
        
        // The searchView's leadingAnchor should be equal to the view's leadingAnchor
        XCTAssertTrue(vc.view.constraints.contains(where: { constraint in
            (constraint.firstItem as? SearchView) == vc.searchView &&
            constraint.firstAnchor == vc.searchView.leadingAnchor &&
            (constraint.secondItem as? UIView) == vc.view &&
            constraint.secondAnchor == vc.view.leadingAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == 0 &&
            constraint.isActive == true
        }), "The view should have the constraint searchView.leadingAnchor == view.leadingAnchor, but it wasn't found")
        
        // The searchView's trailingAnchor should be equal to the view's trailingAnchor
        XCTAssertTrue(vc.view.constraints.contains(where: { constraint in
            (constraint.firstItem as? SearchView) == vc.searchView &&
            constraint.firstAnchor == vc.searchView.trailingAnchor &&
            (constraint.secondItem as? UIView) == vc.view &&
            constraint.secondAnchor == vc.view.trailingAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == 0 &&
            constraint.isActive == true
        }), "The view should have the constraint searchView.trailingAnchor == view.trailingAnchor, but it wasn't found")
        
        // The searchView's heightAnchor should be equal to 60
        XCTAssertTrue(vc.searchView.constraints.contains(where: { constraint in
            (constraint.firstItem as? SearchView) == vc.searchView &&
            constraint.firstAnchor == vc.searchView.heightAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == 60 &&
            constraint.isActive == true
        }), "The searchView should have the constraint searchView.heightAnchor == 60, but it wasn't found")
        
        // The showsTableView's topAnchor should be equal to the searchView's bottomAnchor
        XCTAssertTrue(vc.view.constraints.contains(where: { constraint in
            (constraint.firstItem as? UITableView) == vc.showsTableView &&
            constraint.firstAnchor == vc.showsTableView.topAnchor &&
            (constraint.secondItem as? SearchView) == vc.searchView &&
            constraint.secondAnchor == vc.searchView.bottomAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == 0 &&
            constraint.isActive == true
        }), "The view should have the constraint showsTableView.topAnchor == searchView.bottomAnchor, but it wasn't found")
        
        // The showsTableView's leadingAnchor should be equal to the view's leadingAnchor
        XCTAssertTrue(vc.view.constraints.contains(where: { constraint in
            (constraint.firstItem as? UITableView) == vc.showsTableView &&
            constraint.firstAnchor == vc.showsTableView.leadingAnchor &&
            (constraint.secondItem as? UIView) == vc.view &&
            constraint.secondAnchor == vc.view.leadingAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == 0 &&
            constraint.isActive == true
        }), "The view should have the constraint showsTableView.leadingAnchor == view.leadingAnchor, but it wasn't found")
        
        // The showsTableView's trailingAnchor should be equal to the view's trailingAnchor
        XCTAssertTrue(vc.view.constraints.contains(where: { constraint in
            (constraint.firstItem as? UITableView) == vc.showsTableView &&
            constraint.firstAnchor == vc.showsTableView.trailingAnchor &&
            (constraint.secondItem as? UIView) == vc.view &&
            constraint.secondAnchor == vc.view.trailingAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == 0 &&
            constraint.isActive == true
        }), "The view should have the constraint showsTableView.trailingAnchor == view.trailingAnchor, but it wasn't found")
        
        // The showsTableView's bottomAnchor should be equal to the view's bottomAnchor
        XCTAssertTrue(vc.view.constraints.contains(where: { constraint in
            (constraint.firstItem as? UITableView) == vc.showsTableView &&
            constraint.firstAnchor == vc.showsTableView.bottomAnchor &&
            (constraint.secondItem as? UIView) == vc.view &&
            constraint.secondAnchor == vc.view.bottomAnchor &&
            (constraint.relation == .equal) &&
            constraint.multiplier == 1.0 &&
            constraint.constant == 0 &&
            constraint.isActive == true
        }), "The view should have the constraint showsTableView.bottomAnchor == view.bottomAnchor, but it wasn't found")
    }
    
    func testNumberOfRowsInSection() throws {
        // Given the viewModel with the shows set
        class MockViewModel: TVShowSearchViewModelProtocol {
            var title: String = ""
            
            var numberOfRows: Int = 3
            
            func requestTVShows(withSearchText searchText: String, completion: (() -> ())?) {}
            
            func getShowFor(indexPath: IndexPath) -> TVShows.TVShow {
                return TVShow()
            }
        }
        
        let viewModel: MockViewModel = MockViewModel()
        vc.viewModel = viewModel
        
        // When numberOfRowsInSection is called
        let numberOfRows = vc.tableView(vc.showsTableView, numberOfRowsInSection: 0)
        
        // Then the number of rows should be equal to the number of rows returned by the view model
        XCTAssertEqual(numberOfRows, viewModel.numberOfRows, "The number of rows should be equal to the number of rows returned by the view model (\(viewModel.numberOfRows)) but it is \(numberOfRows)")
    }
    
    func testHeightForRowAt() throws {
        // Given the instantiated vc
        
        // When heightForRowAt is called
        let rowHeight = vc.tableView(vc.showsTableView, heightForRowAt: IndexPath(row: 0, section: 0))
        
        // Then the rowHeight should be equal to TVShowTableViewCell.cellHeight
        XCTAssertEqual(rowHeight, TVShowTableViewCell.cellHeight, "The rowHeight should be equal to \(TVShowTableViewCell.cellHeight) but it is \(rowHeight)")
    }
    
    func testSearchButtonPressed() throws {
        // Given the instantiated vc
        
        // With a mock viewmodel
        
        class MockViewModel: TVShowSearchViewModelProtocol {
            var title: String = ""
            
            var numberOfRows: Int = 0
            
            func requestTVShows(withSearchText searchText: String, completion: (() -> ())?) {
                wasRequestTVShowsCalled = true
            }
            
            var wasRequestTVShowsCalled = false
            
            func getShowFor(indexPath: IndexPath) -> TVShows.TVShow {
                return TVShow()
            }
        }
        
        let mockViewModel = MockViewModel()
        vc.viewModel = mockViewModel
        
        // When searchViewSearchButtonPressed is called
        vc.searchViewSearchButtonPressed(withSearchText: "", completion: nil)
        
        // Then the viewModel's requestTVShows should get called
        XCTAssertTrue(mockViewModel.wasRequestTVShowsCalled, "The viewModel's requestTVShows should get called, mockViewModel.wasRequestTVShowsCalled should be true")
    }
    
    func testUpdateView() throws {
        // Given the viewController's tableView with no cells in it
        vc.showsTableView.reloadData()
        
        // The view model containing a list of shows
        let shows: [TVShow] = [
            TVShow(id: 1, name: "Show title 1", genres: ["genre1", "genre2"]),
            TVShow(id: 2, name: "Show title 2", genres: ["genre3", "genre4"]),
            TVShow(id: 3, name: "Show title 3", genres: ["genre5", "genre6"]),
            TVShow(id: 4, name: "Show title 4", genres: ["genre7", "genre8"])
        ]
        
        class MockViewModel: TVShowSearchViewModelProtocol {
            var title: String = ""
            
            var numberOfRows: Int
            
            func requestTVShows(withSearchText searchText: String, completion: (() -> ())?) {}
            
            var shows: [TVShow]
            
            init(shows: [TVShow]) {
                self.shows = shows
                self.numberOfRows = shows.count
            }
            
            func getShowFor(indexPath: IndexPath) -> TVShows.TVShow {
                return shows[indexPath.row]
            }
        }
        
        let mockViewModel = MockViewModel(shows: shows)
        
        vc.configure(viewModel: mockViewModel)
        vc.view.layoutSubviews() // without this, the table view is not calling the cell for row at
        
        let expectation = self.expectation(description: "TVShowSearchViewControllerTests updateView expectation")
        
        // When updateView is called
        vc.updateView(completion: {
            
            // Then
            // The number of cells in the table view should be equal to the number of shows in the view model
            XCTAssertEqual(self.vc.showsTableView.numberOfRows(inSection: 0), shows.count, "The number of cells in the table view (\(self.vc.showsTableView.numberOfRows(inSection: 0))) should be equal to the number of shows in the view model (\(shows.count))")
            
            for i in 0..<4 {
                // Each cell should have the show name as it's titleLabel's text
                XCTAssertEqual((self.vc.showsTableView.cellForRow(at: IndexPath(row: i, section: 0)) as! TVShowTableViewCell).titleLabel.text, shows[i].name, "The cell \(i) should have a titleLabel with text \(String(describing: shows[i].name)) but it has \(String(describing: (self.vc.showsTableView.cellForRow(at: IndexPath(row: i, section: 0)) as! TVShowTableViewCell).titleLabel.text))")
                
                // Each cell should have 'Genres: genre1, genre2, ... as it's genresLabel's text
                let genres = shows[i].genres!
                let genresText = "Genres: \(genres[0]), \(genres[1])"
                XCTAssertEqual((self.vc.showsTableView.cellForRow(at: IndexPath(row: i, section: 0)) as! TVShowTableViewCell).genresLabel.text, genresText, "The cell \(i) should have a genresLabel with text \(genresText) but it has \(String(describing: (self.vc.showsTableView.cellForRow(at: IndexPath(row: i, section: 0)) as! TVShowTableViewCell).genresLabel.text))")
            }
            
            expectation.fulfill()
        })
        
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testCellForRowAt() {
        // Given the viewController's tableView with no cells in it
        vc.showsTableView.reloadData()
        vc.showsTableView.register(TVShowTableViewCell.self, forCellReuseIdentifier: TVShowTableViewCell.reuseIdentifier) // this is necessary to call cellForRowAt
        
        // The viewmodel with a list of shows
        let shows: [TVShow] = [
            TVShow(id: 1, name: "Show title 1", genres: ["genre1", "genre2"]),
            TVShow(id: 2, name: "Show title 2", genres: ["genre3", "genre4"]),
            TVShow(id: 3, name: "Show title 3", genres: ["genre5", "genre6"]),
            TVShow(id: 4, name: "Show title 4", genres: ["genre7", "genre8"])
        ]
        
        class MockViewModel: TVShowSearchViewModelProtocol {
            var title: String = ""
            
            var numberOfRows: Int = 0
            
            func requestTVShows(withSearchText searchText: String, completion: (() -> ())?) {}
            
            var shows: [TVShow]
            
            init(shows: [TVShow]) {
                self.shows = shows
            }
            
            func getShowFor(indexPath: IndexPath) -> TVShows.TVShow {
                return shows[indexPath.row]
            }
        }
        
        let mockViewModel = MockViewModel(shows: shows)
        
        vc.viewModel = mockViewModel
        
        // When cellForRowAt is called
        
        let showIndexForTesting = 2
        let showForTesting = shows[showIndexForTesting]
        let cell = vc.tableView(vc.showsTableView, cellForRowAt: IndexPath(row: showIndexForTesting, section: 0))
        
        // Then the cell is configured with the correct show (showForTesting)
        // The cell's title should be the show's name
        XCTAssertEqual((cell as! TVShowTableViewCell).titleLabel.text, showForTesting.name, "The cell should have a titleLabel with text \(String(describing: showForTesting.name)) but it has \(String(describing: (cell as! TVShowTableViewCell).titleLabel.text))")
        
        // The cell should have 'Genres: genre1, genre2, ... as it's genresLabel's text
        let genres = showForTesting.genres!
        let genresText = "Genres: \(genres[0]), \(genres[1])"
        XCTAssertEqual((cell as! TVShowTableViewCell).genresLabel.text, genresText, "The cell should have a genresLabel with text \(genresText) but it has \(String(describing: (cell as! TVShowTableViewCell).genresLabel.text))")
    }
    
    func testDidSelectRowAt() throws {
        // Given the viewController's tableView cells in it
        let shows: [TVShow] = [
            TVShow(id: 1, name: "Show title 1", genres: ["genre1", "genre2"]),
            TVShow(id: 2, name: "Show title 2", genres: ["genre3", "genre4"]),
            TVShow(id: 3, name: "Show title 3", genres: ["genre5", "genre6"]),
            TVShow(id: 4, name: "Show title 4", genres: ["genre7", "genre8"])
        ]
        
        class MockViewModel: TVShowSearchViewModelProtocol {
            var title: String = ""
            
            var numberOfRows: Int = 0
            
            func requestTVShows(withSearchText searchText: String, completion: (() -> ())?) {}
            
            var shows: [TVShow]
            
            init(shows: [TVShow]) {
                self.shows = shows
            }
            
            func getShowFor(indexPath: IndexPath) -> TVShows.TVShow {
                return shows[indexPath.row]
            }
        }
        
        let mockViewModel = MockViewModel(shows: shows)
        
        vc.viewModel = mockViewModel
        
        vc.showsTableView.reloadData()
        
        // When didSelectRowAt is called
        vc.tableView(vc.showsTableView, didSelectRowAt: IndexPath(row: 2, section: 0))
        
        // Then
        // After the selection, the tableView should deselect the cell
        XCTAssertNil(vc.showsTableView.indexPathForSelectedRow, "After the selection, the tableView should deselect the cell, but there's a selection (\(String(describing: vc.showsTableView.indexPathForSelectedRow)))")
    }

}
