//
//  URLSessionDataTaskMock.swift
//  EventManagementTests
//
//  Created by ur268042 on 6/2/21.
//

import Foundation

class URLSessionDataTaskMock: URLSessionDataTask {
    private let closure: () -> Void
    init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    override func resume() {
        closure()
    }
}
