//
//  DateFormatter.swift
//  MyAnimeList
//
//  Created by William Wang on 2020-02-15.
//  Copyright © 2020 William Wang. All rights reserved.
//

import Foundation

extension String {
    subscript(_ range: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
        let end = index(startIndex, offsetBy: min(self.count, range.upperBound))
        return String(self[start..<end])
    }
    
    subscript(_ range: CountablePartialRangeFrom<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
        return String(self[start...])
    }
}

func dateFormat(date: String) -> String {
    let year = date[0..<4]
    var month = date[5..<7]
    let day = date[8..<10]
    
    switch month {
    case "01":
        month = "Jan"
    case "02":
        month = "Feb"
    case "03":
        month = "Mar"
    case "04":
        month = "Apr"
    case "05":
        month = "May"
    case "06":
        month = "Jun"
    case "07":
        month = "Jul"
    case "08":
        month = "Aug"
    case "09":
        month = "Sep"
    case "10":
        month = "Oct"
    case "11":
        month = "Nov"
    case "12":
        month = "Dec"
    default:
        month = "?"
    }
    
    return "\(month) \(day), \(year)"
}
