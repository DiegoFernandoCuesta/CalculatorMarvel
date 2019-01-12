//
//  CalculatorUITests.swift
//  CalculatorUITests
//
//  Created by Diego Fernando Cuesta Arevalo on 1/2/19.
//  Copyright © 2019 Diego Fernando Cuesta Arevalo. All rights reserved.
//

import XCTest
@testable import Calculator

class CalculatorUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
    }

    override func tearDown() {}

    func testTableInteraction() {
        app.launch()
//        let articleTableView = app.tables["testTable"]
//        XCTAssertTrue(articleTableView.exists, "The tableview exists")
//        let tableCells = articleTableView.cells
//        if tableCells.count > 0 {
//            let count: Int = (tableCells.count - 1)
//            let promise = expectation(description: "Wait for table cells")
//            for i in stride(from: 0, to: count , by: 1) {
//                // Grab the first cell and verify that it exists and tap it
//                let tableCell = tableCells.element(boundBy: i)
//                XCTAssertTrue(tableCell.exists, "The \(i) cell is in place on the table")
//                // Does this actually take us to the next screen
//                tableCell.tap()
//                
//                if i == (count - 1) {
//                    promise.fulfill()
//                }
//                app.navigationBars.buttons.element(boundBy: 0).tap()
//            }
//            waitForExpectations(timeout: 20, handler: nil)
//            XCTAssertTrue(true, "Finished validating the table cells")
//        } else {
//            XCTAssert(false, "Was not able to find any table cells")
//        }
    }

}
