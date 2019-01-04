//
//  CalculatorTests.swift
//  CalculatorTests
//
//  Created by Diego Fernando Cuesta Arevalo on 1/2/19.
//  Copyright © 2019 Diego Fernando Cuesta Arevalo. All rights reserved.
//

import XCTest
@testable import Calculator

class CalculatorTests: XCTestCase , CalculatorProtocol {
    
    override func setUp() {
        validateMathOperationOk()
        validateMathMultipleOk()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func validateMathOperationOk() {
        let operation = "5+10*(6)"
        let response  = "65"
        let viewmodel = CalculatorViewModel(delegate: self)
        let numberStr = viewmodel.runOperation(operation: operation, returnResult: true)
        XCTAssertEqual(numberStr, response ,"Hubo un error al ejecutar el test.")
    }
    
    func validateMathMultipleOk(){
        let operation = "5+10*(6)"
        let response  = "Comics"
        let viewmodel = CalculatorViewModel(delegate: self)
        let numberStr = viewmodel.runOperation(operation: operation, returnResult: true)
        let category = viewmodel.obtainMultiple(numberStr: numberStr!)
        XCTAssertEqual(category, response ,"Hubo un error al ejecutar el test.")

    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
