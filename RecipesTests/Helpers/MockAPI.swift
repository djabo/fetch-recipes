//
//  MockAPI.swift
//  Recipes
//

import Foundation
@testable import Recipes

class MockAPI: URLProtocol {
    static var result: Result<Data, Error> = .failure(NSError(domain: "test", code: 0))

    override class func canInit(with task: URLSessionTask) -> Bool {
        true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }

    override func startLoading() {
        client?.urlProtocol(self, didReceive: HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!,
                            cacheStoragePolicy: .notAllowed)

        switch Self.result {
        case .success(let data):
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        case .failure(let error):
            client?.urlProtocol(self, didFailWithError: error)
        }
    }

    override func stopLoading() {}
}
