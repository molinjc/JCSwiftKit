//
//  JCView.swift
//  JCSwiftKitDemo
//
//  Created by molin.JC on 2016/12/31.
//  Copyright © 2016年 molin. All rights reserved.
//

import UIKit

extension UIView {
    
    // frame.origin.x
    var x: CGFloat {
        set {
            var rect = self.frame;
            rect.origin.x = x;
            self.frame = rect;
        }
        
        get {
            return self.frame.origin.x;
        }
    }
    
    // frame.origin.y
    var y: CGFloat {
        set {
            var rect = self.frame;
            rect.origin.y = y;
            self.frame = rect;
        }
        
        get {
            return self.frame.origin.y;
        }
    }
    
    // frame.size.width
    var width: CGFloat {
        set {
            var rect = self.frame;
            rect.size.width = width;
            self.frame = rect;
        }
        
        get {
            return self.frame.size.width;
        }
    }
    
    // frame.size.height
    var height: CGFloat {
        set {
            var rect = self.frame;
            rect.size.height = height;
            self.frame = rect;
        }
        
        get {
            return self.frame.size.height;
        }
    }
    
    // frame.origin
    var origin: CGPoint {
        set {
            var rect = self.frame;
            rect.origin = origin;
            self.frame = rect;
        }
        
        get {
            return self.frame.origin;
        }
    }
    
    // frame.size
    var size: CGSize {
        set {
            var rect = self.frame;
            rect.size = size;
            self.frame = rect;
        }
        
        get {
            return self.frame.size;
        }
    }
    
    // center.x
    var centerX: CGFloat {
        set {
            var center = self.center;
            center.x = centerX;
            self.center = center;
        }
        
        get {
            return self.center.x;
        }
    }
    
    // center.y
    var centerY: CGFloat {
        set {
            var center = self.center;
            center.y = centerX;
            self.center = center;
        }
        
        get {
            return self.center.y;
        }
    }
    
    // frame.origin.x + frame.size.width
    var right: CGFloat {
        set {
            var rect = self.frame;
            rect.origin.x = right - rect.size.width;
            self.frame = rect;
        }
        
        get {
            return self.frame.origin.x + self.frame.size.width;
        }
    }
    
    //
    var bottom: CGFloat {
        set {
            var rect = self.frame;
            rect.origin.y = bottom - rect.size.height;
            self.frame = rect;
        }
        
        get {
            return self.frame.origin.y + self.frame.size.height;
        }
    }
    
    // 左间距
    var leftSpacing: CGFloat {
        set {
            self.x = leftSpacing;
        }
        
        get {
            return self.x;
        }
    }
    
    // 右间距
    var rightSpacing: CGFloat {
        set {
            self.width = (self.superview?.width)! - rightSpacing - self.x;
        }
        
        get {
            return (self.superview?.width)! - self.width - self.x;
        }
    }
    
    // 上间距
    var topSpacing: CGFloat {
        set {
            self.y = topSpacing;
        }
        
        get {
            return self.y;
        }
    }
    
    // 下间距
    var bottomSpacing: CGFloat {
        set {
            self.height = (self.superview?.height)! - bottomSpacing - self.y;
        }
        
        get {
            return (self.superview?.height)! - self.height - self.y;
        }
    }
}
