//
//  AppDelegate.swift
//  TVShows
//
//  Created by José Damaren on 23/06/23.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let navigationController = UINavigationController()
    lazy var tvShowSearchViewController = TVShowSearchViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        window?.rootViewController = navigationController
        navigationController.setViewControllers([tvShowSearchViewController], animated: false)
        tvShowSearchViewController.delegate = self
        let tvShowSearchViewModel = TVShowSearchViewModel(showSearchView: tvShowSearchViewController, provider: TVMazeProvider.shared)
        let searchView = SearchView()
        tvShowSearchViewController.configure(viewModel: tvShowSearchViewModel, searchView: searchView)
        searchView.delegate = tvShowSearchViewController
        
        return true
    }
}

// MARK: - TVShowSearchViewControllerDelegate

extension AppDelegate: TVShowSearchViewControllerDelegate {
    func selectedShow(show: TVShow, withAnimation: Bool) {
        let showDetailsViewController = ShowDetailsViewController()
        let viewModel = ShowDetailsViewModel(view: showDetailsViewController)
        let summaryView = ShowDetailsSummaryView()
        summaryView.configure(forShow: show, andDelegate: showDetailsViewController)
        showDetailsViewController.configure(show: show, viewModel: viewModel, summaryView: summaryView, delegate: self)
        navigationController.pushViewController(showDetailsViewController, animated: withAnimation)
    }
}

// MARK: - ShowDetailsViewControllerDelegate

extension AppDelegate: ShowDetailsViewControllerDelegate {
    func seeMoreButtonPressed(inViewcontroller: ShowDetailsViewController, forShowSummary summary: String?) {
        let showDescriptionVC = ShowDescriptionViewController()
        guard let summary = summary else { return }
        showDescriptionVC.configure(description: summary)
        inViewcontroller.present(showDescriptionVC, animated: true)
    }
    
    func backButtonPressed(inViewcontroller: ShowDetailsViewController, withAnimation: Bool) {
        navigationController.popViewController(animated: withAnimation)
    }
    
    func selectedEpisode(episode: Episode, withShowTitle showTitle: String, withAnimation: Bool) {
        let episodeInfoViewController = EpisodeInformationViewController()
        let viewModel = EpisodeInformationViewModel()
        viewModel.configure(view: episodeInfoViewController, forEpisode: episode, andShowTitle: showTitle, withProvider: TVMazeProvider.shared)
        episodeInfoViewController.configure(delegate: self, viewModel: viewModel)
        navigationController.pushViewController(episodeInfoViewController, animated: withAnimation)
    }
}

// MARK: - EpisodeInformationViewControllerDelegate

extension AppDelegate: EpisodeInformationViewControllerDelegate {
    func backButtonPressed(inViewcontroller: EpisodeInformationViewController, withAnimation: Bool) {
        navigationController.popViewController(animated: withAnimation)
    }
}
