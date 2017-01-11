//
//  CALayer+JCLayer.swift
//  JCSwiftKitDemo
//
//  Created by molin.JC on 2017/1/11.
//  Copyright © 2017年 molin. All rights reserved.
//

import UIKit

extension CALayer {
    
    var left: CGFloat {
        set {
            var frame = self.frame;
            frame.origin.x = left;
            self.frame = frame;
        }
        get {
            return self.frame.origin.x;
        }
    }
    
    var top: CGFloat {
        set {
            var frame = self.frame;
            frame.origin.y = top;
            self.frame = frame;
        }
        get {
            return self.frame.origin.y;
        }
    }
    
    var right: CGFloat {
        set {
            var frame = self.frame;
            frame.origin.x = right - frame.size.width;
            self.frame = frame;
        }
        get {
            return self.frame.origin.x + self.frame.size.width;
        }
    }
    
    var bottom: CGFloat {
        set {
            var frame = self.frame;
            frame.origin.y = bottom - frame.size.height;
            self.frame = frame;
        }
        get {
            return self.frame.origin.y + self.frame.size.height;
        }
    }
    
    var width: CGFloat {
        set {
            var frame = self.frame;
            frame.size.width = width;
            self.frame = frame;
        }
        get {
            return self.frame.size.width;
        }
    }
    
    var height: CGFloat {
        set {
            var frame = self.frame;
            frame.size.height = height;
            self.frame = frame;
        }
        get {
            return self.frame.size.height;
        }
    }
    
    var center: CGPoint {
        set {
            var frame = self.frame;
            frame.origin.x = center.x - frame.size.width * 0.5;
            frame.origin.y = center.y - frame.size.height * 0.5;
            self.frame = frame;
        }
        get {
            return CGPoint.init(x: self.centerX, y: self.centerY);
        }
    }
    
    var centerX: CGFloat {
        set {
            var frame = self.frame;
            frame.origin.x = centerX - frame.size.width * 0.5;
            self.frame = frame;
        }
        get {
            return self.frame.origin.x + self.frame.size.width * 0.5;
        }
    }
    
    var centerY: CGFloat {
        set {
            var frame = self.frame;
            frame.origin.y = centerY - frame.size.height * 0.5;
            self.frame = frame;
        }
        get {
            return self.frame.origin.y + self.frame.size.height * 0.5;
        }
    }
    
    var origin: CGPoint {
        set {
            var frame = self.frame;
            frame.origin = origin;
            self.frame = frame;
        }
        get {
            return self.frame.origin;
        }
    }
    
    var frameSize: CGSize {
        set {
            var frame = self.frame;
            frame.size = frameSize;
            self.frame = frame;
        }
        get {
            return self.frame.size;
        }
    }
    
    func removeAllSublayers() {
        while ((self.sublayers?.count) != nil) {
            self.sublayers?.last?.removeFromSuperlayer();
        }
    }
}
