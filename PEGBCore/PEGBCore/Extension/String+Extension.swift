//
//  String+Extension.swift
//  PEGBCore
//
//  Created by Dat Giang on 25/02/2024.
//

import Foundation

public enum DateFormat: String {
    case iso8601DateFormat1 = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    case calendarFormat = "dd MMM, yyyy"
}

extension String {
    public func convertToDate(with format: DateFormat) -> Date? {
        self.convertToDate(with: format.rawValue)
    }
    
    public func convertToDate(with format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        return date
    }
    
    public func to(other format: DateFormat) -> String {
        let date = convertToDate(with: .iso8601DateFormat1)
        return date?.toString(by: format.rawValue) ?? ""
    }
}
