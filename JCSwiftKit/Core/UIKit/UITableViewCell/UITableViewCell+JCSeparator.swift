//
//  UITableViewCell+JCSeparator.swift
//  JCSwiftKitDemo
//
//  Created by molin.JC on 2017/1/12.
//  Copyright © 2017年 molin. All rights reserved.
//

import UIKit

/// 分割线枚举
///
/// - none: 无分割线
/// - full: 满行
/// - leftEmpty: 左边空出间距20
/// - rightEmpty: 右边空出间距20
/// - bothEmpty: 两边空出间距20
public enum JCSeparatorStyle: Int {
    case none = 0;
    case full;
    case leftEmpty;
    case rightEmpty;
    case bothEmpty;
}

var kCellSeparatorStyle = "cellSeparatorStyle";
var kLeftSpacing = "leftSpacing"
var kRightSpacing = "rightSpacing";


extension UITableViewCell {
    
    override var leftSpacing: CGFloat {
        set {
            objc_setAssociatedObject(self, kLeftSpacing, leftSpacing, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN);
        }
        
        get {
            let number = objc_getAssociatedObject(self, kLeftSpacing) as? CGFloat;
            if number == nil {
                return 20.0;
            }
            return number!;
        }
    }
    
    override var rightSpacing: CGFloat {
        set {
            objc_setAssociatedObject(self, kRightSpacing, rightSpacing, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN);
        }
        
        get {
            let number = objc_getAssociatedObject(self, kRightSpacing) as? CGFloat;
            if number == nil {
                return 20.0;
            }
            return number!;
        }
    }
    
    
    var cellSeparatorStyle: JCSeparatorStyle {
        set {
            objc_setAssociatedObject(self, kCellSeparatorStyle, cellSeparatorStyle, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN);
            
            if (UIDevice.current.systemVersion == "8.0") {
                self.layoutMargins = UIEdgeInsets.zero;
                self.preservesSuperviewLayoutMargins = false;
            }
            
            self.separatorInset = UIEdgeInsets.zero;
            switch cellSeparatorStyle {
            case .none:
                self.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.size.width);
                break;
            case .full:
                self.separatorInset = UIEdgeInsets.zero;
                break;
            case .leftEmpty:
                self.separatorInset = UIEdgeInsets.init(top: 0, left: self.leftSpacing, bottom: 0, right: 0);
                break;
            case .rightEmpty:
                self.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: self.rightSpacing);
                break;
            case .bothEmpty:
                self.separatorInset = UIEdgeInsets.init(top: 0, left: self.leftSpacing, bottom: 0, right: self.rightSpacing);
                break;
            }
        }
        
        get {
            let number = objc_getAssociatedObject(self, kCellSeparatorStyle) as! JCSeparatorStyle;
            return number;
        }
    }
    
    
}
