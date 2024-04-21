//
//  Date+Ext.swift
//  DiffableDataSource
//
//  Created by Pin Lu on 4/16/24.
//

import Foundation

extension Date {
    
//    func convertToMonthYearFormat() -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MMM yyyy"
//        return dateFormatter.string(from: self)
//    }
//    
    
    func convertToMonthYearFormat() -> String {
        return formatted(.dateTime.month().year())
    }
}
