//
//  UITextField+JCTextField.swift
//  JCSwiftKitDemo
//
//  Created by molin.JC on 2017/1/15.
//  Copyright © 2017年 molin. All rights reserved.
//

import UIKit

extension UITextField {
    
    /// 设置Placeholder占位符的颜色
    func setPlaceholder(color: UIColor) {
        self.setValue(color, forKey: "placeholderLabel.textColor");
    }
    
    /// 设置文字左边留出的空白宽度
    func setContentPadding(left: CGFloat) {
        self.leftView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: left, height: self.frame.size.height));
        self.leftViewMode = UITextFieldViewMode.always;
    }
    
    /// 设置文字右边留出的空白宽度
    func setContentPadding(right: CGFloat) {
        self.rightView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: right, height: self.frame.size.height));
        self.rightViewMode = UITextFieldViewMode.always;
    }
    
    /// 选中所有文字
    func selectAllText() {
        let range = self.textRange(from: self.beginningOfDocument, to: self.endOfDocument);
        self.selectedTextRange = range;
    }
    
    /// 当前选中的字符串范围
    func currentSelectedRange() -> NSRange? {
        let beginning = self.beginningOfDocument;
        let selectedRange = self.selectedTextRange;
        let selectionStart = selectedRange?.start;
        let selectionEnd = selectedTextRange?.end;
        let location = self.offset(from: beginning, to: selectionStart!);
        let length = self.offset(from: selectionStart!, to: selectionEnd!);
        return NSRange.init(location: location, length: length);
    }
    
    /// 选中指定范围的文字
    func setSelectedRange(range: NSRange) {
        let beginning = self.beginningOfDocument;
        let startPosition = self.position(from: beginning, offset: range.location);
        let endPosition = self.position(from: beginning, offset: NSMaxRange(range));
        let selectionRange = self.textRange(from: startPosition!, to: endPosition!);
        self.selectedTextRange = selectionRange;
    }
}
