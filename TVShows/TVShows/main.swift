//
//  main.swift
//  TVShows
//
//  Created by José Damaren on 01/09/23.
//

import UIKit
let appDelegateClass: AnyClass =
    NSClassFromString("TestAppDelegate") ?? AppDelegate.self
UIApplicationMain(
    CommandLine.argc,
    CommandLine.unsafeArgv,
    nil,
    NSStringFromClass(appDelegateClass)
)
