//
//  Date+Extension.swift
//  Memo app
//
//  Created by Kanghos on 2021/11/10.
//

import Foundation

extension DateFormatter {
    static var defaultFormat : DateFormatter {
        let date = DateFormatter()
        date.locale = Locale(identifier:"ko_KR")
        date.dateFormat = "yyyy.MM.dd a hh:mm"
        return date
    }
    
    static var todayFormat : DateFormatter {
        let date = DateFormatter()
        date.locale = Locale(identifier:"ko_KR")
        // 오전/오후 00:00
        date.dateFormat = "a hh:mm"
        return date
    }
    
    static var currentWeekFormat : DateFormatter{
        let date = DateFormatter()
        date.locale = Locale(identifier:"ko_KR")
        //요일만
        date.dateFormat = "EEE"
        return date
    }
}
