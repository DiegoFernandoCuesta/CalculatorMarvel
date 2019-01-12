//
//  Utils.swift
//  Calculator
//
//  Created by Diego Fernando Cuesta Arevalo on 1/11/19.
//  Copyright © 2019 Diego Fernando Cuesta Arevalo. All rights reserved.
//

import Foundation

extension String {
    func format(_ params: CVarArg...) -> String {
        if params.isEmpty {
            return self
        }
        return String.init(format: self, arguments:params) as String
    }
}

class Utils { }
