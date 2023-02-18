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
        let fromDateFormatter = DateFormatter()
        fromDateFormatter.dateFormat = fromPattern
        
        let fromDate = fromDateFormatter.date(from: date)!
        fromDateFormatter.dateFormat = toPattern
        
        let result = fromDateFormatter.string(from: fromDate)
        return result
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
    
    func differenceBetweenDates(fromDate: String, toDate : String, pattern: String) -> String {
        let dateString1 = fromDate
        let dateString2 = toDate

        let Dateformatter = DateFormatter()
        Dateformatter.dateFormat = pattern

        let date1 = Dateformatter.date(from: dateString1)
        let date2 = Dateformatter.date(from: dateString2)


        let distanceBetweenDates: TimeInterval? = date2?.timeIntervalSince(date1!)
        let secondsInAnHour: Double = 3600
        let minsInAnHour: Double = 60
        let secondsInDays: Double = 86400
        let secondsInMonths : Double = 2592000
        let secondsInYears : Double = 31104000

        let minBetweenDates = Int((distanceBetweenDates! / minsInAnHour))
        let hoursBetweenDates = Int((distanceBetweenDates! / secondsInAnHour))
        let daysBetweenDates = Int((distanceBetweenDates! / secondsInDays))
        let monthsbetweenDates = Int((distanceBetweenDates! / secondsInMonths))
        let yearbetweenDates = Int((distanceBetweenDates! / secondsInYears))
        let secbetweenDates = Int(distanceBetweenDates!)


        var result = ""
        if yearbetweenDates > 0 {
            result = String(yearbetweenDates) + " " + NSLocalizedString("txt_years", comment: "") + " " + NSLocalizedString("txt_ago", comment: "")
        } else if monthsbetweenDates > 0 {
            result = String(monthsbetweenDates) + " " + NSLocalizedString("txt_months", comment: "") + " " + NSLocalizedString("txt_ago", comment: "")
        } else if daysBetweenDates > 0 {
            result = String(daysBetweenDates) + " " + NSLocalizedString("txt_days", comment: "") + " " + NSLocalizedString("txt_ago", comment: "")
        } else if hoursBetweenDates > 0 {
            result = String(hoursBetweenDates) + " " + NSLocalizedString("txt_hours", comment: "") + " " + NSLocalizedString("txt_ago", comment: "")
        } else if minBetweenDates > 0 {
            result = String(minBetweenDates) + " " + NSLocalizedString("txt_minutes", comment: "") + " " + NSLocalizedString("txt_ago", comment: "")
        } else if secbetweenDates > 0 {
            result = String(secbetweenDates) + " " + NSLocalizedString("txt_seconds", comment: "") + " " + NSLocalizedString("txt_ago", comment: "")
        }
        
        return result
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
