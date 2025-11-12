//
//  Date+Ect.swift
//  InstaDemo
//
//  Created by Rəşad Əliyev on 11/12/25.
//

import Foundation

extension Date {
    func showDate(dateString: String) -> String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        if let date = isoFormatter.date(from: dateString) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateFormat = "MMMM d"
            
            let formattedDate = displayFormatter.string(from: date)
            return formattedDate
        } else {
            return "Invalid date format"
        }
    }
    
    func showDate(shortDate: String) -> String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        guard let date = isoFormatter.date(from: shortDate) else {
            return "Invalid date format"
        }
        
        let now = Date()
        let diff = now.timeIntervalSince(date)
        
        let seconds = Int(diff)
        let minutes = seconds / 60
        let hours = minutes / 60
        let days = hours / 24
        let weeks = days / 7
        let months = days / 30
        let years = months / 365
        
        switch true {
        case seconds < 60:
            return "\(seconds)s"
        case minutes < 60:
            return "\(minutes)m"
        case hours < 24:
            return "\(hours)h"
        case days < 7:
            return "\(days)d"
        case weeks < 5:
            return "\(weeks)w"
        case months < 12:
            return "\(months)mo"
        default:
            return "\(years)y"
        }
    }
    
}
