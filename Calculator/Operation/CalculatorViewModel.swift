//
//  CalculatorViewModel.swift
//  Calculator
//
//  Created by Diego Fernando Cuesta Arevalo on 1/2/19.
//  Copyright © 2019 Diego Fernando Cuesta Arevalo. All rights reserved.
//

import Foundation
import SwiftTryCatch

@objc protocol CalculatorProtocol : class {
    @objc optional func updateOperationLabel( newValue: String )
    @objc optional func updateOperationFailed( newValue: String )
    @objc optional func resultFailed( newValue: String )
}

enum Number: Int, CaseIterable {
    case one   = 1
    case two   = 2
    case three = 3
    case four  = 4
    case five  = 5
    case six   = 6
    case seven = 7
    case eight = 8
    case nine  = 9
    case zero  = 0
    
    case eleven   = 11
    case thirteen = 13

    static func value(_ value: Number) -> Int {
        return value.rawValue
    }
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
    var activeOperation: Bool = false
    weak var delegate : CalculatorProtocol?
    
    let digits = CharacterSet.decimalDigits
    
    init(delegate: CalculatorProtocol ) { self.delegate = delegate }
    
    func getNumberToTag(tag: Int) -> String? {
        for number in Number.allCases {
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
        
        activeOperation = !activeOperation
        getResult()
        
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
                if beforeChar.description == specialCharacters.value(.rightParenthes){
                    value = specialCharacters.value(.leftParenthes)
                    break }
            }
            validateOperation( )
            return specialCharacters.value(.leftParenthes)
        case 2:
            validateOperation( )
            return specialCharacters.value(.rightParenthes)
        case 3:
            validateOperation( )
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
        activeOperation = false
        delegate?.updateOperationLabel!(newValue: operationInDisplay)
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
    
    func obtainMultiple(numberStr: String)-> TypeList? {
        guard let number = Int(numberStr) else { return TypeList.Stories }
        if number == Number.value(.zero) { return TypeList.Character }
        if (number % Number.value(.three))    == Number.value(.zero) { return TypeList.Comic }
        if (number % Number.value(.five))     == Number.value(.zero) { return TypeList.Comic }
        if (number % Number.value(.seven))    == Number.value(.zero) { return TypeList.Creators }
        if (number % Number.value(.eleven))   == Number.value(.zero) { return TypeList.Events }
        if (number % Number.value(.thirteen)) == Number.value(.zero) { return TypeList.Series }
        return TypeList.Stories
    }
    
    func runOperation(operation: String, returnResult: Bool) -> String? {
        let expression = NSExpression(format: operation)
        if let result = expression.expressionValue(with: nil, context: nil) as? NSNumber {
            return String(result.stringValue)
        }
        return nil
    }
    
    func validateOperation( returnResult: Bool = false){
        SwiftTryCatch.try ({
            let resultValue = self.runOperation(operation: self.operationInDisplay, returnResult: returnResult)!
            if returnResult || ( returnResult && !self.activeOperation ){
                self.operationInDisplay = resultValue
            }
            self.delegate?.updateOperationLabel!(newValue: self.operationInDisplay)
        }, catch: { (error) in
            if returnResult {
                self.delegate?.resultFailed!(newValue: self.operationInDisplay)
                return
            }
            self.delegate?.updateOperationFailed!(newValue: self.operationInDisplay )
        }, finallyBlock: { })
    }
}
