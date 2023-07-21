//
//  AppDelegate.swift
//  TVShows
//
//  Created by José Damaren on 23/06/23.
//

import UIKit

@main
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
        
        return true
    }
}

// MARK: - TVShowSearchViewControllerDelegate

extension AppDelegate: TVShowSearchViewControllerDelegate {
    func selectedShow(show: TVShow, withAnimation: Bool) {
        let showDetailsViewController = ShowDetailsViewController()
        showDetailsViewController.delegate = self
        showDetailsViewController.configure(show: show)
        navigationController.pushViewController(showDetailsViewController, animated: withAnimation)
    }
}

// MARK: - ShowDetailsViewControllerDelegate

extension AppDelegate: ShowDetailsViewControllerDelegate {
    func backButtonPressed(inViewcontroller: ShowDetailsViewController, withAnimation: Bool) {
        navigationController.popViewController(animated: withAnimation)
    }
    
    func selectedEpisode(episode: Episode, withShowTitle showTitle: String, withAnimation: Bool) {
        let episodeInfoViewController = EpisodeInformationViewController()
        episodeInfoViewController.delegate = self
        episodeInfoViewController.configure(forEpisode: episode, andShowTitle: showTitle)
        navigationController.pushViewController(episodeInfoViewController, animated: withAnimation)
    }
}

// MARK: - EpisodeInformationViewControllerDelegate

extension AppDelegate: EpisodeInformationViewControllerDelegate {
    func backButtonPressed(inViewcontroller: EpisodeInformationViewController, withAnimation: Bool) {
        navigationController.popViewController(animated: withAnimation)
    }
}
