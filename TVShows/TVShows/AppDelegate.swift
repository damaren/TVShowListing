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
    lazy var listViewController = ListViewController()
    lazy var showDetailsViewController = ShowDetailsViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        window?.rootViewController = navigationController
        navigationController.setViewControllers([listViewController], animated: false)
        listViewController.delegate = self
        
        return true
    }
}

// MARK: - ListViewControllerDelegate

extension AppDelegate: ListViewControllerDelegate {
    func selectedShow(show: TVShow) {
        showDetailsViewController.delegate = self
        showDetailsViewController.configure(show: show)
        navigationController.pushViewController(showDetailsViewController, animated: true)
    }
}

// MARK: - ShowDetailsViewControllerDelegate

extension AppDelegate: ShowDetailsViewControllerDelegate {
    func backButtonPressed(inViewcontroller: ShowDetailsViewController) {
        navigationController.popViewController(animated: true)
    }
    
    func selectedEpisode(episode: Episode, withShowTitle showTitle: String) {
        let episodeInfoViewController = EpisodeInformationViewController()
        episodeInfoViewController.delegate = self
        episodeInfoViewController.configure(forEpisode: episode, andShowTitle: showTitle)
        navigationController.pushViewController(episodeInfoViewController, animated: true)
    }
}

// MARK: - EpisodeInformationViewControllerDelegate

extension AppDelegate: EpisodeInformationViewControllerDelegate {
    func backButtonPressed(inViewcontroller: EpisodeInformationViewController) {
        navigationController.popViewController(animated: true)
    }
}
