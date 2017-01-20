//
//  Date+JCDate.swift
//  JCSwiftKitDemo
//
//  Created by molin.JC on 2017/1/20.
//  Copyright © 2017年 molin. All rights reserved.
//

import Foundation

extension Date {
    var year: Int {
        get {
            return NSCalendar.current.component(Calendar.Component.year, from: self);
        }
    }
    
    var month: Int {
        get {
            return NSCalendar.current.component(Calendar.Component.month, from: self);
        }
    }
    
    var day: Int {
        get {
            return NSCalendar.current.component(Calendar.Component.day, from: self);
        }
    }
    
    var hour: Int {
        get {
            return NSCalendar.current.component(Calendar.Component.hour, from: self);
        }
    }
    
    var minute: Int {
        get {
            return NSCalendar.current.component(Calendar.Component.minute, from: self);
        }
    }
    
    var second: Int {
        get {
            return NSCalendar.current.component(Calendar.Component.second, from: self);
        }
    }
    
    var nanosecond: Int {
        get {
            return NSCalendar.current.component(Calendar.Component.nanosecond, from: self);
        }
    }
    
    var weekday: Int {
        get {
            return NSCalendar.current.component(Calendar.Component.weekday, from: self);
        }
    }
    
    var weekdayOrdinal: Int {
        get {
            return NSCalendar.current.component(Calendar.Component.weekdayOrdinal, from: self);
        }
    }
    
    var weekOfMonth: Int {
        get {
            return NSCalendar.current.component(Calendar.Component.weekOfMonth, from: self);
        }
    }
    
    var weekOfYear: Int {
        get {
            return NSCalendar.current.component(Calendar.Component.weekOfYear, from: self);
        }
    }
    
    var yearForWeekOfYear: Int {
        get {
            return NSCalendar.current.component(Calendar.Component.yearForWeekOfYear, from: self);
        }
    }
    
    var quarter: Int {
        get {
            return NSCalendar.current.component(Calendar.Component.quarter, from: self);
        }
    }
    
    /// 闰月
    var isLeapMonth: Bool {
        get {
            return DateComponents.init().isLeapMonth!;
        }
    }
    
    /// 闰年
    var isLeapYear: Bool {
        get {
            let year = self.year;
            return ((year % 400 == 0) || (year % 100 == 0) || (year % 4 == 0));
        }
    }
    
    /// 今天
    var isToday: Bool {
        get {
            if (fabs(self.timeIntervalSinceNow) >= Double(kDATE_DAY_SEC)) {
                return false;
            }
            return NSDate.init().day == self.day;
        }
    }
}
