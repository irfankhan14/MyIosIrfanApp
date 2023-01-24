//
//  UtitlityDates.swift
//  Irfan Khan S
//
//  Created by Irfan Khan on 23/01/23.
//

import Foundation

class UtilityDates {
    

    func normalDateFormat() -> String {
        return Constants().TXT_DATE_FORMAT + " " + Constants().TXT_TIME_FORMAT
    }
    
    func plainDateFormat() -> String {
        return Constants().TXT_DATE_FORMAT.replacingOccurrences(of: "-", with: "") + Constants().TXT_TIME_FORMAT.replacingOccurrences(of: ":", with: "")
    }
    
    func convertDateFormat(fromPattern: String, toPattern: String, date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromPattern
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = toPattern
        return dateFormatter.string(from: date!)
    }
    
    func fetchCurrentTimestamp(pattern: String)-> String  {
        let date = Date()
        let dateFormattter = DateFormatter()
        dateFormattter.dateFormat = pattern
        return dateFormattter.string(from: date)
    }
    
    func convertDateToTimestamp(date: Date, pattern: String)-> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = pattern
        return dateFormatter.string(from: date)
    }
    
    func getFirstDayOfWeek(pattern: String)-> String {
        let now: Date = convertDateToLocalTime(Date())
        let startWeek = convertDateToLocalTime(now.startOfWeek!)
        return convertDateToTimestamp(date: startWeek, pattern: pattern)
    }
    
    func getLastDayOfWeek(pattern: String)-> String {
        let now: Date = convertDateToLocalTime(Date())
        let endOfWeek =  convertDateToLocalTime(now.endOfWeek!)
        return convertDateToTimestamp(date: endOfWeek, pattern: pattern)
    }
    
    private func convertDateToLocalTime(_ date: Date) -> Date {
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: date))
        return Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: date)!
    }
    
}


extension Date {
    var startOfWeek: Date? {
        let indian = Calendar(identifier: .indian)
        guard let startDay = indian.date(from: indian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return indian.date(byAdding: .day, value: 0, to: startDay)
    }

    var endOfWeek: Date? {
        let indian = Calendar(identifier: .indian)
            guard let startDay = indian.date(from: indian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
           return indian.date(byAdding: .day, value: 6, to: startDay)
       }
}
