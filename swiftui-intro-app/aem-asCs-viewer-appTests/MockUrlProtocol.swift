//
//  MockUrlProtocol.swift
//  AEM-asCs-Author-ViewerTests
//
//  Created by Jorge Rodriguez on 01/07/2022.
//

import Foundation

class MockURLProtocol: URLProtocol {
    
    static var data = [URL?: Data]()
    static var httpResponse = [URL?: HTTPURLResponse]()

    override class func canInit(with request: URLRequest) -> Bool {
      true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
       request
    }
    
  override func startLoading() {
      if let url = request.url {
        if let data = MockURLProtocol.data[url] {
            if let httpResponse = MockURLProtocol.httpResponse[url] {
                client?.urlProtocol(self, didLoad: data)
                client?.urlProtocol(self, didReceive: httpResponse, cacheStoragePolicy: .notAllowed)
            }
        }
      }
      client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {}
}
