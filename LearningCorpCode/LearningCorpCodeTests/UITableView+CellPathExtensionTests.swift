//
//  UITableView+CellPathExtensionTests.swift
//  LearningCorpCodeTests
//
//  Created by Neelam Verma on 5/19/19.
//  Copyright © 2019 Neelam Verma. All rights reserved.
//

import XCTest
@testable import LearningCorpCode

class UITableView_CellPathExtensionTests: XCTestCase {
    
    var subject: MockTableView!
    
    override func setUp() {
        subject = MockTableView()
    }
    
    override func tearDown() {
        super.tearDown()
        subject = nil
    }
    
    func testIsLastVisibleCellForFalse() {
        XCTAssertFalse(subject.isLastVisibleCell(at: IndexPath(row: 0, section: 0)))
    }
    
    func testIsLastVisibleCellForTrue() {
        XCTAssertTrue(subject.isLastVisibleCell(at: IndexPath(row: 2, section: 0)))
    }
}

class MockTableView: UITableView {
    override var indexPathsForVisibleRows: [IndexPath]? {
        return [IndexPath(row: 0, section: 0), IndexPath(row: 1, section: 0), IndexPath(row: 2, section: 0)]
    }
}
