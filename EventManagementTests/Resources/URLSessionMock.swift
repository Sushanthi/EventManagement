//
//  URLSessionMock.swift
//  EventManagementTests
//
//  Created by ur268042 on 6/2/21.
//

import Foundation


class URLSessionMock: URLSession {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    // data and error can be set to provide data or an error
    var data: Data?
    var error: Error?
    override init() {
        
    }
    override func dataTask(with url: URL, completionHandler: @escaping CompletionHandler) -> URLSessionDataTask {
        let data = self.data
        let error = self.error
        return URLSessionDataTaskMock {
            completionHandler(data, nil, error)
        }
    }
}
