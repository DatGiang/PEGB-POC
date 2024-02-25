//
//  Date+Extension.swift
//  PEGBCore
//
//  Created by Dat Giang on 25/02/2024.
//

import Foundation

extension Date {
    public func toString(
        by format: String,
        timezone: TimeZone? = nil,
        locale: Locale? = nil
    ) -> String {
        let dateFormatter = DateFormatter()
        if let timezone = timezone {
            dateFormatter.timeZone = timezone
        }
        if let locale = locale {
            dateFormatter.locale = locale
        }
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
