//
//  NYCSchollViewModelTests.swift
//  LearningCorpCodeTests
//
//  Created by Neelam Verma on 5/18/19.
//  Copyright © 2019 Neelam Verma. All rights reserved.
//

import XCTest
@testable import LearningCorpCode

class NYCSchoolViewModelTests: XCTestCase {

    var subject: NYCSchoolViewModel!
    var mockTableView: MockTableView!
    
    override func setUp() {
        subject = NYCSchoolViewModel()
        mockTableView = MockTableView()
    }
    
    override func tearDown() {
        super.tearDown()
        subject = nil
    }
    
    func testGetNumberOfSchools() {
        subject.nycSchools = [NYCSchool(school_name: "School1", school_email: "abc.email", phone_number: "2323", website: "abc.com", latitude: "34.4", longitude: "45.0"), NYCSchool(school_name: "School2", school_email: "abc1.email", phone_number: "2323", website: "abc.com", latitude: "34.4", longitude: "45.0"), NYCSchool(school_name: "School3", school_email: "abc2.email", phone_number: "2323", website: "abc.com", latitude: "34.4", longitude: "45.0")]
        XCTAssertEqual(subject.getNumberOfSchools(in: 0), 3)
    }
    
    func testCellForRowIn() {
        subject.nycSchools = [NYCSchool(school_name: "School1", school_email: "abc.email", phone_number: "2323", website: "abc.com", latitude: "34.4", longitude: "45.0"), NYCSchool(school_name: "School2", school_email: "abc1.email", phone_number: "2323", website: "abc.com", latitude: "34.4", longitude: "45.0"), NYCSchool(school_name: "School3", school_email: "abc2.email", phone_number: "2323", website: "abc.com", latitude: "34.4", longitude: "45.0")]
        let cell = subject.cellForRowIn(mockTableView, atIndexPath: IndexPath(row: 0, section: 0))
        XCTAssertTrue(cell is NYCSchoolCell)
        
    }
    
}
