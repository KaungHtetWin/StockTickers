//
//  DateAppExt.swift
//  StockTickers
//
//  Created by MgKaung on 13/06/2022.
//

import Foundation
extension Date {
    func toString(format: String = "yyyy-MM-dd hh:mm:ss a") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
extension DateFormatter {
    static let UTC: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}
