//
//  MockUrlProtocol.swift
//  PhotoAppTests
//
//  Created by Brian Ortiz on 2023-08-12.
//  Copyright © 2023 Sergey Kargopolov. All rights reserved.
//

import Foundation

class MockUrlProtocol: URLProtocol {
    
    static var stubResponseData: Data?
    static var error: Error?
    
    override class func canInit(with request: URLRequest) -> Bool {
        true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
    
    override func startLoading() {
        
        if let signUpError = MockUrlProtocol.error {
            client?.urlProtocol(self, didFailWithError: signUpError)
        } else {
            client?.urlProtocol(self, didLoad: MockUrlProtocol.stubResponseData ?? Data())
        }
        
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {}
    
}
