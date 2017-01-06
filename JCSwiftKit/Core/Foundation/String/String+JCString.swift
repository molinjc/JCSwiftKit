//
//  String+JCString.swift
//  JCSwiftKitDemo
//
//  Created by molin.JC on 2017/1/6.
//  Copyright © 2017年 molin. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func toNumber() -> NSNumber? {
        let number = NumberFormatter.init().number(from: self);
        return number;
    }
    
    func toInt() -> Int? {
        let number = self.toNumber();
        if (number != nil) {
            return number?.intValue;
        }
        return 0;
    }
    
    func toFloat() -> Float? {
        let number = self.toNumber();
        if (number != nil) {
            return number?.floatValue;
        }
        return 0;
    }
    
    func toBool() -> Bool? {        
        let number = self.toInt()!;
        if (number > 0) {
            return true;
        }
        
        let lowercased = self.lowercased()
        switch lowercased {
        case "true", "yes", "1":
            return true;
        case "false", "no", "0":
            return false;
        default:
            return false;
        }
    }
    
    /// UTF8StringEncoding编码转换成Data
    func dataUsingUTF8StringEncoding() -> Data? {
        return self.data(using: String.Encoding.utf8);
    }
    
    /// 获取当前的日期，格式为：yyyy-MM-dd HH:mm:ss
    static func dateString() -> String {
        return NSDate.init().string();
    }
    
    ///  获取当前的日期, 格式自定义
    func dateString(format: String) -> String {
        return NSDate.init().stringWithFormat(format: format);
    }
    
    /// 根据字体大小计算文本的Size
    func widthFor(font: UIFont) -> CGFloat {
        return self.sizeFor(font: font, size: CGSize.init(width: CGFloat(MAXFLOAT), height: CGFloat(MAXFLOAT))).width;
    }
    
    func heightFor(font: UIFont) -> CGFloat {
        return self.heightFor(font: font, width: CGFloat(MAXFLOAT));
    }
    
    func heightFor(font: UIFont, width: CGFloat) -> CGFloat {
        return self.sizeFor(font: font, size: CGSize.init(width: width, height: CGFloat(MAXFLOAT))).height;
    }
    
    func sizeFor(font: UIFont, size: CGSize) -> CGSize {
        return self.sizeFor(font: font, size: size, lineBreakMode: NSLineBreakMode.byWordWrapping);
    }
    
    /// 根据字体大小，所要显示的size，以及字段样式来计算文本的size
    ///
    /// - Parameters:
    ///   - font: 字体
    ///   - size: 所要显示的size
    ///   - lineBreakMode: 字段样式
    /// - Returns: CGSize大小
    func sizeFor(font: UIFont?, size: CGSize, lineBreakMode: NSLineBreakMode) -> CGSize {
        var cFont = font;
        if (cFont == nil) {
            cFont = UIFont.systemFont(ofSize: 15);
        }
        
        var attr = Dictionary<String, Any>.init();
        attr[NSFontAttributeName] = cFont;
        
        if (lineBreakMode != NSLineBreakMode.byWordWrapping) {
            let paragraphStyle = NSMutableParagraphStyle.init();
            paragraphStyle.lineBreakMode = lineBreakMode;
            attr[NSParagraphStyleAttributeName] = paragraphStyle;
        }
        let rect = (self as NSString).boundingRect(with: size, options: [NSStringDrawingOptions.usesLineFragmentOrigin, NSStringDrawingOptions.usesFontLeading], attributes: attr, context: nil);
        return rect.size;
    }
    
    /// 去掉头尾的空格
    func stringByTrimSpace() -> String {
        let set = CharacterSet.whitespacesAndNewlines;
        return self.trimmingCharacters(in: set);
    }
    
    
    /// 替换掉某个字符串
    ///
    /// - Parameters:
    ///   - replacement: 要替换成的字符串
    ///   - targets: 要被替换的字符串
    /// - Returns: String
    func stringReplacement(replacement: String, targets: String...) -> String? {
        var complete = self;
        for target in targets {
            complete = complete.replacingOccurrences(of: target, with: replacement);
        }
        return complete;
    }
    
    /// 是否包含某字符串
    func contain(ofString: String) -> Bool {
        return (self.range(of: ofString) != nil);
    }
    
    /// 根据正则表达式判断
    ///
    /// - Parameter format: 正则表达式的样式
    /// - Returns: Bool
    func evaluate(format: String) -> Bool {
        let predicate = NSPredicate.init(format: "SELF MATCHES %@", format);
        return predicate.evaluate(with: self);
    }
    
    /// 邮箱的正则表达式
    func regexpEmail() -> Bool {
        let format = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        return self.evaluate(format: format);
    }
    
    /// IP地址的正则表达式
    func regexpIp() -> Bool {
        let format = "((2[0-4]\\d|25[0-5]|[01]?\\d\\d?)\\.){3}(2[0-4]\\d|25[0-5]|[01]?\\d\\d?)"
        return self.evaluate(format: format);
    }
    
    /// HTTP链接 (例如 http://www.baidu.com )
    func regexpHTTP() -> Bool {
        let format = "([hH]ttp[s]{0,1})://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\-~!@#$%^&*+?:_/=<>.\',;]*)?"
        return self.evaluate(format: format);
    }
    
    /// UUID
    static func stringWithUUID() -> String {
        let uuid = CFUUIDCreate(nil);
        let str = CFUUIDCreateString(nil, uuid);
        return str as! String;
    }
    
    /// 判断是否是为整数
    func isPureInteger() -> Bool {
        let scanner = Scanner.init(string: self);
        var integerValue: Int?;
        return scanner.scanInt(&integerValue!)  && scanner.isAtEnd;
    }
    
    /// 判断是否为浮点数，可做小数判断
    func isPureFloat() -> Bool {
        let scanner = Scanner.init(string: self);
        var floatValue: Float?;
        return scanner.scanFloat(&floatValue!) && scanner.isAtEnd;
    }
    
    /// 输出格式：123,456；每隔三个就有","
    static func stringFormatterWithDecimal(number: NSNumber) -> String {
        return String.stringFormatter(style: NumberFormatter.Style.decimal, number: number);
    }
    
    ///  number转换百分比： 12,345,600%
    static func stringFormatterWithPercent(number: NSNumber) -> String {
        return String.stringFormatter(style: NumberFormatter.Style.percent, number: number);
    }
    
    /// 设置NSNumber输出的格式
    ///
    /// - Parameters:
    ///   - style: 格式
    ///   - number: NSNumber数据
    /// - Returns: String
    static func stringFormatter(style: NumberFormatter.Style, number: NSNumber) -> String {
        let formatter = NumberFormatter.init();
        formatter.numberStyle = style;
        return formatter.string(from: number)!;
    }
}
