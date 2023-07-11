//
//  MockURLProtocol.swift
//  TVShows
//
//  Created by José Damaren on 06/07/23.
//

import Foundation

// class for testing the functions that perform the requests (dependency injection)
class MockURLProtocol: URLProtocol {
    
    // MARK: - PROPERTIES
    
    static var stubResponseData: Data?
    static var error: NetworkError?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        if let error = MockURLProtocol.error {
            self.client?.urlProtocol(self, didFailWithError: error)
        } else {
            self.client?.urlProtocol(self, didLoad: MockURLProtocol.stubResponseData ?? Data())
        }
        
        self.client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() { }
}
