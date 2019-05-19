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
    
    //MARK:- session task tests
    func test_get_request_with_URL() {
        var urlComponents = URLComponents(string: Constants.NYC_SCHOOL_URL)!
        urlComponents.query = "$limit=\(subject.limit)&$offset=\(subject.pageOffset)"
        let url: URL? = urlComponents.url
        subject.fetchListOfNYCSchools(completion: { ( list , isMore) in }) { error in }
        XCTAssert(mockSession.lastURL == url)
    }
    
    func test_URL_shouldhave_limit_and_offset_query_withdefault() {
        subject.fetchListOfNYCSchools(completion: { ( list , isMore) in }) { error in }
        XCTAssert(mockSession.lastURL?.query == "$limit=10&$offset=0")
    }
    
    func test_URL_shouldhave_limit_and_offset_query_withSPecific_page() {
        
        subject.limit = 50
        subject.pageOffset = 15
        subject.fetchListOfNYCSchools(completion: { ( list , isMore) in }) { error in }
        XCTAssert(mockSession.lastURL?.query == "$limit=50&$offset=15")
    }
    
    func test_get_resume_called() {
        let dataTask = MockURLSessionDataTask()
        mockSession.nextDataTask = dataTask
        subject.fetchListOfNYCSchools(completion: { ( list , isMore) in }) { error in }
        XCTAssert(dataTask.resumeWasCalled)
    }
    
    //MARK:- func fetchSATScoresOfNYCSchool(:) tests
    func test_should_return_success() {
        let expectedData = "[{\"dbn\":\"01M292\",\"num_of_sat_test_takers\":\"29\",\"sat_critical_reading_avg_score\":\"355\",\"sat_math_avg_score\":\"404\",\"sat_writing_avg_score\":\"363\",\"school_name\":\"HENRY STREET SCHOOL FOR INTERNATIONAL STUDIES\"}\n,{\"dbn\":\"01M448\",\"num_of_sat_test_takers\":\"91\",\"sat_critical_reading_avg_score\":\"383\",\"sat_math_avg_score\":\"423\",\"sat_writing_avg_score\":\"366\",\"school_name\":\"UNIVERSITY NEIGHBORHOOD HIGH SCHOOL\"}\n]".data(using: .utf8)
        mockSession.nextData = expectedData
        var error: String?
        subject.fetchListOfNYCSchools(completion: { ( list , isMore) in }) { errorMessage in
            error = errorMessage
        }
        XCTAssertNil(error)
    }
    
    func test_should_return_array_of_school() {
        let expectedData = "[{\"dbn\":\"01M292\",\"num_of_sat_test_takers\":\"29\",\"sat_critical_reading_avg_score\":\"355\",\"sat_math_avg_score\":\"404\",\"sat_writing_avg_score\":\"363\",\"school_name\":\"HENRY STREET SCHOOL FOR INTERNATIONAL STUDIES\"}\n,{\"dbn\":\"01M448\",\"num_of_sat_test_takers\":\"91\",\"sat_critical_reading_avg_score\":\"383\",\"sat_math_avg_score\":\"423\",\"sat_writing_avg_score\":\"366\",\"school_name\":\"UNIVERSITY NEIGHBORHOOD HIGH SCHOOL\"}\n]".data(using: .utf8)
        mockSession.nextData = expectedData
        
        subject.fetchListOfNYCSchools(completion: { ( list , isMore) in
            XCTAssertTrue(list.count > 0)
            XCTAssertTrue(list.count == 2)
        }) { error in }
        
    }
    
    
    func test_should_show_fail_if_invalid_url() {
        
        subject.nycSchoolURL = "&%$$$"
        var error: String?
        subject.fetchListOfNYCSchools(completion: { ( _ , _) in}) { errorMessage in
            error = errorMessage
        }
        XCTAssertNotNil(error)
        XCTAssertEqual(error, Constants.UNEXPECTED_ERROR)
    }
    
    func test_should_show_fail_if_Data_is_nil() {
        mockSession.nextData = nil
        var error: String?
        subject.fetchListOfNYCSchools(completion: { ( _ , _) in
        }) { errorMessage in
            error = errorMessage
        }
        XCTAssertNotNil(error)
    }
    
    func test_should_show_fail_if_Data_is_NOT_nil_NOT_able_to_DECODE() {
        mockSession.nextData = "[{\"dbn123\":\"01M292\",\"num_of_sat_test_takers1\":\"29\",\"sat_critical_reading_avg_score\":\"355\",\"sat_math_avg_score\":\"4}]".data(using: .utf8)
        var error: String?
        subject.fetchListOfNYCSchools(completion: { ( _ , _) in
        }) { errorMessage in
            error = errorMessage
        }
        XCTAssertNotNil(error)
    }
    
    //MARK:- Pagination Tests
    
    func test_should_disbale_isMore_when_all_data_get_fetched() {
        let expectedData = "[{\"dbn\":\"01M292\",\"num_of_sat_test_takers\":\"29\",\"sat_critical_reading_avg_score\":\"355\",\"sat_math_avg_score\":\"404\",\"sat_writing_avg_score\":\"363\",\"school_name\":\"HENRY STREET SCHOOL FOR INTERNATIONAL STUDIES\"}\n,{\"dbn\":\"01M448\",\"num_of_sat_test_takers\":\"91\",\"sat_critical_reading_avg_score\":\"383\",\"sat_math_avg_score\":\"423\",\"sat_writing_avg_score\":\"366\",\"school_name\":\"UNIVERSITY NEIGHBORHOOD HIGH SCHOOL\"}\n]".data(using: .utf8)
        mockSession.nextData = expectedData
        var isMoreData: Bool?
        subject.fetchListOfNYCSchools(completion: { ( _ , isMore) in
            isMoreData = isMore
        }) { errorMessage in }
        
        XCTAssertTrue(isMoreData == false)
    }
    
    func test_should_enable_isMore_when_all_data_get_fetched() {
        let expectedData = "[{\"dbn\":\"01M292\",\"num_of_sat_test_takers\":\"29\",\"sat_critical_reading_avg_score\":\"355\",\"sat_math_avg_score\":\"404\",\"sat_writing_avg_score\":\"363\",\"school_name\":\"HENRY STREET SCHOOL FOR INTERNATIONAL STUDIES\"}\n,{\"dbn\":\"01M448\",\"num_of_sat_test_takers\":\"91\",\"sat_critical_reading_avg_score\":\"383\",\"sat_math_avg_score\":\"423\",\"sat_writing_avg_score\":\"366\",\"school_name\":\"UNIVERSITY NEIGHBORHOOD HIGH SCHOOL\"},{\"dbn\":\"01M449\",\"num_of_sat_test_takers\":\"91\",\"sat_critical_reading_avg_score\":\"388\",\"sat_math_avg_score\":\"423\",\"sat_writing_avg_score\":\"366\",\"school_name\":\"UNIVERSITY NEIGHBORHOOD HIGH SCHOOL\"}\n]".data(using: .utf8)
        mockSession.nextData = expectedData
        mockSession.nextError = nil
        
        subject.limit = 2
        var isMoreData: Bool?
        subject.fetchListOfNYCSchools(completion: { ( _ , isMore) in
            isMoreData = isMore
        }) { errorMessage in }
        
        XCTAssertTrue(isMoreData == true)
    }
}



