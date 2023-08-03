//
//  Decimal+Utils.swift
//  Bankey
//
//  Created by Pin Lu on 8/10/23.
//

import Foundation

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal:self).doubleValue
    }
}
