//
//  TVShowSearchCoordinator.swift
//  TVShows
//
//  Created by José Damaren on 04/10/23.
//

import Foundation
import UIKit

class TVShowSearchCoordinator {
    let navigationController = UINavigationController()
    lazy var tvShowSearchViewController = TVShowSearchViewController()
    var provider: Provider = TVMazeProvider()
    
    init(provider: Provider = TVMazeProvider()) {
        self.provider = provider
        navigationController.setViewControllers([tvShowSearchViewController], animated: false)
        tvShowSearchViewController.delegate = self
        let tvShowSearchViewModel = TVShowSearchViewModel(showSearchView: tvShowSearchViewController, provider: provider)
        let searchView = SearchView()
        tvShowSearchViewController.configure(viewModel: tvShowSearchViewModel, searchView: searchView)
        searchView.delegate = tvShowSearchViewController
    }
}

// MARK: - TVShowSearchViewControllerDelegate

extension TVShowSearchCoordinator: TVShowSearchViewControllerDelegate {
    func selectedShow(show: TVShow, withAnimation: Bool) {
        let showDetailsViewController = ShowDetailsViewController()
        let viewModel = ShowDetailsViewModel(view: showDetailsViewController)
        let summaryView = ShowDetailsSummaryView()
        let summaryViewModel = ShowDetailsSummaryViewModel()
        summaryViewModel.view = summaryView
        summaryView.viewModel = summaryViewModel
        summaryView.configure(forShow: show, andDelegate: showDetailsViewController)
        showDetailsViewController.configure(show: show, viewModel: viewModel, summaryView: summaryView, delegate: self)
        navigationController.pushViewController(showDetailsViewController, animated: withAnimation)
    }
}

// MARK: - ShowDetailsViewControllerDelegate

extension TVShowSearchCoordinator: ShowDetailsViewControllerDelegate {
    func seeMoreButtonPressed(in viewController: ShowDetailsViewController, forShowSummary summary: String?) {
        let showDescriptionVC = ShowDescriptionViewController()
        guard let summary = summary else { return }
        showDescriptionVC.configure(description: summary)
        viewController.present(showDescriptionVC, animated: true)
    }
    
    func backButtonPressed(in viewController: ShowDetailsViewController, withAnimation: Bool) {
        navigationController.popViewController(animated: withAnimation)
    }
    
    func selectedEpisode(episode: Episode, withShowTitle showTitle: String, withAnimation: Bool) {
        let episodeInfoViewController = EpisodeInformationViewController()
        let viewModel = EpisodeInformationViewModel(view: episodeInfoViewController, forEpisode: episode, andShowTitle: showTitle, withProvider: provider)
        episodeInfoViewController.configure(delegate: self, viewModel: viewModel)
        navigationController.pushViewController(episodeInfoViewController, animated: withAnimation)
    }
}

// MARK: - EpisodeInformationViewControllerDelegate

extension TVShowSearchCoordinator: EpisodeInformationViewControllerDelegate {
    func backButtonPressed(inViewcontroller: EpisodeInformationViewController, withAnimation: Bool) {
        navigationController.popViewController(animated: withAnimation)
    }
}

