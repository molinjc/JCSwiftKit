//
//  NSNumber+JCNumber.swift
//  JCSwiftKitDemo
//
//  Created by molin.JC on 2017/1/22.
//  Copyright © 2017年 molin. All rights reserved.
//

import Foundation

extension NSNumber {
    
    /// 根据字符串转换NSNumber
    class func number(string: String) -> NSNumber? {
        let str = string.stringByTrimSpace().lowercased();
        if str.length == 0 {
            return nil;
        }
        let dic: [String : Any?] = ["true": NSNumber.init(value: true),
                                     "yes": NSNumber.init(value: true),
                                   "false": NSNumber.init(value: false),
                                      "no": NSNumber.init(value: false),
                                     "nil": NSNull(),
                                    "null": NSNull(),
                                  "<null>": NSNull()];
        
        let num = dic[str];
        if (num != nil) {
            if (num is NSNull) {
                return nil;
            }
            return num as! NSNumber?;
        }
        return nil;
    }
    
    /// 设置String转换的格式
    ///
    /// - Parameters:
    ///   - style: 格式
    ///   - string: string要按照格式来
    /// - Returns: NSNumber
    class func numberFormatter(style: NumberFormatter.Style, string: String) -> NSNumber? {
        let formatter = NumberFormatter.init();
        formatter.numberStyle = style;
        return formatter.number(from: string);
    }
    
    /// 输出格式：123,456；每隔三个就有
    class func numberFormatterWithDecimal(string: String) -> NSNumber? {
        return NSNumber.numberFormatter(style: NumberFormatter.Style.decimal, string: string);
    }
    
    /// 百分比： 12,345,600%
    class func numberFormatterWithPercent(string: String) -> NSNumber? {
        return NSNumber.numberFormatter(style: NumberFormatter.Style.percent, string: string);
    }
    
    /// 一万一千一百一十一这样的格式转换成number
    class func numberFormatterWithSpellOut(string: String) -> NSNumber? {
        return NSNumber.numberFormatter(style: NumberFormatter.Style.spellOut, string: string);
    }
}
