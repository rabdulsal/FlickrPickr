//
//  DateFormatter+FlickrPickr.swift
//  FlickrPickr
//
//  Created by Rashad Abdul-Salam on 9/19/24.
//

import Foundation

extension DateFormatter {
    static func formattedPublishDate(_ dateStr: String) -> String {
        // Example date formatting
        let dateFormatter = ISO8601DateFormatter()
        if let fDate = dateFormatter.date(from: dateStr) {
            let outputFormatter = Self()
            outputFormatter.dateStyle = .medium
            return outputFormatter.string(from: fDate)
        }
        return dateStr
    }
}
