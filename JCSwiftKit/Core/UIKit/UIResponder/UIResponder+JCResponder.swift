//
//  UIResponder+JCResponder.swift
//  JCSwiftKitDemo
//
//  Created by molin.JC on 2017/1/1.
//  Copyright © 2017年 molin. All rights reserved.
//

import UIKit

var firstResponder: UIResponder?;

extension UIResponder {

    /// 获取当前第一响应者
    class func currentFirstResponder() -> Any? {
        firstResponder = nil;
        UIApplication.shared.sendAction(#selector(UIResponder.findCurrentFirstResponder(sender:)), to: nil, from: nil, for: nil);
        return firstResponder;
    }
    
    func findCurrentFirstResponder(sender: Any) {
        firstResponder = self;
    }
}
