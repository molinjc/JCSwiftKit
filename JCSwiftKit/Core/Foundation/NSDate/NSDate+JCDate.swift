//
//  NSDate+JCDate.swift
//  JCSwiftKitDemo
//
//  Created by molin.JC on 2017/1/4.
//  Copyright © 2017年 molin. All rights reserved.
//

import Foundation

extension NSDate {
    
    var year: NSInteger {
        get {
            return NSCalendar.current.component(Calendar.Component.year, from: self as Date);
        }
    }
    
    var month: NSInteger {
        get {
            return NSCalendar.current.component(Calendar.Component.month, from: self as Date);
        }
    }
    
    var day: NSInteger {
        get {
            return NSCalendar.current.component(Calendar.Component.day, from: self as Date);
        }
    }
    
    var hour: NSInteger {
        get {
            return NSCalendar.current.component(Calendar.Component.hour, from: self as Date);
        }
    }
    
    var minute: NSInteger {
        get {
            return NSCalendar.current.component(Calendar.Component.minute, from: self as Date);
        }
    }
    
    var second: NSInteger {
        get {
            return NSCalendar.current.component(Calendar.Component.second, from: self as Date);
        }
    }
    
    var nanosecond: NSInteger {
        get {
            return NSCalendar.current.component(Calendar.Component.nanosecond, from: self as Date);
        }
    }
    
    var weekday: NSInteger {
        get {
            return NSCalendar.current.component(Calendar.Component.weekday, from: self as Date);
        }
    }
    
    var weekdayOrdinal: NSInteger {
        get {
            return NSCalendar.current.component(Calendar.Component.weekdayOrdinal, from: self as Date);
        }
    }
    
    var weekOfMonth: NSInteger {
        get {
            return NSCalendar.current.component(Calendar.Component.weekOfMonth, from: self as Date);
        }
    }
    
    var weekOfYear: NSInteger {
        get {
            return NSCalendar.current.component(Calendar.Component.weekOfYear, from: self as Date);
        }
    }
    
    var yearForWeekOfYear: NSInteger {
        get {
            return NSCalendar.current.component(Calendar.Component.yearForWeekOfYear, from: self as Date);
        }
    }
    
    var quarter: NSInteger {
        get {
            return NSCalendar.current.component(Calendar.Component.quarter, from: self as Date);
        }
    }
    
    var isLeapMonth: Bool {
        get {
            return DateComponents.init().isLeapMonth!;
        }
    }
    
    var isLeapYear: Bool {
        get {
            let year = self.year;
            return ((year % 400 == 0) || (year % 100 == 0) || (year % 4 == 0));
        }
    }
    
    
    class func dateWithString(stringDate: String) -> NSDate? {
        return NSDate.dateWithString(stringDate: stringDate, format: "yyyy-MM-dd HH:mm:ss");
    }
    
    class func dateWithString(stringDate: String, format: String) -> NSDate? {
        let formatter = DateFormatter.init();
        formatter.locale = NSLocale.current;
        formatter.dateFormat = format;
        return formatter.date(from: stringDate) as NSDate?;
    }
}
