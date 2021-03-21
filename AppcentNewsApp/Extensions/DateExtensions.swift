//
//  DateExtensions.swift
//  AppcentNewsApp
//
//  Created by Elif Parlak Kurt on 19.03.2021.
//

import Foundation

extension Date {
    func dateToString(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = dateFormatter.date(from: dateString) {
            let calendar = Calendar.current
            let dateCalendar = calendar.dateComponents([.day,.month,.year,.hour,.minute], from: date)
            return "\(dateCalendar.year ?? 0)-\(dateCalendar.month ?? 0)-\(dateCalendar.day ?? 0)   \(dateCalendar.hour ?? 0):\(dateCalendar.minute ?? 0)"
        }
        return ""
    }
}
