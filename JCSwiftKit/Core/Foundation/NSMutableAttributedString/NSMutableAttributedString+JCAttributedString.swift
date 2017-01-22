//
//  NSMutableAttributedString+JCAttributedString.swift
//  JCSwiftKitDemo
//
//  Created by molin.JC on 2017/1/20.
//  Copyright © 2017年 molin. All rights reserved.
//

import Foundation
import UIKit

extension NSMutableAttributedString {

    /// 字体
    func add(font: UIFont, range: NSRange) {
        self.addAttribute(NSFontAttributeName, value: font, range: range);
    }
    
    func add(font: UIFont) {
        self.add(font: font, range: StringRange(self));
    }
    
    /// 文本颜色
    func add(textColor: UIColor, range: NSRange) {
        self.addAttribute(NSForegroundColorAttributeName, value: textColor, range: range);
    }
    
    func add(textColor: UIColor) {
        self.add(textColor: textColor, range: StringRange(self));
    }
    
    /// 段落样式
    func add(paragraphStyle: NSParagraphStyle, range: NSRange) {
        self.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: range);
    }
    
    func add(paragraphStyle: NSParagraphStyle) {
        self.add(paragraphStyle: paragraphStyle, range: StringRange(self));
    }
    
    /// 下划线
    ///
    /// - Parameters:
    ///   - underlineStyle: 样式，值为NSNumber类型
    func add(underlineStyle: NSNumber, range: NSRange) {
        self.addAttribute(NSUnderlineStyleAttributeName, value: underlineStyle, range: range);
    }
    
    func add(underlineStyle: NSNumber){
        self.add(underlineStyle: underlineStyle, range: StringRange(self));
    }
    
    /// 下划线颜色
    func add(underlineColor: UIColor, range: NSRange) {
        self.addAttribute(NSUnderlineColorAttributeName, value: underlineColor, range: range);
    }
    
    func add(underlineColor: UIColor) {
        self.add(underlineColor: underlineColor, range: StringRange(self));
    }

    /// 链接
    ///
    /// - Parameters:
    ///   - linkAddress: 链接地址
    func add(linkAddress: String, range: NSRange) {
        self.addAttribute(NSLinkAttributeName, value: linkAddress, range: range);
    }
    
    func add(linkAddress: String) {
        self.add(linkAddress: linkAddress, range: StringRange(self));
    }
    
    /// 文本的背景颜色
    func add(backgroundColor: UIColor, range: NSRange) {
        self.addAttribute(NSBackgroundColorAttributeName, value: backgroundColor, range: range);
    }
    
    func add(backgroundColor: UIColor) {
        self.add(backgroundColor: backgroundColor, range: StringRange(self));
    }
    
    /// 字体阴影
    ///
    /// - Parameters:
    ///   - shadow: 阴影
    func add(shadow: NSShadow, range: NSRange) {
        self.addAttribute(NSShadowAttributeName, value: shadow, range: range);
    }
    
    func add(shadow: NSShadow) {
        self.add(shadow: shadow, range: StringRange(self));
    }

    /// 文件副本
    ///
    /// - Parameter textAttachment: 文件副本
    func add(textAttachment: NSTextAttachment) {
        let subAttributedString = NSAttributedString.init(attachment: textAttachment);
        self.append(subAttributedString);
    }
    
    /// 计算文本大小
    func sizeForAttribute(size: CGSize, lineBreakMode: NSLineBreakMode) -> CGSize {
        var width: CGFloat = 0.0;
        var height: CGFloat = 0.0;
        self.enumerateAttributes(in: NSRange.init(location: 0, length: self.string.characters.count), options: NSAttributedString.EnumerationOptions.reverse, using: {(attrs, range, stop) in
            let text = (self.string as NSString).substring(with: range);
            let font = attrs["NSFont"] as! UIFont?;
            let paragraphStyle = attrs["NSParagraphStyle"] as! NSParagraphStyle?;
            
            let textSize = text.sizeFor(font: font, size: size, lineBreakMode: lineBreakMode);
            if (paragraphStyle != nil) {
                height += (paragraphStyle?.paragraphSpacing)! + (paragraphStyle?.paragraphSpacingBefore)! * 1.5 + (paragraphStyle?.lineSpacing)!;
            }
            width += textSize.width;
            height += textSize.height;
        });
        
        return CGSize.init(width: width, height: height);
    }
    
    func sizeForAttribute(size: CGSize) -> CGSize {
        return self.sizeForAttribute(size: size, lineBreakMode: NSLineBreakMode.byWordWrapping);
    }
    
    func heightForAttribute(width: CGFloat) -> CGFloat {
        return self.sizeForAttribute(size: CGSize.init(width: width, height: CGFloat(MAXFLOAT))).height;
    }
    
    func heightForAttribute() -> CGFloat {
        return self.heightForAttribute(width: CGFloat(MAXFLOAT));
    }
    
    func widthForAttribute() -> CGFloat {
        return self.sizeForAttribute(size: CGSize.init(width: CGFloat(MAXFLOAT), height: CGFloat(MAXFLOAT))).width;
    }
}

func StringRange(_ attributedString: NSMutableAttributedString) -> NSRange {
    return NSRange.init(location: 0, length: attributedString.string.characters.count);
}
