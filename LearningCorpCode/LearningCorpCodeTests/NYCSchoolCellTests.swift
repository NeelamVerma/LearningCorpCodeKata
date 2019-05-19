//
//  NYCSchoolCellTests.swift
//  LearningCorpCodeTests
//
//  Created by Neelam Verma on 5/19/19.
//  Copyright © 2019 Neelam Verma. All rights reserved.
//

import XCTest
@testable import LearningCorpCode

class NYCSchoolCellTests: XCTestCase {

    var subject: NYCSchoolCell!
    
    override func setUp() {
        subject = NYCSchoolCell()
        subject.awakeFromNib()
    }
    
    override func tearDown() {
        super.tearDown()
        subject = nil
    }

    func testContent() {
       let school = NYCSchool(school_name: "School1", school_email: "abc.email", phone_number: "2323", website: "abc.com", latitude: "34.4", longitude: "45.0")
        let textView = UITextView()
        subject.schoolPhoneNumber = textView
        let nameLabel = UILabel()
        subject.schoolNameLabel = nameLabel
        let emailLabel = UILabel()
        subject.schoolEmailLabel = emailLabel
        subject.setContent(withSchool: school)
        XCTAssertEqual(subject.schoolPhoneNumber.text, "2323")
        XCTAssertEqual(subject.schoolNameLabel.text, "School1")
        XCTAssertEqual(subject.schoolEmailLabel.text, "abc.email")

    }
}
