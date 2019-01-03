//
//  CalculatorViewModel.swift
//  Calculator
//
//  Created by Diego Fernando Cuesta Arevalo on 1/2/19.
//  Copyright © 2019 Diego Fernando Cuesta Arevalo. All rights reserved.
//

import Foundation
import SwiftTryCatch

protocol CalculatorProtocol : class {
    func updateOperationLabel( newValue: String )
    func updateOperationFailed( newValue: String )
    func resultFailed( newValue: String )
}

enum NumberValue: Int, CaseIterable {
    case one   = 1
    case two   = 2
    case tree  = 3
    case four  = 4
    case five  = 5
    case six   = 6
    case seven = 7
    case eight = 8
    case nine  = 9
    case zero  = 0
}

enum operationValue : String, CaseIterable{
    case sum      = "+"
    case rest     = "-"
    case multiply = "*"
    case division = "/"
    
    static func value(_ value: operationValue) -> String {
        return value.rawValue
    }
}

enum specialCharacters : String, CaseIterable {
    case leftParenthes  = "("
    case rightParenthes = ")"
    case dot            = "."
    
    static func value(_ value: specialCharacters) -> String {
        return value.rawValue
    }
}

class CalculatorViewModel {
    
    var operationInDisplay: String = ""
    var isOperationKeyboard: Bool = false
    weak var delegate : CalculatorProtocol?
    
    let digits = CharacterSet.decimalDigits
    
    init(delegate: CalculatorProtocol ) { self.delegate = delegate }
    
    func getNumberToTag(tag: Int) -> String? {
        for number in NumberValue.allCases {
            if number.rawValue == tag {
                if let beforeChar = operationInDisplay.unicodeScalars.last {
                    if String(beforeChar) == specialCharacters.value(.rightParenthes){
                        return operationValue.value(.multiply) + String(number.rawValue)
                    }
                }
                return String(number.rawValue)
            }
        }
        return nil
    }

    func getOperationToTag(tag: Int) -> String? {
        switch tag {
        case 1:
            return operationValue.value(.sum)
        case 2:
            return operationValue.value(.rest)
        case 3:
            return operationValue.value(.multiply)
        case 4:
            return operationValue.value(.division)
        default:
            return nil
        }
    }
    
    func setOperationToKeyboard(newValue: String){
        operationInDisplay = newValue
        validateOperation(returnResult: false)
    }
    
    func getSpecialCharacterTag(tag: Int) -> String? {
        let beforeValue: String = operationValue.value(.multiply)
        var value: String = ""
        
        switch tag {
        case 1:
            if let beforeChar = operationInDisplay.unicodeScalars.last {
                if digits.contains(beforeChar){ value = specialCharacters.value(.leftParenthes)
                break }
            }
            validateOperation( )
            return specialCharacters.value(.leftParenthes)
        case 2:
            validateOperation( )
            return specialCharacters.value(.rightParenthes)
        case 3:
            return specialCharacters.value(.dot)
        default:
            return beforeValue
        }
        return beforeValue + value
    }
    
    func concatenateValue(newValue: String ){
        operationInDisplay+=newValue
        validateOperation()
    }
    
    func clearOperation(){
        operationInDisplay = ""
        delegate?.updateOperationLabel(newValue: operationInDisplay)
    }
    
    func getResult( ) {
        if isOperationKeyboard {
            validateOperationKeyboard( )
        }
        validateOperation(returnResult: true)
    }
    
    func setIsOperationKeyboard(isOperationKeyboard: Bool){
        self.isOperationKeyboard = isOperationKeyboard
    }
    
    private func validateOperationKeyboard(){
        var resultstring: String = ""
        var toIndex = 0
        let fromIndex = operationInDisplay.count
        
        for char in operationInDisplay {
            if char == "(" && toIndex != 0 {
                resultstring.append("*")
            }
            resultstring.append(char)
            if char == ")" && toIndex < fromIndex {
                resultstring.append("*")
            }
            toIndex+=1
        }
    
       let clearresultstring = resultstring.replacingOccurrences(of: "**", with: "*")
        operationInDisplay = clearresultstring
    }
    
    private func validateOperation( returnResult: Bool = false){
        SwiftTryCatch.try ({
            let expression = NSExpression(format: self.operationInDisplay)
            if let result = expression.expressionValue(with: nil, context: nil) as? NSNumber {
                if returnResult {
                    self.operationInDisplay = String(result.stringValue)
                }
                self.delegate?.updateOperationLabel(newValue: self.operationInDisplay)
            }
        }, catch: { (error) in
            if returnResult {
                self.delegate?.resultFailed(newValue: self.operationInDisplay)
                return
            }
            self.delegate?.updateOperationFailed(newValue: self.operationInDisplay )
        }, finallyBlock: { })
    }
}
