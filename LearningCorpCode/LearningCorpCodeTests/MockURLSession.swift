//
//  MockURLSession.swift
//  LearningCorpCodeTests
//
//  Created by Neelam Verma on 5/18/19.
//  Copyright © 2019 Neelam Verma. All rights reserved.
//

import XCTest

class MockURLSession: URLSession {
    typealias completionHandler = (Data?, URLResponse?,Error?) -> Void
    var nextDataTask = MockURLSessionDataTask()
    var nextData: Data?
    var nextError: Error?
    private (set) var lastURL: URL?
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping completionHandler) -> URLSessionDataTask {
        lastURL = request.url
        
        completionHandler(nextData, nil, nextError)
        return nextDataTask
    }
}

class MockURLSessionDataTask: URLSessionDataTask {
    private (set) var resumeWasCalled = false
    
    override func resume() {
        resumeWasCalled = true
    }
}
