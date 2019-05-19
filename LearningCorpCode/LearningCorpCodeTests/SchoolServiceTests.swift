//
//  SchoolServiceTests.swift
//  LearningCorpCodeTests
//
//  Created by Neelam Verma on 5/18/19.
//  Copyright © 2019 Neelam Verma. All rights reserved.
//

import XCTest
@testable import LearningCorpCode

class SchoolServiceTests: XCTestCase {

    var subject: SchoolService!
    var mockSession: MockURLSession!
    
    override func setUp() {
        subject = SchoolService()
        mockSession = MockURLSession()
        subject.session = mockSession
    }
    
    override func tearDown() {
        subject = nil
        mockSession = nil
        super.tearDown()
    }
}

//MARK:- Mock Session
// mock session to mock data and error

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

// mock urlSessionDataTask
class MockURLSessionDataTask: URLSessionDataTask {
    private (set) var resumeWasCalled = false
    
    override func resume() {
        resumeWasCalled = true
    }
}

