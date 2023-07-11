//
//  NetworkErrorModel.swift
//  TVShows
//
//  Created by José Damaren on 04/07/23.
//

import Foundation

enum NetworkError: Error, Equatable {
    case responseError(description: String)
    case queryAllowedStringError(description: String)
    case urlCreationError(description: String)
    case JSONDecodeError
    
    var description: String {
        switch self {
        case .responseError(let description):
            return description
        case .queryAllowedStringError(let description):
            return description
        case .urlCreationError(let description):
            return description
        case .JSONDecodeError:
            return ""
        }
    }
    
    var type: NetworkErrorType {
        switch self {
        case .responseError:
            return .responseError
        case .queryAllowedStringError:
            return .queryAllowedStringError
        case .urlCreationError:
            return .urlCreationError
        case .JSONDecodeError:
            return .JSONDecodeError
        }
    }
    
    enum NetworkErrorType {
        case responseError
        case queryAllowedStringError
        case urlCreationError
        case JSONDecodeError
    }
}
