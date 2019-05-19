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
    var schoolListViewController: NYCSchoolViewController!
    
    override func setUp() {
        subject = NYCSchoolViewModel()
        mockTableView = MockTableView()
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(identifier: "neelamverma.LearningCorpCode"))
        schoolListViewController = storyboard.instantiateViewController(withIdentifier: "schoolListVC") as? NYCSchoolViewController
        let _ = schoolListViewController.view
    }
    
    override func tearDown() {
        super.tearDown()
        subject = nil
    }
    
    func testGetNumberOfSchools() {
        subject.nycSchools = nycSchoolList()
        XCTAssertEqual(subject.getNumberOfSchools(in: 0), 3)
    }
    
    func testReturnCellForRowInToBeNYCSchoolCell() {
        subject.nycSchools = nycSchoolList()
        let cell = subject.cellForRowIn(schoolListViewController.nycSchoolsTableView, atIndexPath: IndexPath(row: 0, section: 0))
        XCTAssertTrue(cell is NYCSchoolCell)
    }
    
    func testReturnCellForProperContent() {
        subject.nycSchools = nycSchoolList()
        let cell = subject.cellForRowIn(schoolListViewController.nycSchoolsTableView, atIndexPath: IndexPath(row: 0, section: 0)) as! NYCSchoolCell
        XCTAssertEqual(cell.schoolEmailLabel?.text, "abc.email")
        XCTAssertEqual(cell.schoolNameLabel?.text, "School1")
        XCTAssertEqual(cell.schoolPhoneNumber?.text, "2323")
    }
    
    func testCellForRowInForNavigateButton() {
        subject.nycSchools = nycSchoolList()
        let cell = subject.cellForRowIn(schoolListViewController.nycSchoolsTableView, atIndexPath: IndexPath(row: 0, section: 0)) as! NYCSchoolCell
        XCTAssertEqual(cell.navigateToMap.tag, 0)
    }
    
    func testGetSchoolList() {
        subject.nycSchools = nycSchoolList()
        subject.schoolService.limit = 20
        subject.schoolService.pageOffset = 3
        let session = MockURLSession()
        subject.schoolService.session = session
        // Data for 2 schools
        let expectedData = "[{\"dbn\":\"01M292\",\"num_of_sat_test_takers\":\"29\",\"sat_critical_reading_avg_score\":\"355\",\"sat_math_avg_score\":\"404\",\"sat_writing_avg_score\":\"363\",\"school_name\":\"HENRY STREET SCHOOL FOR INTERNATIONAL STUDIES\"}\n,{\"dbn\":\"01M448\",\"num_of_sat_test_takers\":\"91\",\"sat_critical_reading_avg_score\":\"383\",\"sat_math_avg_score\":\"423\",\"sat_writing_avg_score\":\"366\",\"school_name\":\"UNIVERSITY NEIGHBORHOOD HIGH SCHOOL\"}\n]".data(using: .utf8)
        session.nextData = expectedData
        subject.getSchoolList(completion: ({})) { (_) in }
        XCTAssertEqual(subject.nycSchools.count, 5)
    }
    
    func nycSchoolList() -> [NYCSchool] {
        return [NYCSchool(school_name: "School1", school_email: "abc.email", phone_number: "2323", website: "abc.com", latitude: "34.4", longitude: "45.0"), NYCSchool(school_name: "School2", school_email: "abc1.email", phone_number: "2322", website: "abc.com", latitude: "34.4", longitude: "45.0"), NYCSchool(school_name: "School3", school_email: "abc2.email", phone_number: "2323", website: "abc.com", latitude: "34.4", longitude: "45.0")]
    }
    
}
