//
//  NetworkErrorModel.swift
//  TVShows
//
//  Created by José Damaren on 04/07/23.
//

import Foundation

enum NetworkError: Error, Equatable {
    case responseError(String?)
    case queryAllowedStringError(String?)
    case urlCreationError(String?)
    case JSONDecodeError
}
